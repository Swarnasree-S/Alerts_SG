
(my task)
## Step 1: Variable Declaration in Alert Explorer View
*(Located under Dashboard Settings → Variables Mapping in Grafana UI)*

### 1. `Plant_Name`
- **Type:** Custom  
- **Options:**  
  `Saran_Solar_KIWI`, `Reinfra_Revathi_Stores`

### 2. `Alert_Type`
- **Type:** Query  
- **Datasource:** `Alert-logs_MYSQL`  
- **Query:**
  ```sql
  SELECT DISTINCT alert_type 
  FROM alert_logs 
  WHERE plant_name IN (${plant_name}) 
  ORDER BY alert_type;
  ```

### 3. `Alert`
- **Type:** Query  
- **Datasource:** `Alert-logs_MYSQL`  
- **Query:**
  ```sql
  SELECT DISTINCT alert FROM alert_logs WHERE plant_name IN (${plant_name}) AND alert_type IN (${alert_type}) ORDER BY alert;
  ```

---

## Step 2: Panel Query
Paste the following query inside your panel:

```sql
SELECT 
  timestamp AS time, 
  mac_address AS MAC, 
  plant_name AS Plant, 
  alert AS "Alert Message", 
  mobile AS Recipient, 
  alert_type AS Type 
FROM alert_logs 
WHERE 
  $__timeFilter(timestamp) 
  AND plant_name IN ($plant_name) 
  AND alert IN ($alert) 
  AND alert_type IN ($alert_type) 
ORDER BY time DESC;
```

----------------------------------------------------------------------------------------------------------------------------

(brother_deepak_task) 
MQTT to WhatsApp Alert Publisher with MySQL Logging
This project listens to MQTT topics for alert messages, sends formatted WhatsApp alerts using the TextMeBot API, and logs the alerts into a MySQL database. It supports customer-specific plant configurations.

📁 Project Structure
mqtt-whatsapp-publisher/
├── mqtt-whatsapp-publisher-json-config-parsing.py  # Main Python script
├── config.json                                     # MQTT & WhatsApp config
├── customer_asset.json                             # Plant & mobile mapping
├── requirements.txt                                # Required Python packages
├── Dockerfile                                      # Containerized setup
🔧 Prerequisites
Python 3.7 or above (or Docker)
MySQL database (configured separately)
Grafana (optional, for visualization)
📦 Installation (Without Docker)
Clone this repo:

git clone <your-repo-url>
cd mqtt-whatsapp-publisher
Install dependencies:

pip install -r requirements.txt
MySQL Setup: Use the following to create the database and table:

CREATE DATABASE IF NOT EXISTS renewgrid_observability;

USE renewgrid_observability;

CREATE TABLE alert_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp DATETIME,
    mac_address VARCHAR(255),
    plant_name VARCHAR(255),
    alert TEXT,
    mobile VARCHAR(20),
    alert_type VARCHAR(20)
);
⚙️ Configuration
1. config.json
{
  "mqtt": {
    "broker": "mqtt.renewgrid.in",
    "port": 1883,
    "username": "admin",
    "password": "password",
    "topic": "test",
    "client_id": "mqttx_68118ef4"
  },
  "whatsapp": {
    "api_url": "https://api.textmebot.com/send.php",
    "api_key": "<your-textmebot-api-key>"
  },
  "mysql": {
    "host": "mysql.dev.renewgrid.in",
    "user": "root",
    "password": "Q2bFBY5BjgUEe8KZp",
    "database": "renewgrid_observability"
  }
}
2. customer_asset.json
{
  "plants": [
    {
      "44-B7-D0-9E-99-3F": {
        "Mobile": "+917358164516",
        "Plantname": "Saran_Solar_KIWI"
      }
    },
    {
      "9C-95-6E-78-E3-EB": {
        "Mobile": "+918122643284",
        "Plantname": "Reinfra_Revathi_Stores"
      }
    }
  ]
}
🚀 Running the Script
✅ Locally
python mqtt-whatsapp-publisher-json-config-parsing.py
🐳 With Docker
1. Build Docker Image:
docker build -t mqtt-whatsapp-publisher .
2. Run the Container:
docker run -d \
  --name mqtt-whatsapp-publisher \
  -v /home/mqtt-config/config.json:/app/config.json \
  -v /home/mqtt-config/customer_asset.json:/app/customer_asset.json \
  mqtt-whatsapp-publisher
Make sure your config files are available in /home/mqtt-config/.

📊 Grafana Integration (Optional)
Add MySQL data source in Grafana
Point to renewgrid_observability.alert_logs
Use time series or table panels for visualization
📄 Example MQTT Payload
{
  "alert": "Inverter01 error: Power Grid Failure.",
  "mac": "44-B7-D0-9E-99-3F",
  "alert_type": "ERROR"
}
📃 License
MIT License

🤝 Contributions
PRs welcome for additional alert types, Grafana templates, or database enhancements.# Alert Explorer View




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
