# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### Defining aliasses
alias ls='lsd --color=auto'
alias la='lsd --color=auto -a'
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias unlock_packagekit="sudo rm -rf /var/lib/PackageKit/alpm"
alias update-grub="grub-mkconfig -o /boot/grub/grub.cfg"

PS1='[\u@\h \W]\$ '

# To make this work, you need to install
# trueline https://github.com/petobens/trueline.git
source ~/.trueline/trueline.sh

declare -A TRUELINE_COLORS=(
    [black]='36;39;46'
    [cursor_grey]='37;37;37'
    [green]='152;195;121'
    [grey]='171;178;191'
    [light_blue]='97;175;239'
    [mono]='130;137;151'
    [orange]='209;154;102'
    [purple]='198;120;221'
    [red]='224;108;117'
    [special_grey]='48;48;48'
    [white]='238;238;238'
)

declare -a TRUELINE_SEGMENTS=(
    'user,white,cursor_grey,bold'
    'working_dir,mono,cursor_grey,normal'
    'git,grey,special_grey,normal'
    'venv,grey,red,normal'
    'newline,black,white,bold'
)
