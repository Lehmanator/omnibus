(omnibus.loadInputs.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      selfInputs = omnibus.loadInputs.setInitInputs ./__lock;
    in
    {
      inputs = {
        nixpkgs = inputs.nixpkgs.legacyPackages;
      } // selfInputs.outputs;
    }
  )
))