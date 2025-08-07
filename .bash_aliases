
# Colorized and convenient ls commands
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Quickly reload shell
alias reload='source ~/.bashrc'

# Create and enter directory
mkcd() { mkdir -p "$1" && cd "$1"; }

# Common dev folder shortcut
alias www='cd /var/www/html'
