#!/bin/bash

set -e

echo "🚀 Installing Kafka 3.x (ZooKeeper + Source Build) on Ubuntu 26.04"

########################################
# 🔧 Install Dependencies
########################################
sudo apt update
sudo apt install -y curl wget net-tools openjdk-17-jdk git

# Install Node.js + PM2
if ! command -v pm2 &> /dev/null
then
    echo "📦 Installing Node.js & PM2..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt install -y nodejs
    sudo npm install -g pm2
fi

########################################
# 📁 Setup Directory
########################################
cd /opt
sudo mkdir -p kafka-src
cd kafka-src

########################################
# 📥 Download Kafka Source (3.x)
########################################
wget https://downloads.apache.org/kafka/3.5.1/kafka-3.5.1-src.tgz
tar -xzf kafka-3.5.1-src.tgz
cd kafka-3.5.1-src

########################################
# ⚙️ Configure Paths
########################################
mkdir -p KAFKA-LOGS/kafka
mkdir -p KAFKA-LOGS/zookeeper

echo "log.dirs=$(pwd)/KAFKA-LOGS/kafka" >> config/server.properties
echo "dataDir=$(pwd)/KAFKA-LOGS/zookeeper" >> config/zookeeper.properties

########################################
# 🏗️ Build Kafka using Gradle
########################################
echo "⚙️ Building Kafka (Gradle)... This may take time..."

chmod +x gradlew
./gradlew jar -PscalaVersion=2.13.10

########################################
# 📜 Create Start Scripts
########################################
cat <<EOF > zookeeper.sh
#!/bin/bash
$(pwd)/bin/zookeeper-server-start.sh $(pwd)/config/zookeeper.properties
EOF

cat <<EOF > kafka.sh
#!/bin/bash
$(pwd)/bin/kafka-server-start.sh $(pwd)/config/server.properties
EOF

chmod +x zookeeper.sh kafka.sh

########################################
# ▶️ Start Services via PM2
########################################
pm2 start zookeeper.sh --name zookeeper
sleep 5
pm2 start kafka.sh --name kafka-zk

pm2 save
pm2 startup systemd

########################################
# ✅ Verify
########################################
echo "Kafka (ZooKeeper Mode) Running..."
pm2 list
netstat -tunlp | grep -E "9092|2181"
