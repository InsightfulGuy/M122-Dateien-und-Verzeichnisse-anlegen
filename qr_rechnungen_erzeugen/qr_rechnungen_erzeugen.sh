#!/bin/bash

# convert to csv
convert_to_csv() {
    input_file=$1
    output_file=$2

    # check if exists
    if [ ! -f "$output_file" ]; then
        echo "InvoiceNumber,Date,CustomerName,Address,Amount,Currency" > "$output_file"
    fi

    # extract
    invoice_number=$(grep "InvoiceNumber" "$input_file" | cut -d ':' -f 2)
    date=$(grep "Date" "$input_file" | cut -d ':' -f 2)
    customer_name=$(grep "CustomerName" "$input_file" | cut -d ':' -f 2)
    address=$(grep "Address" "$input_file" | cut -d ':' -f 2)
    amount=$(grep "Amount" "$input_file" | cut -d ':' -f 2)
    currency=$(grep "Currency" "$input_file" | cut -d ':' -f 2)

    # append
    echo "$invoice_number,$date,$customer_name,$address,$amount,$currency" >> "$output_file"
}

# check if at least 1
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <input_file_1> [<input_file_2> ...]"
    exit 1
fi

output_csv="output_invoices.csv"

# for loop files
for input_file in "$@"; do
    convert_to_csv "$input_file" "$output_csv"
done

echo "Conversion to CSV complete. Have fun!"
