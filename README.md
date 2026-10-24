# Purin's Dotfiles

Recently I set up my personal-computer development environment to more strongly resemble that of my work-computer, since there's a lot of small utilities, configurations, and aliases that I am used to. While it wasn't a particularly painful process, it still was more tedious and time-consuming than I would've liked. So to avoid having to do this every time I change machines, I thought it would be nice to keep them in a `dotfiles` repo. So it's mostly just for me. I don't think I'm so important that people want to copy my dotfiles, lol

## Layout

Each top-level folder is a [Stow](https://www.gnu.org/software/stow/) package that mirrors the path of its files under `~`.

```
.
├── .gitignore
├── ghostty
│   └── .config
│       └── ghostty
│           └── config.ghostty
├── git
│   └── .gitconfig
├── README.md
├── tmux
│   └── .tmux.conf
└── zsh
    ├── .p10k.zsh
    ├── .zprofile
    └── .zshrc
```

## Installing

Order of the steps matters.

1. Install [Homebrew](https://brew.sh/) (also installs Xcode command line tools, which include Git).

2. Clone the repo (`<directory>`):
```shell
git clone https://github.com/MelancholyPurin/dotfiles.git <directory>
cd <directory>
```

3. Install core packages (Git, Stow, tmux, tmuxinator, Ghostty, VS Code and a few CLI tools):
```shell
brew bundle
```
Optionally, install everything else (dev toolchains, apps, VS Code extensions):
```shell
brew bundle --file=Brewfile.extras
```

4. Install oh-my-zsh, Powerlevel10k (needs a [Nerd Font](https://www.nerdfonts.com/) for icons), TPM and the Catppuccin tmux theme:
```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```

5. Remove the files the installers just created, since Stow refuses to overwrite real files. *(Back up first if they hold anything important.)*
```shell
rm ~/.zshrc ~/.zprofile ~/.gitconfig
```

6. Link the configs. The `-t ~` is needed, otherwise Stow links into the repo's parent:
```shell
stow -t ~ zsh tmux ghostty git
```

7. Set up your Git identity in `~/.gitconfig.local`, since `.gitconfig` includes it:
```ini
[user]
	name = <name>
	email = <email>
```

8. Open a new terminal. In tmux, press `prefix` + `I` to install the TPM plugins.

### Adding a new Tool

1. Move the file
2. Mirror its path under a new folder
3. Run 
```shell
stow -t ~ <folder>
```

## Notes

### What's not tracked

- zsh history
- `~/.gitconfig.local`, which holds my git name and email, naturally
- `~/.zshrc.local`, for machine-specific settings and secrets

### Platform

This is macOS specific. 

## Uninstalling

```shell
stow -D -t ~ <folder>
```
