#!/usr/bin/env bash
###############
# Pushover for Linux
# By Catboy96 <me@ralf.ren>
###############

PUSHOVER_VESION="1.0.0"
poMessage="Pushover"

help () {
    echo "Pushover for Linux"
    echo "By PlayerCatboy <me@ralf.ren>, Version $PUSHOVER_VESION"
    echo ""
    echo "Usage: pushover message [OPTION]..."
    echo ""
    echo "Notification options:"
    echo "   -t,  --title       your message's title, otherwise your app's name is used"
    echo "   -d,  --device      your user's device name to send the message directly to that device"
    echo "   -u,  --url         a supplementary URL to show with your message"
    echo "   -T,  --url_title   a title for your supplementary URL, otherwise just the URL is shown"
    echo "   -p,  --priority    send as -2 to generate no notification/alert, -1 to always send as a"
    echo "                        quiet notification, 1 to display as high-priority and bypass the"
    echo "                        user's quiet hours, or 2 to also require confirmation from the user"
    echo "   -s,  --sound       the name of one of the sounds supported by device clients to override"
    echo "                        the user's default sound choice"
    echo "   -S,  --timestamp   a Unix timestamp of your message's date and time to display to the user,"
    echo "                         rather than the time your message is received by our API"
    echo ""
    echo "App options:"
    echo "   -a,  --app-token   your application's API token. If not specified, ~/.pushover/app_token"
    echo "                        will be read"
    echo "   -k,  --key         the user/group key (not e-mail address) of your user (or you). If not"
    echo "                        specified, ~/.pushover/key will be read"
    echo ""
}

send () {
    while [[ $# -gt 0 ]]; do
        opt=$1

        case $opt in
        -t|--title)
            poTitle="$2"
            shift
            shift
            ;;
        -d|--device)
            poDevice="$2"
            shift
            shift
            ;;
        -u|--url)
            poUrl="$2"
            shift
            shift
            ;;
        -T|--url_title)
            poUrlTitle="$2"
            shift
            shift
            ;;
        -p|--priority)
            poPriority="$2"
            shift
            shift
            ;;
        -s|--sound)
            poSound="$2"
            shift
            shift
            ;;
        -S|--timestamp)
            poTimestamp="$2"
            shift
            shift
            ;;
        -a|--app-token)
            poAppToken="$2"
            shift
            shift
            ;;
        -k|--key)
            poKey="$2"
            shift
            shift
            ;;    
        *)
            help
            exit 0
            ;;
        esac
    done

    [ -z "$poAppToken" ] && poAppToken=$(cat ~/.pushover/app_token)
    [ -z "$poKey" ] && poKey=$(cat ~/.pushover/key)

    post_data="token=$poAppToken&user=$poKey&message=$poMessage"
    [ ! -z "$poTitle" ] && poTitle=${poTitle// /%20} && post_data=$post_data"&title=$poTitle"
    [ ! -z "$poDevice" ] && post_data=$post_data"&device=$poDevice"
    [ ! -z "$poUrl" ] && post_data=$post_data"&url=$poUrl"
    [ ! -z "$poUrlTitle" ] && poUrlTitle=${poUrlTitle// /%20} && post_data=$post_data"&url_title=$poUrlTitle"
    [ ! -z "$poPriority" ] && post_data=$post_data"&priority=$poPriority"
    [ ! -z "$poSound" ] && post_data=$post_data"&sound=$poSound"
    [ ! -z "$poTimestamp" ] && post_data=$post_data"&timestamp=$poTimestamp"

    wget https://api.pushover.net/1/messages.json --post-data=$post_data -qO- > /dev/null 2>&1
}

[ $# = 0 ] && help && exit 0
[ -z $(which wget) ] && echo "wget is not installed." && exit 1

poMessage=$1
poMessage=${poMessage// /%20}
shift
send "$@"
