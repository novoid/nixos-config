{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [

    geeqie
    gimp-with-plugins
    jhead
    gpsprune
    exif
    fbida
    exiftool
    exiv2
    geoipWithDatabase
    imagemagick
    inkscape-with-extensions
    # inkscape # already covered by inkscape-with-extensions
    #libsForQt514.marble  # 2023-06-05: marble-22.08.3 is broken
    ditaa
    graphviz

  ];

}
