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
