## Installation
I prefer using `devbox`, but any other method should work as well
```zsh
sudo apt install zsh
chsh -s $(which zsh)
devbox global add fzf zsh-defer oh-my-zsh
sudo ln -s ~/.local/share/devbox/global/default/.devbox/nix/profile/default/share/fzf ~/.config/zsh/fzf
mkdir -p ~/.config/zsh
sudo for dir in zsh-defer oh-my-zsh; do ln -s ~/.local/share/devbox/global/default/.devbox/nix/profile/default/share/$dir ~/.config/zsh/; done
export OMZ_PLUGINS=~/.config/zsh/oh-my-zsh/plugins
sudo git clone https://github.com/zsh-users/zsh-autosuggestions $OMZ_PLUGINS/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $OMZ_PLUGINS/zsh-syntax-highlighting
sudo git clone https://github.com/jirutka/zsh-shift-select.git $OMZ_PLUGINS/zsh-shift-select
sudo git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $OMZ_PLUGINS/you-should-use
```

## Setup
Make sure to edit `settings.json` first
```zsh
chmod +x setup.sh
./setup.sh
```

## Useful links
- [Docs](https://www.zsh.org/)
- [Oh My Zsh](https://ohmyz.sh/)
