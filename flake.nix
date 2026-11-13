{
  description = "ATV Desktop Remote Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        nodejs = pkgs.nodejs_22;
        
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            nodejs
            pkgs.nodePackages.pnpm
            pkgs.python3
            pkgs.pnpm
            # Add any other build dependencies here
          ];

          shellHook = ''
            echo "Node.js version: $(node --version)"
            echo "pnpm version: $(pnpm --version)"
            
            # Install Node.js dependencies if node_modules doesn't exist
            if [ ! -d "node_modules" ]; then
              echo "Installing Node.js dependencies..."
              pnpm install
            fi
          '';
        };
      }
    );
}
