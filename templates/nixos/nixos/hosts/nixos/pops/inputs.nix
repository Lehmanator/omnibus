(self'.lib.inputs.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      selfInputs = omnibus.loadInputs.setInitInputs ../__lock;
    in
    {
      inputs = { } // selfInputs.outputs;
    }
  )
)).setSystem
  root.nixos.layouts.system