#!/bin/bash

generate_password() {
    local length="$1"
    local password=""

    # alphanumeric char set
    local chars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

    for i in $(seq 1 "$length"); do
	# rand index
        local random_index=$(( RANDOM % ${#chars} ))
        password="${password}${chars:$random_index:1}"
    done

    echo "$password"
}

echo "Welcome to the Password Generator!"

# passwd length
read -p "Enter the desired length of the password: " pass_length

# validate
if [[ ! "$pass_length" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: Invalid input. Please enter a positive integer."
    exit 1
fi

# generate and display
password=$(generate_password "$pass_length")
echo "Generated Password: $password"
