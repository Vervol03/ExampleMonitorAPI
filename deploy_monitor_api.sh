#!/bin/bash
start() {
    cd /opt/monitor_api/
    python3 -m http.server 8080 > /dev/null 2>&1 &
    echo $! > /opt/monitor_api/server.pid
}
stop() {
    kill -s SIGKILL $(cat /opt/monitor_api/server.pid)
    rm /opt/monitor_api/server.pid
}
case $1 in
    start|stop) "$1" ;;
esac
