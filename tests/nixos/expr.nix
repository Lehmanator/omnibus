{
  super,
  trace,
  lib,
}:
let
  out = super.pops.layouts.default.layouts;
  extraHomeModule = m: {
    home-manager.users.admin = {
      imports = lib.flatten m;
    };
  };
in
{
  bootProfile =
    (out.nixosConfiguration [
      out.outputs.nixosProfiles.customProfiles.presets.boot
    ]).config.boot.__profiles__;

  customModuleBootTimeOut =
    (out.nixosConfiguration [
      out.outputs.nixosModules.customModules.boot
      {
        config.boot.__profiles__.speedup = true;
        config.boot.__profiles__.systemd-boot.enable = true;
      }
    ]).config.boot.loader.timeout;

  hyprland =
    (out.nixosConfiguration [
      out.outputs.nixosModules.customModules.boot
      (extraHomeModule [
        out.outputs.homeProfiles.customProfiles.presets.hyprland.default
        out.outputs.homeProfiles.default.presets.firefox
      ])
    ])
    .config.home-manager.users.admin.wayland.windowManager.hyprland.__profiles__;
}
// lib.optionalAttrs trace {
  nixosConfiguration = out.nixosConfiguration [
    out.outputs.nixosProfiles.default.presets.boot
    out.outputs.nixosProfiles.default.presets.nickel
  ];

  homeConfiguration =
    (out.nixosConfiguration [
      out.outputs.nixosProfiles.default.presets.boot
      # (extraHomeModule [
      #   out.outputs.homeProfiles.customProfiles.presets.hyprland.default
      #   out.outputs.homeProfiles.default.presets.firefox
      # ])
    ]).config.home-manager.users.admin;
}