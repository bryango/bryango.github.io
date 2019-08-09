#!/bin/bash
# Update extra resources

# LaTeX
LATEX_MACROS_UPSTREAM=../Base/Templates/LaTeX/basics
LATEX_MACROS_LOCAL=./_includes/usermod
for tex_file in "$LATEX_MACROS_UPSTREAM"/*.tex; do
    local_file="$LATEX_MACROS_LOCAL"/"$(basename "$tex_file")"
    [[ ! -f $local_file ]] && continue
    if diff --color "$local_file" "$tex_file";
    then :
    else
        cp -i "$tex_file" "$local_file"
    fi
done

tex_cmds=$(cat "$LATEX_MACROS_LOCAL"/*.tex)
cat <<- EOF > "$LATEX_MACROS_LOCAL"/mathjax.html
	<!-- mathjax for local use -->
	<!-- for deployment, see '_includes/main/top/custom.html' -->

	<div class="mathjax_macros" style="display: none;">
	\$ $tex_cmds \$
	</div>
EOF
