{creddump, fetchFromGitHub, ...}:

creddump.overrideAttrs(_: {
  name = "creddump7";
  version = "2020-10-02";
  src = fetchFromGitHub {
    owner = "CiscoCXSecurity";
    repo = "creddump7";
    rev = "dcfbb6ab7d2692ad2321058cf4bb02146819d0a4";
    sha256 = "vM4E0lLKUIznDnl9BuNeHJmf3Fdf+pyUgs7uM5JmD7U=";
  };
})
