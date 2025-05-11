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
Step2:
