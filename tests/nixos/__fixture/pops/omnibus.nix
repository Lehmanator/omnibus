(omnibus.pops.self.addLoadExtender {
  load.inputs = {
    inputs = inputs;
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      _self: _super: { exports.customProfiles = { }; }
    ))
  ]
