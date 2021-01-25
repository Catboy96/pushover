# Pushover
Pushover script for Linux

This script allows you to use Pushover via Linux command line interface.

## Usage
1. Add your `APP TOKEN` and `USER KEY` to `~/.pushover/`:
```bash
mkdir ~/.pushover
echo "YOUR APP TOKEN" > ~/.pushover/app_token
echo "YOUR USER KEY" > ~/.pushover/key
```
> You can also specify app token and user key values via command line argument `-a` and `-k`

2. Send your push notification!
```bash
./pushover "Hello world" --title "Pushover Test" --url "https://github.com/Catboy96/pushover" --url_title "Github Page"
```
or
```bash
./pushover "Hello world" -t "Pushover Test" -u "https://github.com/Catboy96/pushover" -T "Github Page"
```

## Here's a screenshot!
<p align="center">
  <img src="https://raw.githubusercontent.com/Catboy96/pushover/main/pushover_test.jpg" alt="pushover_test">
  <br />
</p>

## Detailed usage
```
Usage: pushover message [OPTION]...

Notification options:
   -t,  --title       your message's title, otherwise your app's name is used
   -d,  --device      your user's device name to send the message directly to that device
   -u,  --url         a supplementary URL to show with your message
   -T,  --url_title   a title for your supplementary URL, otherwise just the URL is shown
   -p,  --priority    send as -2 to generate no notification/alert, -1 to always send as a
                        quiet notification, 1 to display as high-priority and bypass the
                        user's quiet hours, or 2 to also require confirmation from the user
   -s,  --sound       the name of one of the sounds supported by device clients to override
                        the user's default sound choice
   -S,  --timestamp   a Unix timestamp of your message's date and time to display to the user,
                         rather than the time your message is received by our API

App options:
   -a,  --app-token   your application's API token. If not specified, ~/.pushover/app_token
                        will be read
   -k,  --key         the user/group key (not e-mail address) of your user (or you). If not
                        specified, ~/.pushover/key will be read
```
