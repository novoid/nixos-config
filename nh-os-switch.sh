#!/usr/bin/env sh

# https://github.com/viperML/nh
nice ionice time nh os switch --ask "/home/vk/nixos"

notify-send "nh os switch" "finished"

