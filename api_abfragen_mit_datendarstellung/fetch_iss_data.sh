#!/bin/bash

fetch_iss_data() {
    url="http://api.open-notify.org/iss-now.json"
    iss_data=$(curl -s "$url")
    echo "$iss_data"
}

fetch_astronaut_data() {
    url="http://api.open-notify.org/astros.json"
    astronaut_data=$(curl -s "$url")
    echo "$astronaut_data"
}

fetch_crypto_prices() {
    crypto1="bitcoin"
    crypto2="ethereum"
    crypto3="dogecoin"
    url="https://api.coingecko.com/api/v3/simple/price?ids=$crypto1,$crypto2,$crypto3&vs_currencies=usd"
    crypto_data=$(curl -s "$url")
    echo "$crypto_data"
}

fetch_cat_fact() {
    url="https://catfact.ninja/fact"
    fact_data=$(curl -s "$url")
    echo "$fact_data"
}

echo "Fetching ISS data..."
echo "===================="
iss_data=$(fetch_iss_data)
iss_lat=$(echo "$iss_data" | jq -r '.iss_position.latitude')
iss_lon=$(echo "$iss_data" | jq -r '.iss_position.longitude')
echo "Current ISS Coordinates:"
echo "Latitude: $iss_lat"
echo "Longitude: $iss_lon"
echo

echo "Fetching astronaut data..."
echo "=========================="
astronaut_data=$(fetch_astronaut_data)
num_astronauts=$(echo "$astronaut_data" | jq '.number')
echo "Number of Astronauts in Space: $num_astronauts"
echo

echo "Fetching cryptocurrency prices..."
echo "================================="
crypto_data=$(fetch_crypto_prices)
btc_price=$(echo "$crypto_data" | jq -r '.bitcoin.usd')
eth_price=$(echo "$crypto_data" | jq -r '.ethereum.usd')
doge_price=$(echo "$crypto_data" | jq -r '.dogecoin.usd')
echo "Bitcoin Price: $btc_price USD"
echo "Ethereum Price: $eth_price USD"
echo "Dogecoin Price: $doge_price USD"
echo

echo "Fetching a random cat fact..."
echo "============================"
cat_fact=$(fetch_cat_fact)
cat_fact_text=$(echo "$cat_fact" | jq -r '.fact')
echo "Random Cat Fact:"
echo "$cat_fact_text"
echo

echo "Sending data via email..."
mail_result=$(mail -s "Daily Data Report" tristan.evans.tristan@gmail.com <<EOF
Daily Data Report:

ISS Coordinates:
Latitude: $iss_lat
Longitude: $iss_lon

Number of Astronauts in Space: $num_astronauts

Cryptocurrency Prices:
Bitcoin: $btc_price USD
Ethereum: $eth_price USD
Dogecoin: $doge_price USD

Random Cat Fact:
$cat_fact_text
EOF
)

# check if success
if [ $? -ne 0 ]; then
    echo "Failed to send email. Error: $mail_result"
else
    echo "Email sent successfully."
fi

echo "Script execution completed."
