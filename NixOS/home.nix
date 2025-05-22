# Home-Manager
  
{ config, pkgs, ... }: {

  home.stateVersion = "24.11"; # Match your NixOS version
  programs.home-manager.enable = true;

  # You can start adding configurations here later, like:
    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
      };
    };

    dconf.settings = {
     "org/gnome/desktop/interface" = {
     color-scheme = "prefer-dark";
     };
    };

    programs.btop = {
     enable = true;
     settings = {
       color_theme = "/home/anirudh/.config/btop/themes/catppuccin_mocha.theme";
       truecolor = true;
       theme_background = false;
     };
   };

   programs.cava = {
     enable = true;
     catppuccin = {
       enable = true;
       flavor = "mocha";
     };
   };


}
