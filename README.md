# Dotfiles

This repository contains the configuration managed by [chezmoi](https://www.chezmoi.io/), plus a Homebrew bundle for setting up a Mac.

Tracked files currently include:

- `dot_Brewfile` → `~/.Brewfile`
- `dot_omp/private_agent/private_config.yml` → `~/.omp/agent/config.yml`

The Brewfile is kept as a hidden global Brewfile. Use `brew bundle --global` to install it. OMP runtime data, caches, sessions, locks, and credentials are not tracked.

## Getting started on a fresh Mac

### 1. Install Apple's command-line tools

```sh
xcode-select --install
```

If macOS reports that they are already installed, continue.

### 2. Install Homebrew

Install Homebrew from [brew.sh](https://brew.sh/). Follow the installer instructions, including the step that adds Homebrew to your shell's `PATH`.

Confirm that it is available:

```sh
brew --version
```

### 3. Install chezmoi and apply the repository

```sh
brew install chezmoi
chezmoi init --apply https://github.com/florianheeg/dotfiles.git
```

This places the tracked configuration files in their home-directory locations.

### 4. Install the Homebrew bundle

```sh
brew bundle --global
```

This installs the taps, formulae, casks, and other dependencies listed in `~/.Brewfile`.

### 5. Restart your shell

Open a new terminal or reload your shell configuration so newly installed tools are available.

## Updating an existing Mac

Pull and apply the latest repository state:

```sh
chezmoi update
brew bundle --global
```

Review changes before applying them manually with:

```sh
chezmoi diff
chezmoi apply
```

## Updating the Brewfile

Create a new snapshot of the software currently installed through Homebrew:

```sh
brew bundle dump --global --force
chezmoi add ~/.Brewfile
```

Review the resulting source change before committing it:

```sh
chezmoi diff
```

## Editing configuration

Edit a managed destination file through chezmoi:

```sh
chezmoi edit ~/.omp/agent/config.yml
```

Then inspect and apply the change:

```sh
chezmoi diff
chezmoi apply
```

## Commit and publish changes

The chezmoi source directory is a normal Git repository. From this directory:

```sh
git status
git add README.md dot_Brewfile dot_omp
git commit -m "Update dotfiles"
git push
```
