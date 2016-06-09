#!/bin/bash
# chkconfig: 345 80 20
# description: karumpalakai
### BEGIN INIT INFO
# Provides: karumpalakai
# Default-Start: 3 4 5
# Default-Stop: 0 1 2 6
# Description: Starts karumpalakai
### END INIT INFO

APP_NAME=karumpalakai
JAR_NAME=Karum_palakai-1.0-SNAPSHOT
APP_PORT=8080

SERVICE_DIR=/application/
SERVICE_BASE_URL=http://localhost:$APP_PORT

# Lsb functions to perform the operations.
#. /lib/lsb/init-functions
log_success_msg() {
  echo "$*"
}

log_failure_msg() {
  echo "$*"
}

check_proc() {
  pgrep -u karumpalakai -f $SERVICE_DIR/$JAR_NAME.jar >/dev/null
}



start_service() {
  check_proc
  if [ $? -eq 0 ]; then
    log_success_msg "karumpalakai already running."
    exit 0
  fi

    nohup /bin/su - karumpalakai -c "java  -jar $SERVICE_DIR/$JAR_NAME.jar  -Dhttp.port=$APP_PORT --server.port=$APP_PORT" 2> /application/error.log > /application/karumpalakai.log &
  sleep 1
  check_proc
  if [ $? -eq 0 ]; then
    log_success_msg "karumpalakai process is running."
  else
    log_failure_msg "karumpalakai process is not running."
    exit -1
  fi
}

service_status() {
  check_proc
  if [ $? -eq 0 ]; then
    log_success_msg "karumpalakai is running."
  else
    log_failure_msg "karumpalakai is stopped."
    exit 3
  fi
}

case "$1" in
  start)
  start_service
  ;;
  stop)
  stop_service
  ;;
  status)
  service_status
  ;;
  *)
  echo "Usage: $0 {start|stop|status}"
  exit 1
esac

exit 0