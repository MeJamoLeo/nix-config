{pkgs, ...}:
{
  home = rec { # recでAttribute Set内で他の値を参照できるようにする
    username="bbb";
    homeDirectory = "/home/${username}"; # 文字列に値を埋め込む
    stateVersion = "22.11";
  };
  programs.home-manager.enable = true; # home-manager自身でhome-managerを有効化

   home.packages = with pkgs; [
   bat
   eza
   ripgrep
   lazygit
 ];

  programs.neovim.enable = true;
  programs.git.enable = true;


  xsession.windowManager.i3 = {
	  enable = true;
	  package = pkgs.i3-gaps;
	  config = {
		  modifier = "Mod4";
		  gaps = {
			  inner = 10;
			  outer = 5;
		  };
	  };
  };
}
