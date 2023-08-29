# The OSRF rosdep repository

The goal of this repository is to provide ROS helpers for using "non default configurations" of ROS and Gazebo. The installation of this repository will make possible:

 1. Use rosdep to resolve Gazebo libraries not in rosdistro index.
 1. Redefine rosdep keys affecting Gazebo packages to point to alternative binaries.

Most of ROS users probably don't need this repository at all or only the point 1 above. Reading what is a non default configuration is important to understand when this repository is needed.

## What is a non default configuration

Non default configurations are those that use a different Gazebo (former Ignition) than the one defined in the [REP 2000](https://www.ros.org/reps/rep-2000.html).

Default configuration: users of Gazebo versions defined in REP 2000 don't need to use this repository (i.e: users of Gazebo Fortress on ROS 2 Humble).
Default Users of the "non default configuraton" of running Gazebo Garden on ROS 2 Humble will need to use this repository.

[Documentation on choosing the Gazebo and ROS combination](https://gazebosim.org/docs/latest/ros_installation) provides the whole context on this topic.

## 1. Use rosdep to resolve Gazebo libraries

Gazebo distributions are usually added to rosdistro (see [Gazebo Citadel/Fortress PR](https://github.com/ros/rosdistro/pull/34177)) so this repository is not required.
The only missing Gazebo distributions available in this repository are `Gazebo Garden` and `Gazebo Harmonic`

### Installing rosdep rules to resolve Gazebo Garden/Harmonic libraries

```bash
sudo bash -c 'wget https://raw.githubusercontent.com/osrf/osrf-rosdep/master/gz/00-gazebo.list -O /etc/ros/rosdep/sources.list.d/00-gazebo.list'
rosdep update
# check that resolve works
rosdep resolve gz-garden
# alternatively
rosdep resolve gz-harmonic
```

## 2. Redefine rosdep keys affecting Gazebo packages to point to alternative binaries

This repository has been used to help with redefinition of Gazebo rosdep keys when alternative binary packages were built to support "non default configurations".
The alternative binary packages use a different name than the ones hosted in ROS repository so if they are in use inside a given ROS distributions, the user probably probably want the rosdep keys resolve to the new names.

Example of this using Gazebo Garden and ros_gz:
 * A ROS 2 Humble/Iron user requires Gazebo Garden instead of the officially support Gazebo Fortress
 * The ROS repository has `ros-humbe-ros-gz*` or `ros-iron-ros-gz*` for Gazebo Fortress packages
 * Alternatives packages for Gazebo Garden were built and hosted in `packages.osrfoundation.org` named `ros-humble-ros-gzgarden-*` or `ros-iron-ros-gzgarden-*`
 * Support and instructions for renaming are in #12

**Note:** wait until the official release of Harmonic
Example of this using Gazebo Harmonic and ros_gz:
 * A ROS 2 Humble/Iron user requires Gazebo Harmonic instead of the officially support Gazebo Fortress
 * The ROS repository has `ros-humbe-ros-gz*` or `ros-iron-ros-gz*` for Gazebo Fortress packages
 * Alternatives packages for Gazebo Harmonic were built and hosted in `packages.osrfoundation.org` named `ros-humble-ros-gzgarden-*` or `ros-iron-ros-gzgarden-*`
 * Support and instructions for renaming are in #16

The decission of building unofficial Gazebo binaries is made by the Gazebo simulation team. There are currently no alternative packages of any Gazebo distribution supported at this time.
