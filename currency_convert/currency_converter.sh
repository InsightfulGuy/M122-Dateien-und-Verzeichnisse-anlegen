#!/bin/bash

DATA_FILE="./previous_rates.json"
CURRENT_FILE="./current_rates.json"

fetch_exchange_rates() {
    local base_currency="CHF"
    local response=$(curl -s "https://api.exchangerate-api.com/v4/latest/$base_currency")
    echo "$response" > "$CURRENT_FILE"
}

display_exchange_rates() {
    local previous_rates=$(cat "$DATA_FILE")
    local current_rates=$(cat "$CURRENT_FILE")

    # header
    printf "%-10s %-15s %-15s %-10s\n" "Währung" "Vorheriger Wert" "Aktueller Wert" "Änderung"

    local currencies=("EUR" "USD" "ETH" "BTC")

    for currency in "${currencies[@]}"; do
        local previous_value=$(echo "$previous_rates" | jq -r --arg currency "$currency" '.rates[$currency]')
        local current_value=$(echo "$current_rates" | jq -r --arg currency "$currency" '.rates[$currency]')

        local change=$(echo "scale=4; $current_value - $previous_value" | bc)

        # format colors
        if (( $(echo "$change > 0" | bc -l) )); then
            change_status="\e[32m$change\e[0m"  # green = up
        elif (( $(echo "$change < 0" | bc -l) )); then
            change_status="\e[31m$change\e[0m"  # red = down
        else
            change_status="$change"  
        fi

        # output in grid
        printf "%-10s %-15s %-15s %-10s\n" "$currency" "$previous_value" "$current_value" "$change_status"
    done

    # mv to data file
    mv "$CURRENT_FILE" "$DATA_FILE"
}

# check if argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <amount_in_chf>"
    exit 1
fi

amount_chf="$1"

fetch_exchange_rates

display_exchange_rates

echo "Letzte Aktualisierung: $(date)"
