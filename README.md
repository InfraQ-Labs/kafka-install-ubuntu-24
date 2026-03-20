# kafka-install-ubuntu-24
Install Apache Kafka on Ubuntu 24.04 using KRaft mode (Kafka 4.x without ZooKeeper) and legacy ZooKeeper setup (Kafka 3.x). Complete step-by-step DevOps guide with scripts, testing, and production configuration.

# 🚀 Apache Kafka Installation on Ubuntu 24.04 | KRaft (Kafka 4.x) + ZooKeeper (Kafka 3.x)

[![Kafka Docs](https://img.shields.io/badge/docs-apache%20kafka-blue)](https://kafka.apache.org/documentation/)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Ubuntu](https://img.shields.io/badge/OS-Ubuntu%2024.04-orange)]()
[![Kafka](https://img.shields.io/badge/Kafka-4.x%20%7C%203.x-black)]()
[![Setup](https://img.shields.io/badge/setup-automated-success)]()
[![Maintained](https://img.shields.io/badge/status-maintained-brightgreen)]()

---

## 📑 Table of Contents

- Overview  
- Quick Start  
- Why This Repository  
- Features  
- Installation Guides  
- Architecture  
- Getting Started Resources  
- Advanced Topics  
- Project Structure  
- Important Notes  
- License  
- Keywords  

---

## 📚 Overview

This repository provides a **complete step-by-step guide to install Apache Kafka on Ubuntu 24.04**, covering both:

- ✅ **Kafka 4.x (KRaft Mode — No ZooKeeper)**
- ✅ **Kafka 3.x (ZooKeeper-based setup)**

It includes **automated scripts, manual guides, and production-ready configurations** designed for:

- DevOps Engineers  
- Cloud Engineers  
- Backend Engineers  
- Kafka Beginners & Professionals  

---

## 🚀 Quick Start

### 🔹 Kafka 4.x (KRaft Mode - Recommended)

```bash
cd kafka-kraft-install-ubuntu-24
chmod +x install-kafka-kraft-ubuntu-24.sh
./install-kafka-kraft-ubuntu-24.sh
```

---

### 🔹 Kafka 3.x (ZooKeeper Mode)

```bash
cd kafka-zookeeper-install-ubuntu-24
chmod +x install-kafka-zookeeper-ubuntu-24.sh
./install-kafka-zookeeper-ubuntu-24.sh
```

---

## ⭐ Why This Repository?

- Optimized for **Ubuntu 24.04 LTS**
- Covers both **modern (KRaft)** and **legacy (ZooKeeper)** setups
- Includes **automation scripts + manual guides**
- Production-ready configuration
- Clean and DevOps-friendly structure

---

## ⚡ Features

- ✅ Kafka 4.x installation using KRaft (no ZooKeeper)
- ✅ Kafka 3.x installation using ZooKeeper
- ✅ Automated installation scripts
- ✅ systemd service setup
- ✅ Topic creation & testing
- ✅ Production-ready configuration guidance
- ✅ Clean DevOps-friendly structure

---

## 📘 Installation Guides

### 🔹 Kafka 4.x (KRaft Mode)

👉 **[Install Kafka 4.x (KRaft Mode) on Ubuntu 24.04](./kafka-kraft-install-ubuntu-24/kafka-kraft-install-ubuntu-24.md)**

---

### 🔹 Kafka 3.x (ZooKeeper Mode)

👉 **[Install Kafka 3.x with ZooKeeper on Ubuntu 24.04](./kafka-zookeeper-install-ubuntu-24/kafka-zookeeper-install-ubuntu-24.md)**

---

## 🏗️ Architecture

- Kafka 4.x uses **KRaft mode (no ZooKeeper required)**
- Kafka 3.x uses **ZooKeeper for cluster coordination**
- Default Kafka port: **9092**
- Supports **single-node and multi-node setups**

---

## 🌱 Getting Started Resources

- Apache Kafka Documentation: https://kafka.apache.org/documentation/  
- Kafka Quickstart: https://kafka.apache.org/quickstart  
- Kafka Configuration Guide: https://kafka.apache.org/documentation/#configuration  

---

## 🚀 Advanced Topics Covered

- Kafka KRaft vs ZooKeeper architecture  
- Multi-broker cluster setup  
- Log retention & storage tuning  
- JVM memory optimization  
- Firewall & security configuration  
- Monitoring (JMX, Prometheus, Grafana)  
- Kafka performance tuning  

---

## 📂 Project Structure

```
kafka-install-ubuntu-24/
│
├── README.md
├── LICENSE
│
├── kafka-kraft-install-ubuntu-24/
│   ├── install-kafka-kraft-ubuntu-24.sh
│   └── kafka-kraft-install-ubuntu-24.md
│
├── kafka-zookeeper-install-ubuntu-24/
│   ├── install-kafka-zookeeper-ubuntu-24.sh
│   └── kafka-zookeeper-install-ubuntu-24.md
│
└── assets/
    └── kafka-installation-architecture-ubuntu-24.png
```

---

## ⚠️ Important Notes

- Install Java (OpenJDK 17 or 21 recommended)  
- Ensure port **9092** is open  
- Use systemd for production deployments  
- For production:
  - Enable authentication (SASL/SSL)  
  - Configure log retention  
  - Use multi-broker setup  

---

## 📄 License

MIT License

---

## 📈 Keywords

kafka install ubuntu 24.04  
apache kafka installation ubuntu  
kafka kraft install ubuntu  
kafka without zookeeper  
kafka 4 installation guide  
kafka zookeeper setup ubuntu  
kafka devops setup  
kafka server ubuntu  
