{
  description = "Home Portal Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python313
            uv
            bun
            postgresql_17
            process-compose
          ];

          env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.stdenv.cc.cc.lib
            pkgs.zlib
          ];

          shellHook = ''
            export PGDATA="$PWD/.postgres/data"
            export PGHOST="$PWD/.postgres"
            export PGDATABASE="homeportal"

            if [ ! -d "backend/.venv" ]; then
              echo "Creating Python virtual environment..."
              uv venv backend/.venv
            fi

            echo "Syncing Python dependencies..."
            uv sync --project backend --quiet

            source backend/.venv/bin/activate

            if [ -f "backend/.env" ]; then
              set -a
              source backend/.env
              set +a
            fi

            if [ -f "web/.env" ]; then
              set -a
              source web/.env
              set +a
            fi

            echo ""
            echo "Home Portal dev environment ready!"
            echo "  Run 'process-compose' to start all services"
            echo ""
          '';
        };
      }
    );
}
