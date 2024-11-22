#!/bin/bash
if [ "$EUID" -ne 0 ]; then
  echo "Run the script with administrator privileges (sudo)."
  exit 1
fi
if [ ! -d "/opt/monitor_api" ]; then
  sudo mkdir -p /opt/monitor_api
fi
if [ -e /opt/monitor_api/deploy_monitor_api.sh ]; then
  sudo rm /opt/monitor_api/deploy_monitor_api.sh
fi
sudo cp deploy_monitor_api.sh /opt/monitor_api/
if [ -e /etc/systemd/system/monitor_api.service ]; then
  sudo rm /etc/systemd/system/monitor_api.service
fi
sudo cp monitor_api.service /etc/systemd/system/
sudo chmod +x /opt/monitor_api/deploy_monitor_api.sh
sudo systemctl daemon-reload
if ! sudo systemctl enable monitor_api.service; then
  echo "Помилка під час активації сервісу."
  exit 1
fi
if ! sudo systemctl start monitor_api.service; then
  echo "Помилка під час запуску сервісу."
  exit 1
fi
echo "Скрипт завершено."
exit 0
