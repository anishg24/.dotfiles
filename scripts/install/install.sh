if [ -z "$1" ]
then
  echo "Please provide an executable to install"
  exit 1
fi

DEFAULT_DIR="$HOME/.dotfiles/bin"

if [ -z "$2" ]
then
  SAVE_DIR=$DEFAULT_DIR
  mkdir -p $DEFAULT_DIR 
else
  echo "Destination provided, saving $1 install to $2"
  SAVE_DIR=$(realpath $2)
  mkdir -p $SAVE_DIR
fi

case "$1" in
  nvim)
    curl -L https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage --output "$SAVE_DIR/nvim"
    chmod +x "$SAVE_DIR/nvim"
  ;;
  fzf)
    curl -L https://github.com/junegunn/fzf/releases/download/0.48.0/fzf-0.48.0-linux_amd64.tar.gz --output "$SAVE_DIR/fzf.tar.gz"
    tar -xvf "$SAVE_DIR/fzf.tar.gz" -C "$SAVE_DIR/"
  ;;
  zoxide)
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    ln -s "$HOME/.local/bin/zoxide" "$SAVE_DIR/zoxide"
  ;;
  lsd)
    curl -L https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd-v1.0.0-i686-unknown-linux-gnu.tar.gz --output "$SAVE_DIR/lsd.tar.gz"
    tar -xvf "$SAVE_DIR/lsd.tar.gz" -C "$SAVE_DIR/"
    ln -s "$SAVE_DIR/lsd-v1.0.0-i686-unknown-linux-gnu/lsd" "$SAVE_DIR/lsd"
  ;;
  bat)
    curl -L https://github.com/sharkdp/bat/releases/download/v0.24.0/bat-v0.24.0-i686-unknown-linux-gnu.tar.gz --output "$SAVE_DIR/bat.tar.gz"
    tar -xvf "$SAVE_DIR/bat.tar.gz" -C "$SAVE_DIR/"
    ln -s "$SAVE_DIR/bat-v0.24.0-i686-unknown-linux-gnu/bat" "$SAVE_DIR/bat"
  ;;
  *) 
    echo "Executable not recognized"
    exit 1
  ;;
esac

rm -rf "$SAVE_DIR/*.tar.gz"
echo "Installed $1 to $SAVE_DIR/$1!"
