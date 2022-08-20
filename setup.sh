#!/bin/bash

SETUP_DIR=$(pwd)
USER_NAME=$(whoami)

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Deliexpress - Sistemas Operativos"
TITLE="Setup"

progress () {
    clear
    echo $1 | dialog --gauge "Un momento. $2" 10 70 0;
    sleep 2
}

bye_bye () {
    clear
    dialog --title "Bye bye" --msgbox "$(cat $SETUP_DIR/utils/byebye.txt)" 15 48 ;
    clear
}

sudo apt-get update -y
sudo apt-get upgrade -y

#Visual Studio Code
if [ ! -x "$(command -v code)" ]; then
    progress "0" "Instalando Visual Studio Code"
    sudo snap install --classic code -y
    progress "10" "Visual Studio Code instalado"
else
    progress "10" "Ya tienes instalado Visual Studio Code"
fi


# Slack
if [ ! -x "$(command -v slack)" ]; then
    progress "15" "Instalando Slack"
    sudo snap install slack -y
    progress "25" "Slack instalado"
else
    progress "25" "Ya tienes instalado Slack"
fi

# Postman
if [ ! -x "$(command -v postman)" ]; then
    progress "30" "Instalando Postman"
    sudo snap install postman -y
    progress "40" "Postman instalado"
else
    progress "40" "Ya tienes instalado Postman"
fi

# Guake
if [ ! -x "$(command -v guake)" ]; then
    progress "45" "Instalando Guake"
    sudo apt-get install guake -y
    progress "60" "Guake instalado"
else
    progress "60" "Ya tienes instalado Guake"
fi

# MongoCompass
if [ ! -x "$(command -v mongodb-compass)" ]; then
    progress "70" "Instalando MongoDb Compass"
    wget https://downloads.mongodb.com/compass/mongodb-compass_1.28.1_amd64.deb
    sudo apt install ./mongodb-compass_1.28.1_amd64.deb -y
    progress "90" "MongoDb Compass instalado"
else
    progress "90" "Ya tienes instalado MongoDb Compass"
fi

bye_bye