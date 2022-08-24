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
sudo apt-get install snap -y
sudo apt-get install dialog -y

#Visual Studio Code
#Editor de código open source que utilizaremos debido a que tiene una excelente adaptación a todo el entorno JavaScript
if [ ! -x "$(command -v code)" ]; then
    progress "0" "Instalando Visual Studio Code"
    sudo snap install --classic code
    progress "10" "Visual Studio Code instalado"
else
    progress "10" "Ya tienes instalado Visual Studio Code"
fi


# Slack
# Software para comunicación del equipo, se contará con distintos canales para las distintas agrupaciones
if [ ! -x "$(command -v slack)" ]; then
    progress "15" "Instalando Slack"
    sudo snap install slack
    progress "25" "Slack instalado"
else
    progress "25" "Ya tienes instalado Slack"
fi

# Postman
# Software para hacer las peticiones HTTP de prueba al backend
if [ ! -x "$(command -v postman)" ]; then
    progress "30" "Instalando Postman"
    sudo snap install postman
    progress "40" "Postman instalado"
else
    progress "40" "Ya tienes instalado Postman"
fi

# Guake
# Terminal super user-friendly y con alta productividad
if [ ! -x "$(command -v guake)" ]; then
    progress "45" "Instalando Guake"
    sudo apt-get install guake -y
    progress "60" "Guake instalado"
else
    progress "60" "Ya tienes instalado Guake"
fi

# MongoCompass
# GUI para el gestor de base de datos MongoDB
if [ ! -x "$(command -v mongodb-compass)" ]; then
    progress "70" "Instalando MongoDb Compass"
    wget https://downloads.mongodb.com/compass/mongodb-compass_1.28.1_amd64.deb
    sudo apt-get install ./mongodb-compass_1.28.1_amd64.deb -y
    progress "90" "MongoDb Compass instalado"
else
    progress "90" "Ya tienes instalado MongoDb Compass"
fi

# Docker
# Contenedores para tener una estabilidad necesaria entre todo el equipo para tener las versiones de tecnologías de desarrollo neceserias y servicios
if [ ! -x "$(command -v docker)" ] && [ ! -x "$(command -v docker-compose)" ]; then
    progress "95" "Instalando Docker"
    sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg -y
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
    sudo apt-get install docker-compose -y
    sudo docker run hello-world
    progress "100" "Docker instalado"
else
    progress "100" "Ya tienes instalado Docker"
fi

bye_bye
