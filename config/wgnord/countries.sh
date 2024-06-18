local country = cat ~/.config/wgnord/countries.txt 
    | cut -f 1
    | rofi -dmenu -window-title "Select VPN country" 

echo $country