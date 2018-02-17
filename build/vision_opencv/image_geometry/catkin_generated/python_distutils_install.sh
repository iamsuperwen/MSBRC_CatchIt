#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/catchme/ros/workspaces/catch_ws/src/vision_opencv/image_geometry"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/catchme/ros/workspaces/catch_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/catchme/ros/workspaces/catch_ws/install/lib/python2.7/dist-packages:/home/catchme/ros/workspaces/catch_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/catchme/ros/workspaces/catch_ws/build" \
    "/usr/bin/python" \
    "/home/catchme/ros/workspaces/catch_ws/src/vision_opencv/image_geometry/setup.py" \
    build --build-base "/home/catchme/ros/workspaces/catch_ws/build/vision_opencv/image_geometry" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/catchme/ros/workspaces/catch_ws/install" --install-scripts="/home/catchme/ros/workspaces/catch_ws/install/bin"
