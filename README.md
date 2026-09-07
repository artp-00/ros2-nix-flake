# ros2-nix-flake
Basic flake to setup a ros2 developpment environment using nix flake.

# Install

1. Clone the repository
2. Launch the shell using:
```bash
nix develop
```

# Notes

If you want your lsp to work you need to generate `compile_commands.json` with:
```bash
colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

Also note that ROS2 and its associated packages are very heavy and will take a (very) long time to compile (took me a few hours).
To partially resolve this you can instead use pre packaged binaries.
To do this add this to your `nix.conf`:

```
extra-substituters = https://attic.iid.ciirc.cvut.cz/ros
substituters = https://cache.nixos.org https://ros.cachix.org
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=
extra-trusted-public-keys = ros:JR95vUYsShSqfA1VTYoFt1Nz6uXasm5QrcOsGry9f6Q=
```

or this to your `configuration.nix`:

```
nix.settings.substituters = [
        "https://ros.cachix.org"
        "https://attic.iid.ciirc.cvut.cz/ros"
      ];

      trusted-public-keys = [
        "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
        "ros:JR95vUYsShSqfA1VTYoFt1Nz6uXasm5QrcOsGry9f6Q="
      ];
```

Also dont forget to add yourself to trusted nix users.

I also suggest adding packages one by one as you go instead of compiling everything all at once.

# References
- https://github.com/lopsided98/nix-ros-overlay
