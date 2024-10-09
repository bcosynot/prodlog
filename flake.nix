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
            buildInputs = [ pkgs.git pkgs.nodePackages.prettier ];
            configurePhase = ''
              mkdir -p "themes/terminal"
              cp -r ${hugo-terminal}/* "themes/terminal"
              sed -i -e 's/enableGitInfo = true/enableGitInfo = false/' hugo.toml
            '';
            buildPhase = ''
              ${pkgs.hugo}/bin/hugo
              ${pkgs.nodePackages.prettier}/bin/prettier -w public '!**/*.{js,css}'
            '';
            installPhase = "cp -r public $out";
          };

          defaultPackage = self.packages.${system}.hugo-blog;

          apps = rec {
            hugo = utils.lib.mkApp { drv = pkgs.hugo; };
            default = hugo;
          };

          devShell =
            pkgs.mkShell {
                buildInputs = [ pkgs.nixpkgs-fmt pkgs.hugo ];
                shellHook = ''
                            mkdir -p themes
                            ln -sn "${hugo-terminal}" "themes/terminal"
                          '';
            };
        });
}
