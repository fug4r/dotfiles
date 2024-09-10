#!/bin/sh

# TODO check only for successful upgrades
current_date=$(date +%s)
last_update=$(date -d $(sed -n '/starting full system upgrade$/x;${x;s/.\([0-9-]*\).*/\1/p}' /var/log/pacman.log) +%s)

seconds=$(( $current_date - $last_update ))
days=$(( $seconds / 86400 ))
hours=$(( ($seconds - $days * 86400) / 3600 ))

printf "%sD %sH" "$days" "$hours"
