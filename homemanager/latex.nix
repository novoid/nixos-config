{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [

    ## LaTeX
    texlive.combined.scheme-full
    # biber  ## already in texlive.combined.scheme-full
    # ghostscript  ## already in texlive.combined.scheme-full
    # psutils  ## already in texlive.combined.scheme-full
    gv
    biblatex-check
    latex2html
    pstoedit
    dot2tex
    xfig
    ghostscript_headless # used for ps2pdf (for INSO slides)

  ];

}
