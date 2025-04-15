#!/usr/bin/env bash

rsync -vulr ./{mako,waybar,wofi} ~/.config/
rsync -vulr ./hypr --exclude='./hypr/custom/*' ~/.config/
