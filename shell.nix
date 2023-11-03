{ stdenv, pkgs, lib }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    go-task
    mkcert
    k3d
    kubectl
    vault
    hostctl
    tasksh
    jq
  ];
  GOROOT="${pkgs.go}/share/go";

  shellHook = ''
  '';
}
