{
  description = "dangreco/comp321 environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          pkgs,
          ...
        }:

        let
          ghcSet = pkgs.haskell.packages.ghc98;
          __zed = pkgs.writeTextFile {
            name = "zed-settings";
            text = builtins.toJSON {
              lsp = {
                hls = {
                  binary = {
                    path = "${ghcSet.haskell-language-server}/bin/haskell-language-server";
                    arguments = [ "lsp" ];
                  };
                };
                ty = {
                  binary = {
                    path = "${pkgs.ty}/bin/ty";
                    arguments = [ "server" ];
                  };
                };
              };
              languages = {
                Python = {
                  language_servers = [
                    "!pylsp"
                    "!pyright"
                    "!basedpyright"
                    "ty"
                  ];
                  formatter = {
                    external = {
                      command = "${pkgs.ruff}/bin/ruff";
                      arguments = [
                        "format"
                        "--stdin-filename"
                        "{buffer_path}"
                      ];
                    };
                  };
                };
              };
            };
            destination = "/settings.json";
          };
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              pkg-config
              openssl
              zlib
            ];

            nativeBuildInputs = with pkgs; [
              # base
              git
              nil
              nixd
              nixfmt
              just
              act

              # haskell
              ghcSet.ghc
              pkgs.stack
              ghcSet.haskell-language-server
              pkgs.hlint

              # c
              gcc14
              glibc.static
              clang-tools
              gdb

              # python
              ty
              ruff
              python313
            ];

            shellHook = ''
                rm -rf .zed
                mkdir -p .zed
              cp ${__zed}/settings.json .zed/settings.json
            '';
          };
        };
    };
}
