{
  description = "The Asio v. 1.10.8 C++ library for asynchronous network programming";

  inputs = {
    nixpkgs.url     = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { 
	  self, 
	  nixpkgs, 
	  flake-utils,
  }: flake-utils.lib.eachDefaultSystem
	     (system:
           let
          	pkgs = import nixpkgs { inherit system; };
          	version = "1.10.8";
          	sha256 = "0jgdl4fxw0hwy768rl3lhdc0czz7ak7czf3dg10j21pdpfpfvpi6";
      	  	packageName = "asio-library";
           in {
             packages.${packageName} = 
        	    pkgs.stdenv.mkDerivation {
        	      pname = "asio";
                inherit version;
                
                src = pkgs.fetchurl {
                  url = "mirror://sourceforge/asio/asio-${version}.tar.bz2";
                  inherit sha256;
                };
      
                buildInputs = [ pkgs.openssl ];
                propagatedBuildInputs = [ pkgs.boost ];
      
        	      meta = with pkgs.lib; {
                  homepage = "http://asio.sourceforge.net/";
                  description = "Cross-platform C++ library for network and low-level I/O programming";
                  license = licenses.boost;
                  platforms = platforms.unix;
                };
          	  };

            defaultPackage = self.packages.${system}.${packageName};
        }
    );
}
