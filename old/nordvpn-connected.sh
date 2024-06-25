output=$(ip link show wgnord 2>/dev/null)

# Check if the output is empty or not
if [[ -n "$output" ]]; then
    echo "connected: "
else
    echo "disconnected: "
fi