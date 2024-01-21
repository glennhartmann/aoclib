{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-compat, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        aoclib = pkgs.buildGoModule {
          pname = "aoclib";
          version = "v0.0.6";
          src = builtins.path { path = ./.; name = "aoclib"; };
          vendorHash = "sha256-WVWxbWhEpON9Gy9FuZbFkosK6lDJZk2NbZ0RaNVeLoU=";
        };
      in
      {
        packages = {
          inherit aoclib;
          default = aoclib;
        };
      }
    );
}
