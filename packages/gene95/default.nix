{ stdenv, bash, nkf, gnugrep }:
let
  geneFile = "gene.txt";
in
stdenv.mkDerivation {
  name = "gene95";

  src = builtins.fetchurl {
    url    = http://www.namazu.org/%7Etsuchiya/sdic/data/gene95.tar.gz;
    sha256 = "0ci6gqazaklxhyzrmfaf82krn4qzq1yl0k8qa09g3rad28w1phw0";
  };

  setSourceRoot = "sourceRoot=`pwd`";

  installPhase = ''
    mkdir $out
    ${nkf}/bin/nkf -w ${geneFile} > $out/${geneFile}
    install -Dm444 readme.txt  -t $out

    mkdir $out/bin
    cat >> $out/bin/gene95 << EOF
    #!${bash}/bin/bash
    ${gnugrep}/bin/grep \$1 $out/${geneFile} -A 1 -wi --color
    EOF
    chmod a+x $out/bin/gene95
  '';
}
