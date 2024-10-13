{
  description = "Prodlog";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    utils.url = "github:numtide/flake-utils";
    hugo-terminal = {
      url = "github:panr/hugo-theme-terminal";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, hugo-terminal, ... }:
    utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {

          packages.hugo-blog = pkgs.stdenv.mkDerivation rec {
            name = "hugo-blog";
            src = self;
            configurePhase = ''
              mkdir -p "themes/terminal"
              cp -r ${hugo-terminal}/* "themes/terminal"
            '';
            buildPhase = ''
              ${pkgs.hugo}/bin/hugo --minify
            '';
            installPhase = "cp -r public $out";
          };

          packages.default = self.packages.${system}.hugo-blog;

          apps = rec {
            build = utils.lib.mkApp { drv = pkgs.hugo; };
            serve = utils.lib.mkApp {
              drv = pkgs.writeShellScriptBin "hugo-serve" ''
                ${pkgs.hugo}/bin/hugo server -D
              '';
            };
            default = serve;
          };

          devShells.default =
            pkgs.mkShell {
              buildInputs = [ pkgs.hugo ];
              shellHook = ''
                mkdir -p themes
                ln -sn "${hugo-terminal}" "themes/terminal"
              '';
            };
        });
}
