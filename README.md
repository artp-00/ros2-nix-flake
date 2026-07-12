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
