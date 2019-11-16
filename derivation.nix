{ stdenv, nix-gitignore, cmake, doxygen, pythonPackages }:
stdenv.mkDerivation {
  pname = "test-2";
  version = "0.0.1";

  nativeBuildInputs = with pythonPackages; [ cmake doxygen sphinx breathe ];

  cmakeFlags = "-DBUILD_DOCUMENTATION=ON";

  enableParallelBuilding = true;

  doCheck = true;

  src = nix-gitignore.gitignoreSource ["*.nix"] ./.;
}
