# lunarvim

Last Modified: 2024-03-10 00:00:00

## install

### Release

(Neovim 0.9.0)

No alarms and No surprises:

Linux
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)

### Nightly

(Neovim 0.10.0)

All the new features with all the new bugs:
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
bash <(proxychains curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

### Install a Nerd Font

```
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
```

## uninstall

### script

You can remove LunarVim (including the configuration files) using the bundled uninstall script

```shell
bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh
```

To uninstall LunarVim, you can follow these steps:

### By hand

Open a terminal or command prompt.
Navigate to the installation directory of LunarVim. By default, it is located in ~/.config/lvim on Unix-based systems or %USERPROFILE%\.config\lvim on Windows.
Once inside the LunarVim directory, run the following command to remove the LunarVim files:
On Unix-based systems:

```shell
rm -rf ~/.config/lvim
```

On Windows (PowerShell):

```shell
Remove-Item -Path $HOME\.config\lvim -Recurse -Force
```

Additionally, you may also want to remove the backup and swap files created by LunarVim. Run the following command to delete them:
On Unix-based systems:

```shell
rm -rf ~/.local/share/lunarvim
```

On Windows (PowerShell):

```shell
Remove-Item -Path $HOME\AppData\Local\lunarvim -Recurse -Force
```

Finally, if you have made any modifications to your Vim configuration file (~/.vimrc or %USERPROFILE%\_vimrc), you can remove the LunarVim-related lines from the file manually.
After completing these steps, LunarVim should be uninstalled from your system. Make sure to back up any necessary files before proceeding with the uninstallation process. If you encounter any issues, feel free to ask for further assistance.
