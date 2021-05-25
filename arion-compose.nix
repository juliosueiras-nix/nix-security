
{
  services.kongServer = { pkgs, ... }: {
    nixos.useSystemd = true;

    nixos.configuration = {
      boot.tmpOnTmpfs = true;
    };
    service.useHostStore = true;
    service.ports = [
    ];
  };
}
