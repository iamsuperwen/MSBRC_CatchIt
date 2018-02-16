#!/usr/bin/env python
import rospy
import numpy as np
import math
from sensor_msgs.msg import CompressedImage, Image
from cv_bridge import CvBridge, CvBridgeError
import cv2
import sys
import time

class ballPos(object):
    def __init__(self):

        #cv
        self.bridge = CvBridge()
          
        # Publicaiton
        self.Publisher = rospy.Publisher("~image_with_red", Image, queue_size=1)
        self.Subscriber = rospy.Subscriber("/kinect2/sd/image_color_rect", CompressedImage, queue_size=1)
        print "ccc"
        self.cbPose(Image)

    def cbPose(self, image_msg):
        
        narr = np.fromstring(image_msg.data, np.uint8)
        image = cv2.imdecode(narr, cv2.CV_LOAD_IMAGE_COLOR)

##############################################################################################
	# define the lower and upper boundaries of the "green"
	# greenLower = (29, 86, 6)
	# greenUpper = (64, 255, 255)

	# define the lower and upper boundaries of the "red"

	redLower1 = (0, 50, 100) #~
	redUpper1 = (5, 255, 255) #~
	redLower2 = (175, 50, 100) #~
	redUpper2 = (180, 255, 255) #~
	hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
	print "aaa"
 
	# construct a mask for the color "green", then perform
	# a series of dilations and erosions to remove any small
	# blobs left in the mask
	mask = cv2.inRange(hsv, redLower1, redUpper1) + cv2.inRange(hsv, redLower2, redUpper2) #~
	mask = cv2.erode(mask, None, iterations=2)
	mask = cv2.dilate(mask, None, iterations=2)

	
	# find contours in the mask and initialize the current
	# (x, y) center of the ball
	cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,	cv2.CHAIN_APPROX_SIMPLE)[-2]
	center = None

	radius = 0
 
	# only proceed if at least one contour was found
	if len(cnts) > 0:
		# find the largest contour in the mask, then use
		# it to compute the minimum enclosing circle and
		# centroid
		c = max(cnts, key=cv2.contourArea)
		((x, y), radius) = cv2.minEnclosingCircle(c)
		M = cv2.moments(c)
		center = (int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"]))
		 
		# only proceed if the radius meets a minimum size
		if radius > 50:
			# draw the circle and centroid on the frame, (=image)
			# then update the list of tracked points
			
			#cv2.circle(mask, (int(x), int(y)), int(radius),(255, 255, 255), 2)
			
			cv2.circle(image, (int(x), int(y)), int(radius),(0, 255, 255), 2)
			cv2.circle(image, center, 5, (0, 0, 255), -1)
			#print "center: %f, %f" % (x,y)

			#h=np.size(image,0)
			#w=np.size(image,1)
			#print "h x w = %d x %d" % (h,w)
##############################################################################################


        image_msg_out = self.bridge.cv2_to_imgmsg(image, "bgr8")
        image_msg_out.header.stamp = image_msg.header.stamp
        self.pub_image_original.publish(image_msg_out)

if __name__ == "__main__":
    rospy.init_node("ball_positioning",anonymous=False)
    ball_pos_node = ballPos()
    rospy.spin()
