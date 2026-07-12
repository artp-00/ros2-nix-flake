# https://github.com/lopsided98/nix-ros-overlay
{
  # WARNING: This flake is very heavy and takes a lot of time and a lot of RAM (20Gb) to evaluate itself.
  inputs = {
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs";
  };
  
  outputs = { self, nix-ros-overlay, nixpkgs }:
    nix-ros-overlay.inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix-ros-overlay.overlays.default ];
        };

        # shell to use when launching the shell, "default" will use your system's configured shell
        ROS_FLAKE_SHELL = "default";

        rosEnv = pkgs.rosPackages.jazzy.buildEnv {
          paths = with pkgs.rosPackages.jazzy; [
            ros-core
            ros2bag
            ament-cmake
            ament-cmake-core
            rclcpp
            turtlesim
            rosidlcpp
            python-cmake-module
            rviz2
            ros2-control
            ros2-controllers
            joint-state-publisher
            joint-state-publisher-gui
            robot-state-publisher

            # rqt related packages
            rqt
            rqt-gui
            rqt-plot
            rqt-console
            rqt-srv
            rqt-msg
            rqt-bag
            rqt-graph

            # gazebo packages
            ros-gz
            gz-ros2-control
            # gz-ros2-control-demos

            # urdf and xml packages
            urdf
            xacro
          ];
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "ROS2 dev flake";
          
          packages = [
            pkgs.colcon
            rosEnv
          ];

          ROS_DOMAIN_ID = 0;
          ROS_LOCALHOST_ONLY = 0;

          shellHook = ''
            export CMAKE_PREFIX_PATH="${rosEnv}:$CMAKE_PREFIX_PATH";
            ${if ROS_FLAKE_SHELL == "default" then "" else "env ${ROS_FLAKE_SHELL}; exit"}
          '';
        };
      });

  nixConfig = {
    extra-substituters = [ "https://ros.cachix.org" ];
    extra-trusted-public-keys = [ "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=" ];
  };
}
