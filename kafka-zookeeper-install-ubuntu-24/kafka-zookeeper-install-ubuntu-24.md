# 🚀 Kafka 3.x Installation on Ubuntu 24.04 (ZooKeeper Mode)

## 📚 Overview

This guide explains how to **install Apache Kafka 3.x on Ubuntu 24.04 using ZooKeeper**, including:

- Source build using Gradle  
- PM2-based process management  
- Custom log configuration  
- Production-ready structure  

This setup is useful for:
- Legacy Kafka deployments  
- ZooKeeper-based clusters  
- Learning Kafka internals  

---

## ⚙️ Prerequisites

- Ubuntu 24.04
- Minimum 4GB RAM (8GB recommended)
- Root or sudo access
- Open ports:
  - `2181` → ZooKeeper
  - `9092` → Kafka

---

## 1️⃣ Update System

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 2️⃣ Install Dependencies

```bash
sudo apt install -y net-tools curl openjdk-17-jdk openjdk-17-jre
```

Verify Java:

```bash
java -version
```

---

## 3️⃣ Install Node.js, npm & PM2

```bash
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g pm2
sudo npm install -g npm@10.2.0
```

Verify:

```bash
node -v
npm -v
pm2 -v
```

---

## 4️⃣ Download Kafka Source

```bash
cd /opt
sudo mkdir -p source && cd source

sudo wget https://downloads.apache.org/kafka/3.5.1/kafka-3.5.1-src.tgz
sudo tar -xvzf kafka-3.5.1-src.tgz

cd kafka-3.5.1-src
```

---

## 5️⃣ Build Kafka (Gradle)

```bash
./gradlew jar -PscalaVersion=2.13.10
```

---

## 6️⃣ Configure ZooKeeper

Edit file:

```bash
nano config/zookeeper.properties
```

Set:

```properties
dataDir=/opt/kafka-logs/zookeeper
clientPort=2181
```

---

## 7️⃣ Configure Kafka

Edit:

```bash
nano config/server.properties
```

Update:

```properties
log.dirs=/opt/kafka-logs/kafka
listeners=PLAINTEXT://0.0.0.0:9092
advertised.listeners=PLAINTEXT://YOUR_SERVER_IP:9092
zookeeper.connect=localhost:2181
```

---

## 8️⃣ Create Log Directories

```bash
mkdir -p /opt/kafka-logs/kafka
mkdir -p /opt/kafka-logs/zookeeper
```

---

## 9️⃣ Create Start Scripts

### ZooKeeper Script

```bash
cat <<EOF > zookeeper.sh
#!/bin/bash
bin/zookeeper-server-start.sh config/zookeeper.properties
EOF

chmod +x zookeeper.sh
```

---

### Kafka Script

```bash
cat <<EOF > kafka.sh
#!/bin/bash
bin/kafka-server-start.sh config/server.properties
EOF

chmod +x kafka.sh
```

---

## 🔟 Start Services Using PM2

```bash
pm2 start zookeeper.sh --name zookeeper
pm2 start kafka.sh --name kafka
```

---

## 1️⃣1️⃣ Save PM2 Configuration

```bash
pm2 save
pm2 startup systemd
```

Run the generated command shown.

---

## 1️⃣2️⃣ Verify Services

```bash
pm2 list
pm2 logs kafka
pm2 logs zookeeper
```

---

## 1️⃣3️⃣ Verify Ports

```bash
netstat -tunlp | grep -E "9092|2181"
```

---

## 1️⃣4️⃣ Test Kafka

### Create Topic

```bash
bin/kafka-topics.sh \
--create \
--topic test-topic \
--bootstrap-server localhost:9092
```

---

### Producer

```bash
bin/kafka-console-producer.sh \
--topic test-topic \
--bootstrap-server localhost:9092
```

---

### Consumer

```bash
bin/kafka-console-consumer.sh \
--topic test-topic \
--from-beginning \
--bootstrap-server localhost:9092
```

---

## ⚠️ Important Notes

- Kafka 3.x requires ZooKeeper
- Default ports:
  - ZooKeeper → 2181  
  - Kafka → 9092  
- Ensure correct `advertised.listeners`
- Avoid using `/tmp` for logs in production

---

## 🚀 Production Recommendations

- Use **systemd instead of PM2** for stability
- Configure:
  - Log retention policies  
  - Replication factor  
  - Security (SSL/SASL)  
- Deploy multi-broker clusters for HA

---

## 🔁 PM2 Commands

```bash
pm2 restart kafka
pm2 restart zookeeper

pm2 stop kafka
pm2 stop zookeeper

pm2 delete kafka
pm2 delete zookeeper
```

---

## 📈 Keywords

kafka zookeeper install ubuntu  
kafka 3 installation ubuntu  
apache kafka zookeeper setup  
kafka devops setup ubuntu  
kafka build from source  
kafka pm2 setup  
