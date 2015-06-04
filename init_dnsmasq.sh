ask() {
    # http://djm.me/ask
    while true; do
 
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi
 
        # Ask the question - use /dev/tty in case stdin is redirected from somewhere else
        read -p "$1 [$prompt] " REPLY </dev/tty
 
        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi
 
        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
 
    done
}

if [ "$(uname)" == "Darwin" ]; then
    if [ ! -f /usr/local/etc/dnsmasq.conf ]; then
        echo -e "Install dnsmasq\n"
        echo -e "    $ brew install dnsmasq\n"
        exit
    fi
    if ! diff <(echo -e "server=8.8.8.8\nconf-dir=/usr/local/etc/dnsmasq.d") /usr/local/etc/dnsmasq.conf > /dev/null ; then
        if ask "Do you want to replace /usr/local/etc/dnsmasq.conf ?" Y; then
            cat << EOF > /usr/local/etc/dnsmasq.conf
server=8.8.8.8
conf-dir=/usr/local/etc/dnsmasq.d
EOF
        fi
    fi

    sudo mkdir -p /usr/local/etc/dnsmasq.d
    if [ ! -f /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist ]; then
        if ask "Auto start dnsmasq ?" Y; then
            sudo cp $(brew list dnsmasq | grep /homebrew.mxcl.dnsmasq.plist$) /Library/LaunchDaemons/
            sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
        fi
    fi

    for f in `ls *.dnsmasq.conf`; do 
        eval sudo "echo `cat $f`" > /usr/local/etc/dnsmasq.d/$f
    done

    sudo launchctl stop homebrew.mxcl.dnsmasq
    sudo launchctl start homebrew.mxcl.dnsmasq
else
    echo "This script don't support your OS (only support OSX for now)"
fi
