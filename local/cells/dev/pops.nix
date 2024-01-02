# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT
let
  inherit (inputs) nixpkgs;
  inputs' = (inputs.omnibus.pops.flake.setSystem nixpkgs.system).inputs;
  inherit (inputs.omnibus.pops.self.load.inputs) POP flops;
in
{
  omnibus = {
    devshellProfiles = inputs.omnibus.pops.devshellProfiles.addLoadExtender {
      load.inputs.inputs = inputs';
    };
    configs = inputs.omnibus.pops.configs {
      inputs = {
        inputs = {
          inherit (inputs') nixfmt nur;
          inherit (inputs) std;
          inherit nixpkgs;
        };
      };
    };
  };
}
