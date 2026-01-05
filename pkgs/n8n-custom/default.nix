{
  fetchFromGitHub,
  fetchPnpmDeps,
  n8n,
}:
n8n.overrideAttrs (oldAttrs: rec {
  pname = oldAttrs.pname;
  version = "2.1.5";

  src = fetchFromGitHub {
    owner = "n8n-io";
    repo = "n8n";
    rev = "n8n@${version}";
    hash = "sha256-/MPY3j/2I3CgX5rRhzj3v7bHjaQEDMNnkVfk3taCrYA=";
  };

  pnpmDeps = fetchPnpmDeps {
    inherit pname version src;
    fetcherVersion = 3;
    hash = "sha256-LUPrJhCy+BUNRwUF+RVSSGRDCM5Vpesw6LYAZnTZhng=";
  };
})
