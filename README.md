# zen.zsh

## Zen Zsh Prompt

A minimalistic Zsh prompt configuration for `*nix` systems.

![logo][zen_logo]

---

### Install

1. Run `git clone https://github.com/cybardev/zen.zsh.git ~/.zsh/zen`

1. Paste the following into `.zshrc`:

```zsh
fpath+="$HOME/.zsh/zen"
autoload -Uz promptinit
promptinit
prompt zen
```

---

### Usage

After installing as above, `source ~/.zshrc` or relaunch the terminal to experience `Zen`.

---

### Credits

Inspired by [this post](https://reddit.com/r/unixporn/comments/tvbh64/bspwm_dollar_store_qpwm_s/) on [r/unixporn](https://reddit.com/r/unixporn/).

---

### Screenshots

![screenshot][zen_img_01]

<!-- Links -->

[zen_zsh]: https://github.com/cybardev/zen.zsh/releases/download/v1.0/zen.zsh
[zen_logo]: https://user-images.githubusercontent.com/50134239/161451438-d0e8a48d-5440-4a82-a6c7-8e47fdce71b2.png
[zen_img_01]: https://user-images.githubusercontent.com/50134239/161451586-5a9d8078-7969-45b8-a59a-17665b6e1ab1.png
