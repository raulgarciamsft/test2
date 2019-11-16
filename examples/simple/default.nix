{ stdenv, nix-gitignore, cmake, test2 }:
stdenv.mkDerivation {
  pname = "test2-sdk";
  version = "0.0.1";

  nativeBuildInputs = [ cmake test2 ];

  enableParallelBuilding = true;

  doCheck = true;

  src = nix-gitignore.gitignoreSourcePure ["*.nix" ../../.gitignore] ./.;
}
