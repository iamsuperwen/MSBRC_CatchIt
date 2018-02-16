#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

static const std::string OPENCV_WINDOW = "Image window";

class ImageConverter
{
  ros::NodeHandle nh_;
  image_transport::ImageTransport it_;
  image_transport::Subscriber image_sub_rgb;
  image_transport::Subscriber image_sub_d;
  image_transport::Publisher image_pub_;
  ///cv::Point2f g_pointOfInterest;  //global variable?

public:
  ImageConverter(): it_(nh_)
  {
    // Subscrive to input video feed and publish output video feed
    image_sub_rgb = it_.subscribe("/kinect2/sd/image_color_rect", 1, &ImageConverter::rgbCb, this);
    ///image_sub_d = it_.subscribe("/kinect2/qhd/image_depth_rect", 1, &ImageConverter::depthCb, this);
    image_pub_ = it_.advertise("/image_converter/output_video", 1);

    cv::namedWindow(OPENCV_WINDOW);
  }

  ~ImageConverter()
  {
    cv::destroyWindow(OPENCV_WINDOW);
  }

  void rgbCb(const sensor_msgs::ImageConstPtr& msg)
  {
    cv_bridge::CvImagePtr cv_ptr;
    try
    {
      cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
    }
    catch (cv_bridge::Exception& e)
    {
      ROS_ERROR("cv_bridge exception: %s", e.what());
      return;
    }


    // *** rgbImg processing: find red ball ***
    cv::Mat hsvImg;   
    cv::cvtColor(cv_ptr->image, hsvImg, CV_BGR2HSV);

    /* //---Red---
    cv::Mat1b mask1, mask2;
    cv::inRange(hsvImg, cv::Scalar(0, 50, 100), cv::Scalar(5, 255, 255), mask1);
    cv::inRange(hsvImg, cv::Scalar(175, 50, 100), cv::Scalar(180, 255, 255), mask2);
    cv::Mat1b mask = mask1 | mask2; */

    //---Yellow---
    cv::Mat1b mask;
    cv::inRange(hsvImg, cv::Scalar(20, 100, 100), cv::Scalar(30, 255, 255), mask);

    cv::erode(mask, mask, cv::Mat());
    cv::dilate(mask, mask, cv::Mat());
    
    std::vector< std::vector< cv::Point > > contours;
    std::vector<cv::Vec4i> hierarchy;
    cv::findContours(mask, contours, hierarchy, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_SIMPLE, cv::Point(0, 0) );

    /// Get the moments:
    std::vector<cv::Moments> mu(contours.size() );
    for( int i = 0; i < contours.size(); i++ ){
        mu[i] = cv::moments( contours[i], false );
    }    
    ///  Get the mass centers:
    std::vector<cv::Point2f> mc( contours.size() );
    std::vector<cv::Point2f> center( contours.size() );
    std::vector<float> radius( contours.size() );
    for( int i = 0; i < contours.size(); i++ ){
        mc[i] = cv::Point2f( mu[i].m10/mu[i].m00 , mu[i].m01/mu[i].m00 );
        minEnclosingCircle(contours[i], center[i], radius[i]);
    }
    /// Draw circles:
    for( int i = 0; i< contours.size(); i++ ){
        if(radius[i] > 10){
            cv::circle( cv_ptr->image, mc[i], 3, CV_RGB(255,255,255) );
            cv::circle( cv_ptr->image, center[i], radius[i], CV_RGB(255,0,0) );
            ///ROS_INFO("Radius: %f", radius[i]);

            image_sub_d = it_.subscribe("/kinect2/sd/image_depth_rect", 1, boost::bind(&ImageConverter::depthCb, this, _1, center[i]) );
            ///g_pointOfInterest = center
        }
     }

    
    ///image_sub_d = it_.subscribe("/kinect2/qhd/image_depth_rect", 1, &ImageConverter::depthCb, this);
    

    // Draw an example circle on the video stream
    /*if (cv_ptr->image.rows > 20 && cv_ptr->image.cols > 330)
      cv::circle(cv_ptr->image, cv::Point(240, 320), 10, CV_RGB(255,0,0));*/

    // Update GUI Window
    cv::imshow(OPENCV_WINDOW, cv_ptr->image);
    cv::waitKey(3);

    // Output modified video stream
    image_pub_.publish(cv_ptr->toImageMsg());
  }

  void depthCb(const sensor_msgs::ImageConstPtr& msg, cv::Point2f pointOfInterest)
  {
    cv_bridge::CvImagePtr cv_ptr;
    try
    {
      cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::TYPE_16UC1);//now cv_ptr is the matrix, do not forget "TYPE_" before "16UC1"
    }
    catch (cv_bridge::Exception& e)
    {
      ROS_ERROR("cv_bridge exception: %s", e.what());
      return;
    }

    float depth = cv_ptr->image.at<ushort>(pointOfInterest);  //you can change 240,320 to your interested pixel
    ROS_INFO("(%f,%f)\tDepth: %f", pointOfInterest.x, pointOfInterest.y, depth);
    
  }

};

int main(int argc, char** argv)
{
  ros::init(argc, argv, "image_converter");
  ImageConverter ic;
  ros::spin();
  return 0;
}
