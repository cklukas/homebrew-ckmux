# Homebrew tap for ckmux

Install [ckmux](https://github.com/cklukas/ckmux), a terminal multiplexer with
persistent sessions and a visible desktop interface:

```sh
brew install cklukas/ckmux/ckmux
ckmux --version
ckmux
```

Upgrade an existing installation:

```sh
brew update
brew upgrade ckmux
```

The formula builds ckmux and its pinned ckVision dependency from release
sources. The same formula is generated, built, installed, and tested by the
[ckmux release workflow](https://github.com/cklukas/ckmux/actions/workflows/release.yml).

[User guide](https://cklukas.github.io/ckmux/) ·
[Release downloads](https://github.com/cklukas/ckmux/releases/latest) ·
[Changes](https://github.com/cklukas/ckmux/blob/main/CHANGES.md)
