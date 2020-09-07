{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    name = "thesis";
    buildInputs = [
        pkgs.python27
        pkgs.gnumake42
        pkgs.texlive.combined.scheme-full
        pkgs.rubber
    ];
}