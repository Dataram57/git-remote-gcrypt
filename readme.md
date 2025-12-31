# git-remote-gcrypt-dr57

This is a fork of [git-remote-gcrypt](https://github.com/spwhitton/git-remote-gcrypt) tool that puts absolute stealth on top of the hierarchy of goals. By stealth I mean "fitting in", and not necessearly anonymity.

Please read the old [readme](./old_README.rst) for more details and instructions.

## Important changes

- remote urls now must use `gcrypt-dr57::` instead of `gcrypt::`.

## Feauters

- Pushes now use the current timestamp and locally defined user name(`remote.$NAME.gcrypt-commituser`) and email(`remote.$NAME.gcrypt-commitemail`).
- Custom `Manifestfile` name defined in the remote url:
    - Scheme: `gcrypt-dr57::REMOTE_URL#MANIFEST_FILE_NAME#`.
    - Scheme with specific branch: `gcrypt-dr57::REMOTE_URL#MANIFEST_FILE_NAME#BRANCHNAME`.
    - Example: `gcrypt-dr57::https://github.com/Dataram57/test#my_manifest_file#my_branch_name#`. Note that you must
    - Example with specific branch: `gcrypt-dr57::https://github.com/Dataram57/test#my_manifest_file#my_branch_name`.
    - ***Note that if branch name is not meant to be specified make sure `#` is also at the end of the url (enables compatibility with main source)***

## Installation

### Default

* use your GNU/Linux distribution's package manager -- Debian, Ubuntu, Fedora, Arch and some smaller distros are known to have packages

* run the supplied ``install.sh`` script on other systems

### Nix Package

```nix
inputs = {
    git-remote-gcrypt-dr57.url = "github:Dataram57/git-remote-gcrypt-dr57/PLEASE_PUT_SPECIFIC_COMMIT_HASH_HERE";
    # ... other channels ...
};

# ... stuff...

outputs = inputs @ { ..., git-remote-gcrypt-dr57 , ... }: #...

# ... stuff...

home.packages = [       # or `environment.systemPackages`
    git-remote-gcrypt-dr57.packages.${pkgs.system}.git-mirror_tracker
    # ... other packages
]

```