{
  omnibus,
  POP,
  flops,
  lib,
  inputs',
}:
let
  system = "x86_64-linux";
  inputs =
    let
      loadInputs = omnibus.pops.loadInputs.setInitInputs ./__lock;
    in
    ((loadInputs.addInputsExtender (
      POP.lib.extendPop flops.lib.flake.pops.inputsExtender (
        self: super: {
          inputs = {
            nixpkgs = loadInputs.outputs.nixpkgs.legacyPackages;
          };
        }
      )
    )).setSystem
      system
    ).outputs;

  flakePartsProfiles =
    (omnibus.pops.evalModules.flake-parts.loadProfiles.addLoadExtender {
      load = {
        inputs = {
          inherit (inputs) nixpkgs;
          inputs = {
            inherit (inputs) chinookDb;
          };
        };
      };
    }).layouts.default.process-compose;

  mkFlake =
    inputs.flake-parts.lib.mkFlake
      {
        inputs = inputs // {
          # fake self argument to make sure that the flake is
          self = inputs'.self;
        };
      }
      {
        systems = [ system ];
        imports = [ inputs.process-compose-flake.flakeModule ];
        perSystem =
          { selfModule', ... }: { imports = [ flakePartsProfiles.sqlite-example ]; };
      };
in
lib.mapAttrs (_: builtins.unsafeDiscardStringContext) {
  example = mkFlake.packages.${system}.sqlite-example;
}
