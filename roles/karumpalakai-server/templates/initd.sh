#!/bin/bash
# chkconfig: 345 80 20
# description: Karumpalakai
### BEGIN INIT INFO
# Provides: karumpalakai
# Required-Start: $network postgresql-9.3
# Required-Stop: $network postgresql-9.3
# Default-Start: 3 4 5
# Default-Stop: 0 1 2 6
# Description: Starts the karumpalakai service
### END INIT INFO

APP_NAME=karumpalakai
APP_PORT=8080

SERVICE_DIR=/application/$APP_NAME
SERVICE_BASE_URL=http://localhost:$APP_PORT
CUR_USER=`whoami`

LOGS=$SERVICE_DIR/karumpalakai.log

# Lsb functions to perform the operations.
#. /lib/lsb/init-functions
log_success_msg() {
  echo "$*"
}

log_failure_msg() {
  echo "$*"
}

check_proc() {
  pgrep -u karumpalakai -f $SERVICE_DIR/$APP_NAME.jar >/dev/null
}

start_service() {
  if [ "${CUR_USER}" != "root" ] && [ "${CUR_USER}" != "karumpalakai" ]; then
    log_failure_msg "karumpalakai can only be started as 'root' or karumpalakai user."
    exit 4
  fi

  check_proc
  if [ $? -eq 0 ]; then
    log_success_msg "karumpalakai already running."
    exit 0
  fi

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