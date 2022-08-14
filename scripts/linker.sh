#!/bin/bash
set -e

colorschemes="afterglow"

for colorscheme in $colorschemes; do
    bash -c "$(curl -so- https://raw.githubusercontent.com/Gogh-Co/Gogh/master/themes/$colorscheme.sh)"
done
