{ config, lib, pkgs, ... }:

let
  isT495s = ''   test -r /sys/class/dmi/id/product_name &&  grep -q "ThinkPad T495s" /sys/class/dmi/id/product_name '';
in
{
  options.t495sFix.enable = lib.mkEnableOption "ThinkPad T495s i8042/Alt glitch fix";

  config = lib.mkIf config.t495sFix.enable {
    services.fwupd.enable = true;

    # Using the channel kernel (stable if stable chanel)
    boot.kernelPackages = pkgs.linuxPackages;

    # Core fixes; extend only if needed
    boot.kernelParams = lib.mkBefore [
      "i8042.nomux"
      "i8042.reset"
      # "i8042.nopnp"
      # "atkbd.reset"
      # "psmouse.elantech_smbus=0"
    ];

    services.libinput.enable = true;

    # Reconnect KBD (serio0) and AUX (serio1) at boot
    systemd.services.t495s-i8042-reconnect = {
      description = "ThinkPad T495s: reconnect i8042 KBD/AUX (boot)";
      wantedBy = [ "multi-user.target" ];
      after = [ "basic.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "t495s-i8042-reconnect.sh" ''
          if ${isT495s}; then
            for dev in /sys/bus/serio/devices/serio0 /sys/bus/serio/devices/serio1; do
              [ -w "$dev/drvctl" ] && echo -n reconnect > "$dev/drvctl" || true
            done
          fi
        '';
      };
    };

    # Reconnect again on resume (sleep/wake can trigger the bug)
    systemd.services.t495s-i8042-reconnect-resume = {
      description = "ThinkPad T495s: reconnect i8042 KBD/AUX (resume)";
      wantedBy = [ "sleep.target" ];
      after = [ "sleep.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "t495s-i8042-reconnect-resume.sh" ''
          if ${isT495s}; then
            for dev in /sys/bus/serio/devices/serio0 /sys/bus/serio/devices/serio1; do
              [ -w "$dev/drvctl" ] && echo -n reconnect > "$dev/drvctl" || true
            done
          fi
        '';
      };
    };
  };
}
