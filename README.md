


Step1:
Variable's Declaration in Alert Explorer View (Variable's_Mapping in grafana UI Dashboards Settings)
---------------------------------------------


1.Plant_Name-->  type - custom,
                custom options- Saran_Solar_KIWI,Reinfra_Revathi_Stores


2.Alert_Type--> type - Query,(Query options ----> Datasource-> Alert-logs_MYSQL )
                Query-SELECT DISTINCT alert_type FROM alert_logs WHERE plant_name IN (${plant_name}) ORDER BY alert_type;

3.Alert   -->  type - Query,(Query options ----> Datasource-> Alert-logs_MYSQL )
               Query - SELECT DISTINCT alert FROM alert_logs ORDER BY alert


(*********Datasource- Alert-logs_MYSQL )


Step2: Select Datasource as sql inside panel and paste this query

SELECT
  timestamp AS time,
  mac_address AS MAC,
  plant_name AS Plant,
  alert AS `Alert Message`,
  mobile AS Recipient,
  alert_type AS `Type`
FROM alert_logs
WHERE $__timeFilter(timestamp)
  AND plant_name IN ($plant_name)
  AND alert IN ($alert)
  AND alert_type IN ($alert_type)
ORDER BY time DESC;
