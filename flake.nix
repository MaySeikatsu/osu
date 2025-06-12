{
  description = "osu! game development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
  nixpkgs.config = {
      allowUnfree = true;               # Allow unfree packages
      allowUnsupportedSystem = true;    # Allow unsupported SystemPackages
    };
       devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # .NET SDK
            dotnet-sdk_8
            
            # Graphics libraries
            libGL
            libGLU
            mesa
            mesa.drivers
            
            # NVIDIA support
            linuxPackages.nvidia_x11
            
            # Vulkan support
            vulkan-loader
            vulkan-tools
            vulkan-headers
            
            # SDL2 and related
            SDL2
            SDL2_mixer
            SDL2_image
            SDL2_ttf
            
            # Audio libraries
            alsa-lib
            libpulseaudio
            
            # X11 libraries (for window management)
            xorg.libX11
            xorg.libXext
            xorg.libXrandr
            xorg.libXi
            xorg.libXcursor
            xorg.libXinerama
            
            # Additional development tools
            pkg-config
            git
            
            # Graphics debugging tools
            mesa-demos
            glxinfo
            vulkan-tools
          ];

          shellHook = ''
            export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
              pkgs.libGL
              pkgs.libGLU
              pkgs.mesa.drivers
              pkgs.vulkan-loader
              pkgs.SDL2
              pkgs.alsa-lib
              pkgs.libpulseaudio
              pkgs.xorg.libX11
              pkgs.xorg.libXext
              pkgs.xorg.libXrandr
              pkgs.xorg.libXi
              pkgs.xorg.libXcursor
              pkgs.xorg.libXinerama
            ]}:$LD_LIBRARY_PATH
            
            # Ensure .NET can find native libraries
            export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
            
            # Graphics driver path
            export LIBGL_DRIVERS_PATH=${pkgs.mesa.drivers}/lib/dri
            
            echo "osu! development environment loaded!"
            echo "Run 'dotnet run --project osu.Desktop' to start the game"
          '';
        };
      });
}
