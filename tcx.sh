#!/data/data/com.termux/files/usr/bin/bash
echo "========================"
echo "======TOOLZD WEB MAKER=="
echo "========================"
echo "Do you want to edit HTML? (y/n)"
read edit_html

if [ "$edit_html" == "y" ]; then
    echo "Opening HTML file for editing..."
    nano /data/data/com.termux/files/home/website/index.html
fi

# Create a simple website structure
mkdir -p /data/data/com.termux/files/home/website
cd /data/data/com.termux/files/home/website

# index.php
cat <<EOL > index.php
<?php
echo "<h1>Welcome to My PHP Website</h1>";
?>
EOL

# index.html
cat <<EOL > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My PHP Website</title>
</head>
<body>
    <h1>This is an editable HTML file.</h1>
</body>
</html>
EOL

echo "Do you want LAN access only or Public link? (lan/public)"
read access_type

if [ "$access_type" == "lan" ]; then
    ip=$(ifconfig wlan0 | grep 'inet ' | awk '{print $2}')
    echo "Starting local server..."
    php -S 0.0.0.0:8080 -t . &
    echo "Access this link on LAN: http://$ip:8080"
elif [ "$access_type" == "public" ]; then
    echo "Starting public server with ngrok..."
    php -S 0.0.0.0:8080 -t . &
    ngrok http 8080
else
    echo "Invalid option!"
fi
