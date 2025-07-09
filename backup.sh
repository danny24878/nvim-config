#!/bin/bash
cd ~/.config/nvim
git add .
git commit -m "Backup: $(date '+%Y-%m-%d %H:%M:%S')"
git push
