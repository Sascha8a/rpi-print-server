{ pkgs, ... }:
let
  ptouch = pkgs.callPackage ./ptouch.nix { };
in
{
  nixpkgs.crossSystem.system = "aarch64-linux";

  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];

  environment.systemPackages = with pkgs; [
    cups
    ptouch
  ];

  system.stateVersion = "23.11";
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Vienna";
  console.keyMap = "de";

  networking.hostName = "robo4you-label-printer";

  hardware.printers = {
    ensurePrinters = [
      {
        name = "robo4you-label-printer";
        location = "Home";
        deviceUri = "usb://Brother/QL-500?serial=J8Z393619";
        model = "ptouch-driver/Brother-QL-500-ptouch-ql.ppd.gz";
        ppdOptions = {
          PageSize = "17x54mm";
          PrintQuality = "High";
          MediaType = "Labels";
        };
      }
    ];
    ensureDefaultPrinter = "robo4you-label-printer";
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  services.printing = {
    enable = true;
    drivers = [ ptouch ];
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
  };
}
