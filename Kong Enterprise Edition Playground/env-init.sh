echo "Initializing..."
sleep 2s; echo "Logging in BinTray Credentials..."
sleep 2s; echo "Pulling the latest Kong E.E Image..."
sleep 10s; echo "Tagging your image for easier management..."
sleep 2s; echo "Pulling and installing database..."
sleep 10s; echo "Running Kong migrations..."
sleep 5s; echo "Installing Kong E.E...."
sleep 5s; echo "Starting Kong E.E...."
echo: YOUR KONG ENVIRONMENT IS READY!




read -p  "Initializing..." -t 1
read -p  "Logging in BinTray Credentials..." -t 1
read -p  "Pulling the latest Kong E.E Image..." -t 10
read -p  "Tagging your image for easier management..." -t 2
read -p  "Running Kong migrations..." -t 5
read -p  "Installing Kong E.E...." -t 10


