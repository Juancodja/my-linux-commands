# Custom Configuration for the terminal

PROMPT_DIRTRIM=2 # Recorta el largo de la ruta en la terminal


# Comando para crear componentes react.js
new_component() {
    if [ -z "$1" ]; then
        echo "Usage: new_component <component-name>"
        return 1
    fi

    component_name=$1

    to_camel_case() {
        IFS='-' read -r -a array <<< "$1"
        camel_case=""
        for element in "${array[@]}"; do
            camel_case="${camel_case}$(tr '[:lower:]' '[:upper:]' <<< ${element:0:1})${element:1}"
        done
        echo "$camel_case"
    }

    name=$(to_camel_case "${component_name}")

    # Create the directory
    mkdir -p "$component_name"

    # Create the JavaScript file
    js_file="${component_name}/${component_name}.js"
    touch "$js_file"
    cat <<EOL > "$js_file"
import React from 'react'
import styles from './${component_name}.module.css'

const ${name^} = () => {
	return (
		<div className = {styles.${name^}}>
			${name^}
		</div>
	);
};

export default ${name^};
EOL

    # Create the CSS file
    css_file="${component_name}/${component_name}.module.css"
    touch "$css_file"
    echo ".${name^}{}" > "$css_file"

    echo "Component '${name^}' created with files:"
    echo "  - ${js_file}"
    echo "  - ${css_file}"
}

# Save the changes to your .bashrc or .bash_profile and source it
# source ~/.bashrc or source ~/.bash_profile
