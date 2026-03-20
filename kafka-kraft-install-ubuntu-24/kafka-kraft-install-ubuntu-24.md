
# 🚀 Kafka 4.x Installation on Ubuntu 24.04 (KRaft Mode - No ZooKeeper)

## 📚 Overview

This guide provides a **step-by-step installation of Apache Kafka 4.x on Ubuntu 24.04 using KRaft mode**, which eliminates the need for ZooKeeper.

KRaft (Kafka Raft Metadata mode) is the **modern architecture** for Kafka, simplifying deployment and improving scalability.

---

## ⚙️ Prerequisites

- Ubuntu Server 24.04
- Minimum 2 CPU / 4GB RAM (8GB recommended)
- Root or sudo access
- Open port: `9092`

---

## 1️⃣ Update System

```bash
sudo apt update && sudo apt upgrade -y
```

---

## 2️⃣ Install Java (Required)

Kafka requires Java (OpenJDK 17 or 21 recommended).

```bash
sudo apt install -y openjdk-21-jdk
```

Verify installation:

```bash
java -version
```

---

## 3️⃣ Download Apache Kafka 4.x

```bash
cd /opt
sudo wget https://downloads.apache.org/kafka/4.2.0/kafka_2.13-4.2.0.tgz
```

---

## 4️⃣ Extract and Setup Kafka

```bash
sudo tar -xvzf kafka_2.13-4.2.0.tgz
sudo mv kafka_2.13-4.2.0 kafka
```

---

## 5️⃣ Create Kafka User (Recommended)

```bash
sudo useradd -r -m -d /opt/kafka -s /bin/false kafka
sudo chown -R kafka:kafka /opt/kafka
```

---

## 6️⃣ Generate Kafka Cluster ID (KRaft Mode)

```bash
cd /opt/kafka
bin/kafka-storage.sh random-uuid
```

Example output:

```text
9M5v7E9yTz6l3Z7Z1xWgkg
```

---

## 7️⃣ Format Kafka Storage

Replace `YOUR_CLUSTER_ID` with the generated ID:

```bash
bin/kafka-storage.sh format -t YOUR_CLUSTER_ID -c config/kraft/server.properties
```

---

## 8️⃣ Configure Kafka (Optional but Recommended)

Edit configuration:

```bash
nano config/kraft/server.properties
```

Important settings:

```properties
listeners=PLAINTEXT://0.0.0.0:9092
advertised.listeners=PLAINTEXT://YOUR_SERVER_IP:9092
log.dirs=/opt/kafka/logs
```

---

## 9️⃣ Start Kafka Server

```bash
bin/kafka-server-start.sh config/kraft/server.properties
```

You should see logs indicating:

```text
Kafka Server started
```

---

## 🔟 Test Kafka Setup

### Create Topic

```bash
bin/kafka-topics.sh --create \
--topic test-topic \
--bootstrap-server localhost:9092
```

---

### List Topics

```bash
bin/kafka-topics.sh --list --bootstrap-server localhost:9092
```

---

## 1️⃣1️⃣ Test Producer

```bash
bin/kafka-console-producer.sh \
--topic test-topic \
--bootstrap-server localhost:9092
```

Type messages and press Enter.

---

## 1️⃣2️⃣ Test Consumer

Open a new terminal:

```bash
bin/kafka-console-consumer.sh \
--topic test-topic \
--from-beginning \
--bootstrap-server localhost:9092
```

You should see produced messages.

---

## 1️⃣3️⃣ Run Kafka as a Systemd Service (Production)

Create service file:

```bash
sudo nano /etc/systemd/system/kafka.service
```

Add:

```ini
[Unit]
Description=Apache Kafka Server (KRaft Mode)
After=network.target

[Service]
Type=simple
User=kafka
ExecStart=/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/kraft/server.properties
ExecStop=/opt/kafka/bin/kafka-server-stop.sh
Restart=always

[Install]
WantedBy=multi-user.target
```

---

### Enable and Start Kafka

```bash
sudo systemctl daemon-reload
sudo systemctl enable kafka
sudo systemctl start kafka
```

---

### Check Status

```bash
systemctl status kafka
```

---

## 1️⃣4️⃣ Open Firewall (If Required)

```bash
sudo ufw allow 9092/tcp
sudo ufw reload
```

---

## 1️⃣5️⃣ Verify Kafka Running

```bash
ss -tulnp | grep 9092
```

---

---

# 🔥 🔁 Run Kafka Using PM2 (Recommended for DevOps)

## 1️⃣ Install PM2

```bash
sudo apt install -y nodejs npm
sudo npm install -g pm2
```

---

## 2️⃣ Start Kafka via PM2

```bash
cd /opt/kafka

pm2 start "bin/kafka-server-start.sh config/kraft/server.properties" \
--name kafka
```

---

## 3️⃣ Save PM2 Process

```bash
pm2 save
```

---

## 4️⃣ Enable Auto Start on Boot

```bash
pm2 startup systemd
```

Run the command output shown (important).

---

## 5️⃣ Verify PM2 Kafka Process

```bash
pm2 list
pm2 logs kafka
```

---

## 🔁 Restart / Stop Kafka via PM2

```bash
pm2 restart kafka
pm2 stop kafka
pm2 delete kafka
```

---


## ⚠️ Important Notes

- Kafka 4.x uses **KRaft mode (no ZooKeeper required)**
- Default port: **9092**
- Ensure correct **advertised.listeners** for external access
- For production:
  - Enable SSL/SASL authentication
  - Configure log retention policies
  - Use multiple brokers

---

## 🚀 Next Steps (Production Ready)

- Multi-node Kafka cluster setup
- Load balancing (Nginx / LB)
- Monitoring (Prometheus + Grafana)
- Kafka Connect & Schema Registry

---

## 📈 Keywords

kafka kraft install ubuntu  
kafka 4 installation ubuntu  
kafka without zookeeper  
apache kafka ubuntu 24 setup  
kafka server installation guide  
kafka devops setup  
