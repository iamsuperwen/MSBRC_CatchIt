# Install script for directory: /home/catchme/ros/workspaces/catch_ws/src/tum_ics_ur10_controller_tutorial

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/catchme/ros/workspaces/catch_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/catchme/ros/workspaces/catch_ws/build/tum_ics_ur10_controller_tutorial/catkin_generated/installspace/tum_ics_ur10_controller_tutorial.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tum_ics_ur10_controller_tutorial/cmake" TYPE FILE FILES
    "/home/catchme/ros/workspaces/catch_ws/build/tum_ics_ur10_controller_tutorial/catkin_generated/installspace/tum_ics_ur10_controller_tutorialConfig.cmake"
    "/home/catchme/ros/workspaces/catch_ws/build/tum_ics_ur10_controller_tutorial/catkin_generated/installspace/tum_ics_ur10_controller_tutorialConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tum_ics_ur10_controller_tutorial" TYPE FILE FILES "/home/catchme/ros/workspaces/catch_ws/src/tum_ics_ur10_controller_tutorial/package.xml")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/tum_ics_ur10_controller_tutorial" TYPE DIRECTORY FILES "/home/catchme/ros/workspaces/catch_ws/src/tum_ics_ur10_controller_tutorial/include/tum_ics_ur10_controller_tutorial/")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmy_robot_control_lli.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmy_robot_control_lli.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmy_robot_control_lli.so"
         RPATH "/opt/ros/kinetic/lib:/usr/lib/tumtools")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/catchme/ros/workspaces/catch_ws/devel/lib/libmy_robot_control_lli.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmy_robot_control_lli.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmy_robot_control_lli.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmy_robot_control_lli.so"
         OLD_RPATH "/opt/ros/kinetic/lib:/usr/lib/tumtools:"
         NEW_RPATH "/opt/ros/kinetic/lib:/usr/lib/tumtools")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libmy_robot_control_lli.so")
    endif()
  endif()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/tum_ics_ur10_controller_tutorial/testSimpleEffortCtrl" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/tum_ics_ur10_controller_tutorial/testSimpleEffortCtrl")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/tum_ics_ur10_controller_tutorial/testSimpleEffortCtrl"
         RPATH "/home/catchme/ros/workspaces/catch_ws/devel/lib:/opt/ros/kinetic/lib:/usr/lib/tumtools")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/tum_ics_ur10_controller_tutorial" TYPE EXECUTABLE FILES "/home/catchme/ros/workspaces/catch_ws/devel/lib/tum_ics_ur10_controller_tutorial/testSimpleEffortCtrl")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/tum_ics_ur10_controller_tutorial/testSimpleEffortCtrl" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/tum_ics_ur10_controller_tutorial/testSimpleEffortCtrl")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/tum_ics_ur10_controller_tutorial/testSimpleEffortCtrl"
         OLD_RPATH "/home/catchme/ros/workspaces/catch_ws/devel/lib:/opt/ros/kinetic/lib:/usr/lib/tumtools:"
         NEW_RPATH "/home/catchme/ros/workspaces/catch_ws/devel/lib:/opt/ros/kinetic/lib:/usr/lib/tumtools")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/tum_ics_ur10_controller_tutorial/testSimpleEffortCtrl")
    endif()
  endif()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tum_ics_ur10_controller_tutorial/launch" TYPE DIRECTORY FILES "/home/catchme/ros/workspaces/catch_ws/src/tum_ics_ur10_controller_tutorial/launch/")
endif()

