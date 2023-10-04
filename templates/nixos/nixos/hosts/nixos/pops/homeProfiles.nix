(self'.lib.nixos.loadHomeProfiles.addLoadExtender { inputs = { }; })
.addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customProfiles = self.outputs.__extenders [ {
          value =
            { selfModule' }:
            selfModule' (
              m:
              dmerge m {
                wayland.windowManager.hyprland.__profiles__ = {
                  nvidia = true;
                };
              }
            );
          path = [
            "presets"
            "hyprland"
          ];
        } ];
      }
    ))
  ]
