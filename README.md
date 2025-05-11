# Alert Explorer View

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
  SELECT DISTINCT alert 
  FROM alert_logs 
  ORDER BY alert;
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


