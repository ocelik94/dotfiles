{
  pkgs,
  lib,
  config,
  user,
  theme,
  ...
}: let
  cfg = config.modules.programs.brave;
in
  with lib; {
    options.modules.programs.brave = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable brave browser";
      };
    };

    config = mkIf cfg.enable {
      programs.chromium = {
        enable = true;
        package = pkgs.brave;		
        extensions = [
	  {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
          {id = "jofbglonpbndadajbafmmaklbfbkggpo";} # bing Chat on all browsers
          {id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";} # 1password
          {id = "dhdgffkkebhmkfjojejmpbldmpobfkfo";} # tampermonkey
        ];
      };
    };
  }
