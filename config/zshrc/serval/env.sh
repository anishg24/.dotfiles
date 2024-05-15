use_auto_tmux () {
  ! ([ -z $DISPLAY ] || $(pgrep -x "i3" > /dev/null || pgrep -x "sway" > /dev/null))
}

if [ $1 -eq "0" ]
then

  export PATH="$HOME/Tools/xilinx/Vivado/2023.1/bin:$PATH"
  export PATH="$PATH:/home/anish/.local/bin"
  export PATH="$PATH:/home/anish/.local/share/gem/ruby/3.0.0/bin"
  export PATH="$PATH:/home/anish/.platformio/penv/bin"

  if use_auto_tmux
  then
    export ZSH_TMUX_AUTOSTART=true
    export ZSH_TMUX_AUTOCONNECT=false
    export ZSH_TMUX_AUTOQUIT=true
  else 
    export ZSH_TMUX_AUTOSTART=false
    export ZSH_TMUX_AUTOCONNECT=false
    export ZSH_TMUX_AUTOQUIT=false
  fi

else

  if use_auto_tmux
  then
    tmux-window-name() {
      ($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
    }

    add-zsh-hook chpwd tmux-window-name
  fi

  source "$HOME/.config/zshrc/serval/aliases.sh"
  source "$HOME/.config/zshrc/serval/functions.sh"

  # pnpm
  export PNPM_HOME="/home/anish/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  # pnpm end


  # miniconda3 init
  [ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh


  # Some quartus stuff?
  export QSYS_ROOTDIR="/home/anish/.cache/paru/clone/quartus-free/pkg/quartus-free-quartus/opt/intelFPGA/23.1/quartus/sopc_builder/bin"

  # Modulefiles
  (( ${+functions[module]} )) || source /etc/modules/init/zsh
  module use --append $HOME/.config/modulefiles

  pfetch
fi
