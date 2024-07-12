#!/bin/bash

# Function to fetch ISS location and people in space data from Open Notify API
fetch_iss_data() {
    local url="http://api.open-notify.org/iss-now.json"
    iss_data=$(curl -s "$url")
    echo "$iss_data"
}

# Fetch data
iss_data=$(fetch_iss_data)

# Extract number of people in space
num_people=$(curl -s "http://api.open-notify.org/astros.json" | jq '.number')

# Extract names and crafts of people in space
people=$(curl -s "http://api.open-notify.org/astros.json" | jq -r '.people[] | "\(.name), Craft: \(.craft)"')

# Extract current ISS coordinates
iss_lat=$(echo "$iss_data" | jq -r '.iss_position.latitude')
iss_lon=$(echo "$iss_data" | jq -r '.iss_position.longitude')

# Print number of people in space
echo "Number of People in Space: $num_people"

# Print names and crafts of people in space
echo "People in Space:"
echo "$people"

# Print current ISS coordinates
echo "Current ISS Coordinates:"
echo "Latitude: $iss_lat, Longitude: $iss_lon"
