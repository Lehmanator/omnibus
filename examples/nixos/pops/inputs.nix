(POS.loadInputs.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (self: super: { })
)).setSystem
  "x86_64-linux"
