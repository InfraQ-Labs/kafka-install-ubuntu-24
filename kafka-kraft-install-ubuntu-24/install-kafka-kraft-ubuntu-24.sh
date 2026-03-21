#!/bin/bash

set -e

echo "🚀 Installing Kafka 4.x (KRaft Mode) on Ubuntu 24.04"

########################################
# 🔧 Install Dependencies
########################################
sudo apt update
sudo apt install -y curl wget net-tools openjdk-21-jdk

# Install Node.js + PM2
if ! command -v pm2 &> /dev/null
then
    echo "📦 Installing Node.js & PM2..."
    curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
    sudo apt install -y nodejs
    sudo npm install -g pm2
fi

########################################
# 📁 Setup Kafka Directory
########################################
cd /opt
sudo mkdir -p kafka
cd kafka

########################################
# 📥 Download Kafka 4.x
########################################
sudo wget https://downloads.apache.org/kafka/4.2.0/kafka_2.13-4.2.0.tgz
sudo tar -xzf kafka_2.13-4.2.0.tgz
sudo mv kafka_2.13-4.2.0 kraft

cd kraft

########################################
# 🆔 Generate Cluster ID
########################################
CLUSTER_ID=$(bin/kafka-storage.sh random-uuid)
echo "Cluster ID: $CLUSTER_ID"

########################################
# ⚙️ Configure KRaft
########################################
sudo sed -i 's|^#*listeners=.*|listeners=PLAINTEXT://0.0.0.0:9092,CONTROLLER://0.0.0.0:9093|' config/kraft/server.properties
sudo sed -i 's|^#*advertised.listeners=.*|advertised.listeners=PLAINTEXT://localhost:9092|' config/kraft/server.properties

########################################
# 💾 Format Storage
########################################
bin/kafka-storage.sh format -t $CLUSTER_ID -c config/kraft/server.properties

########################################
# ▶️ Start Kafka (PM2)
########################################
pm2 start "bin/kafka-server-start.sh config/kraft/server.properties" --name kafka-kraft

pm2 save
pm2 startup systemd

########################################
# ✅ Verify
########################################
echo "Kafka KRaft Running..."
pm2 list
netstat -tunlp | grep 9092
