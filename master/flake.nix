{
  description = ''Simple extensible implementation of Porter stemmer algorithm'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-porter-master.flake = false;
  inputs.src-porter-master.owner = "iourinski";
  inputs.src-porter-master.ref   = "refs/heads/master";
  inputs.src-porter-master.repo  = "porter";
  inputs.src-porter-master.type  = "github";
  
  inputs."mutableseqs".owner = "nim-nix-pkgs";
  inputs."mutableseqs".ref   = "master";
  inputs."mutableseqs".repo  = "mutableseqs";
  inputs."mutableseqs".type  = "github";
  inputs."mutableseqs".inputs.nixpkgs.follows = "nixpkgs";
  inputs."mutableseqs".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-porter-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-porter-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}