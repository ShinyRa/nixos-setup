#!/bin/bash
shopt -s expand_aliases
alias nord='sudo bash ~/.config/wgnord/wgnord'

country="$1"

if [ -n "$country" ]; then
    # Pass the selected country to the nord command
    echo "Selected country: $country"
    nord c "$country"
else
    echo "No country selected."
    exit 1
fi