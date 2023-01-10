# Dotfiles documentation

## Automated installing of everything

To install everything that is needed for all this dotfiles and some good UX run command:

```
./initialise.sh [minimal]
```

`minimal` is an optional argument. It will download only packages using apt. If this argument is not supplied everything will be downloaded.
That means Lazygit, Xournal++, Neovim, NodeJS_v16, Rust, BitstreamVeraSansMono Nerd Font, Brave, Spotify, MS Teams, Discord, Latex, VS Code.
Additionally, this will setup some basic UX features like function keys, dash-to-dock scroll action and click-action.
Finally, this will distribute the downoaded configs to the right place.

## Lazygit

The only different thing from the basic config is changing `<Esc>` for escaping inside lazygit into `<C-e>`.

## Neovim
>**Note** NodeJS_v16, Nerd Font and rust are dependencies for neovim.

Feel free to change the nerd font. For further details read this [readme](https://github.com/Fildo7525/nvim/blob/master/README.md).

## Not mendatory apps

### Brave, Spotify, MS Teams, Discord, Latex, VS Code

All of the mentioned apps are not mendatory for the end user.
Feel free to change the bravser or anything or even remove them from the init file.

>**Note** in the init file is commented out code that will download flatpak. If you want uncomment it.

## UX

As mentioned before, this init file will change the behavior of the function keys. To see more detalied info about this feature read the `initialise.sh` file.
Scroll action will change focus of the opened window in the selected app. Say you have opened 5 terminals. Through this feature you can change focus between them.
Similarly, click-action will show you all the opened windows of selected app to choose the one you want.
One last feature not mentioned above is automatic setup of the git user.email and user.name. This will have to be typed when the script asks for the input.

## Destirbution

Last but not least, this init file will create links to this repository from various places, where the configs should be placed.
Thus, every original config is in one place.

