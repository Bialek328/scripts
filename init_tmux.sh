# !/usr/bin/env bash
tmux new-session -d -s $1
tmux new-window -t $1:1 -n nvim
tmux select-window -t $1:1
tmux send-keys -t $1:1 "nvim ." C-m
tmux attach-session -t $1


