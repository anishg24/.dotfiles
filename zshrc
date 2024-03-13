# zmodload zsh/zprof 
# zprof

export PATH="$HOME/Tools/xilinx/Vivado/2023.1/bin:$PATH"
export PATH="$PATH:/home/anish/.local/bin"
export EDITOR="nvim"

export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

if $(pgrep -x "i3" > /dev/null || pgrep -x "sway" > /dev/null); then
  export ZSH_TMUX_AUTOSTART=false
  export ZSH_TMUX_AUTOQUIT=false
else 
  export ZSH_TMUX_AUTOSTART=true
  export ZSH_TMUX_AUTOCONNECT=false
  export ZSH_TMUX_AUTOQUIT=true
fi

export ZSH_TMUX_FIXTERM=true

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'

export GPG_TTY=$(tty)

source ~/.dotfiles/antigen.zsh

antigen use oh-my-zsh

COMPLETION_WAITING_DOTS="..."
ZVM_INIT_MODE="sourcing"

antigen bundle git
antigen bundle archlinux
antigen bundle tmux
antigen bundle battery
antigen bundle fzf
antigen bundle colored-man-pages
antigen bundle jsontools
antigen bundle zoxide
antigen bundle Aloxaf/fzf-tab
antigen bundle changyuheng/zsh-interactive-cd
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme romkatv/powerlevel10k

antigen apply

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if (pgrep -x "i3" > /dev/null || pgrep -x "sway" > /dev/null); then
else
    tmux-window-name() {
    ($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
  }

  add-zsh-hook chpwd tmux-window-name
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export BAT_THEME="base16"

source "$HOME/.config/zshrc/aliases.sh"
source "$HOME/.config/zshrc/functions.sh"

#eval "$(ntfy shell-integration --foreground-too)"
#export AUTO_NTFY_DONE_IGNORE="$AUTO_NTFY_DONE_IGNORE vim nvim hx screen tmux ta ssh mosh perlmutter_pass"

source $ZSH/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

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

# Zoxide init
# compinit
eval "$(zoxide init --cmd cd zsh)"

clear && pfetch