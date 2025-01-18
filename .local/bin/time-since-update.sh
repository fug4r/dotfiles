#!/bin/sh

# TODO check only for successful upgrades
current_date=$(date +%s)
last_update=$(date -d $(tac /var/log/pacman.log | grep -m 1 "starting full system upgrade" | awk -F'[][]' '{print $2}') +%s)

seconds=$(( $current_date - $last_update ))
days=$(( $seconds / 86400 ))
hours=$(( ($seconds - $days * 86400) / 3600 ))

printf "%sD %sH" "$days" "$hours"
