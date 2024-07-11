#!/bin/bash

# Function to fetch current prices
fetch_prices() {
    # Fetch Bitcoin price in USDT (Tether) from WazirX
    BTC_USDT=$(curl -s "https://api.wazirx.com/sapi/v1/tickers/24hr" | jq -r '.[] | select(.symbol=="btcusdt") | .lastPrice')

    # Fetch Novartis stock price in USD (from Alpha Vantage)
    NOVARTIS_USD=$(curl -s "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=NVS&apikey=demo" | jq -r '.["Global Quote"]["05. price"]')

    # Fetch USD to CHF exchange rate from ExchangeRate API
    USD_CHF=$(curl -s "https://api.exchangerate-api.com/v4/latest/USD" | jq -r '.rates.CHF')

    # Calculate Bitcoin price in CHF
    BTC_CHF=$(echo "$BTC_USDT * $USD_CHF" | bc -l)

    # Calculate Novartis price in CHF
    NOVARTIS_CHF=$(echo "$NOVARTIS_USD * $USD_CHF" | bc -l)

    echo "$NOVARTIS_CHF $USD_CHF $BTC_CHF"
}

# Initial investments (in CHF)
INVEST_NOVARTIS=1000  # 10 stocks at 100 CHF each
INVEST_USD=3000       # 3000 USD at some historical rate
INVEST_BTC=5000       # 0.1 Bitcoin at 50000 CHF each

# Amounts held
AMOUNT_NOVARTIS=10
AMOUNT_USD=3000
AMOUNT_BTC=0.1

# Fetch current prices
prices=$(fetch_prices)
NOVARTIS_CHF=$(echo $prices | cut -d ' ' -f 1)
USD_CHF=$(echo $prices | cut -d ' ' -f 2)
BTC_CHF=$(echo $prices | cut -d ' ' -f 3)

# Calculate current values
VALUE_NOVARTIS=$(echo "$NOVARTIS_CHF * $AMOUNT_NOVARTIS" | bc -l)
VALUE_USD=$(echo "$USD_CHF * $AMOUNT_USD" | bc -l)
VALUE_BTC=$(echo "$BTC_CHF * $AMOUNT_BTC" | bc -l)

# Calculate total portfolio value
TOTAL_VALUE=$(echo "$VALUE_NOVARTIS + $VALUE_USD + $VALUE_BTC" | bc -l)

# Log values with timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "$TIMESTAMP, $VALUE_NOVARTIS, $VALUE_USD, $VALUE_BTC, $TOTAL_VALUE" >> /path/to/portfolio_values.log

# Output the results
echo "Novartis (10 stocks): CHF $VALUE_NOVARTIS"
echo "USD (3000 USD): CHF $VALUE_USD"
echo "Bitcoin (0.1 BTC): CHF $VALUE_BTC"
echo "Total portfolio value: CHF $TOTAL_VALUE"
