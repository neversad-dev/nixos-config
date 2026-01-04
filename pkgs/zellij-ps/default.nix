{
  lib,
  fish,
  fd,
  fzf,
  makeWrapper,
  zellij,
  fetchFromGitea,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "zellij-ps";
  version = "0.1.0";

  src = fetchFromGitea {
    domain = "code.m3tam3re.com";
    owner = "m3tam3re";
    repo = "helper-scripts";
    rev = "d30382d8692399d952a1aacbdb77e6ab87ba046d";
    sha256 = "0zrl8089qj14gwn9k3b73vnw2zn48f9yh9w0qbh8g8mb171sxyaj";
  };

  buildInputs = [];
  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin
    cp zellij-ps.fish $out/bin/zellij-ps
    wrapProgram $out/bin/zellij-ps \
      --prefix PATH : ${lib.makeBinPath [fish fd fzf zellij]}
  '';
  meta = with lib; {
    description = "A small project script for zellij";
    homepage = "https://code.m3tam3re.com/m3tam3re/helper-scripts";
    license = licenses.mit;
    maintainers = with maintainers; [m3tam3re];
    platforms = platforms.unix;
  };
}
