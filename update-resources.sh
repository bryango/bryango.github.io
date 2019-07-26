#!/bin/bash
# Update extra resources

# LaTeX
LATEX_MACROS_UPSTREAM=../Base/Templates/LaTeX/basics
for tex_file in "$LATEX_MACROS_UPSTREAM"/*.tex; do
    local_file=./_includes/usermod/"$(basename "$tex_file")"
    [[ ! -f $local_file ]] && continue
    if diff --color "$local_file" "$tex_file";
    then :
    else
        cp -i "$tex_file" "$local_file"
    fi
done
