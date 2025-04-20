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