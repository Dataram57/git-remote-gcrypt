{
    description = "git-remote-gcrypt (dr57 fork) with renamed command";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs }:
    let
        systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
        forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
        packages = forAllSystems (system:
        let
            pkgs = import nixpkgs { inherit system; };
        in
        {
            default = pkgs.stdenv.mkDerivation rec {
            pname = "git-remote-gcrypt-dr57";
            version = "1.5"; # change if your fork diverges
            rev = version;

            src = pkgs.fetchFromGitHub {
                owner = "dr57";               # ← CHANGE IF NEEDED
                repo = "git-remote-gcrypt";   # or your fork repo name
                inherit rev;
                sha256 = "sha256-uy6s3YQwY/aZmQoW/qe1YrSlfNHyDTXBFxB6fPGiPNQ=";
            };

            outputs = [ "out" "man" ];

            nativeBuildInputs = [
                pkgs.docutils
                pkgs.makeWrapper
            ];

            installPhase = ''
                runHook preInstall

                prefix="$out" ./install.sh

                # Rename the installed command
                mv "$out/bin/git-remote-gcrypt" \
                    "$out/bin/git-remote-gcrypt-dr57"

                wrapProgram "$out/bin/git-remote-gcrypt-dr57" \
                --prefix PATH ":" "${
                    pkgs.lib.makeBinPath [
                    pkgs.gnupg
                    pkgs.curl
                    pkgs.rsync
                    pkgs.coreutils
                    pkgs.gawk
                    pkgs.gnused
                    pkgs.gnugrep
                    ]
                }"

                runHook postInstall
            '';

            meta = with pkgs.lib; {
                homepage = "https://github.com/dr57/git-remote-gcrypt";
                description = "Git remote helper for GPG-encrypted remotes (dr57 fork)";
                license = licenses.gpl3;
                platforms = platforms.unix;
                mainProgram = "git-remote-gcrypt-dr57";
            };
            };
        }
        );

        apps = forAllSystems (system: {
            default = {
                type = "app";
                program = "${self.packages.${system}.default}/bin/git-remote-gcrypt-dr57";
            };
        });
    };
}
