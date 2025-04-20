#!/bin/bash

# Display information and query the database
get_element_info() {
    local input="$1"

        # Query for atomic number (integer), symbol (string), and name (string)
    result=$(psql -U your_db_user -d your_db_name -t -c "
        SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius
        FROM elements
        LEFT JOIN properties ON elements.atomic_number = properties.atomic_number
        WHERE elements.atomic_number = '${input}' 
        OR elements.symbol = '${input}' 
        OR elements.name = '${input}'")

            # Check if result is not empty
    if [[ -z "$result" ]]; then
        echo "I could not find that element in the database."
    else
        # Format and display the result
        echo "$result" | while IFS='|' read -r atomic_number symbol name type atomic_mass melting_point boiling_point; do
            echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
        done
    fi
}

# Main script
if [[ -z "$1" ]]; then
    echo "You need to provide an argument (atomic number, symbol, or name)."
    exit 1
fi

# Call the function with the input argument
get_element_info "$1"