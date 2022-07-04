# Dotfiles

## Getting Started

My `dotfiles` are managed by `stow`. So you need that before continuing. You also need `git-crypt` for the private
`personal` and `work` submodule. These contain information not for the public eyes. You can take a look at the `demo`
submodule to get an idea how these work.

## Installation

Clone this repository.

```
git clone https://github.com/pchaos/.dotfiles.git
# or 
git clone git@github.com:pchaos/.dotfiles.git
```

You can install three variants of the dotfiles.

| Variant | Installation | Description |
|-----|----|----|
| demo | `./install-demo` | Just for demonstration |
| personal | `./install-personal` | Personal config |
| work | `./install-work` | Work config |

For personal and work use private repositories which are encrypted with `git-crypt`. So, you also need the correct pgp
key.

## Auto Installation and Setup

You can use this script to automatic setup a Fedora Silverblue installation.

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mikebarkmin/silberblau/main/bin/install.sh)
```

For more information visit the [silberblau repository](https://github.com/mikebarkmin/silberblau).

## Inspiration

The dotfiles took inspiration mainly from [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles) to the point that I
have blatantly copied files over to my repo.

## 关于加密
1. 导出密钥，发给有需要的同事

git-crypt export-key dotfiles-git-crypt-key

2. 解密

进入工程目录，打开Git Base Here，执行 git-crypt unlock dotfiles-git-crypt-key

利用该方式进行文件管理可以保证安全性，只有团队内相关人员才能看到明文内容，解密只需要第一次进行，之后就没什么改变，直接改文件，git push会自动加密，git pull 会自动解密。
