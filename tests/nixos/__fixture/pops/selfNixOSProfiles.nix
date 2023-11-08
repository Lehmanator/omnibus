(super.nixosProfiles.addLoadExtender {
  load = {
    src = ../__nixosProfiles;
    loader = haumea.loaders.scoped;
    type = "nixosProfiles";
    inputs = {
      omnibus = {
        nixosProfiles = super.nixosProfiles.outputs.nixosProfiles;
        data = super.data.exports.default;
      };
    };
  };
}).addExporters
  [ (POP.extendPop flops.haumea.pops.exporter (_self: _super: { })) ]
