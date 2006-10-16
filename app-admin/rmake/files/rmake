#/sbin/runscript
#
# Copyright (c) 2006 rPath, Inc.
#
# Distributed under the terms of the Common Public License, version 1.0
# A copy can be found here: http://www.rpath.com/permanent/cpl-license.html
#
# Gentoo Linux style initscript

if [ -e /etc/sysconfig/rmake ] ; then
    . /etc/sysconfig/rmake
fi

depend() {
    use logger
}

config() {
    cd /etc/rmake;
    /usr/sbin/rmake-server config
    return $?
}


start() {
    ebegin "Starting rMake Server and Repository:"
    cd /etc/rmake;
    /usr/sbin/rmake-server start
    RETVAL=$?
    [ $RETVAL = 0 ] && touch /var/lock/subsys/rmake
    eend $RETVAL
}

startdebug() {
    ebegin "Starting rMake Server and Repository in debug mode:"
    cd /etc/rmake;
    /usr/sbin/rmake-server start -n -d
    RETVAL=$?
    eend $RETVAL
}



stop() {
    ebegin "Shutting down rMake Server and Repository: "
    cd /etc/rmake;
    /usr/sbin/rmake-server stop
    RETVAL=$?
    [ $RETVAL = 0 ] && rm -f /var/lock/subsys/rmake
    eend $RETVAL
}

restart() {
    stop
    start
}

reset() {
    stop
    resetinternal || return $?
    start || return $?
}

resetinternal() {
    ebegin "Flushing rMake internal repository and database"
    cd /etc/rmake;
    /usr/sbin/rmake-server reset
    RETVAL=$?
    eend $RETVAL
}

RETVAL=0

# See how we were called.
case "$1" in
    config)
        config
        ;;
    start)
        start
        ;;
    stop)
        stop
        ;;
    debug)
        startdebug
        ;;
    status)
        status rmake-server
        ;;
    restart|reload)
        restart
        ;;
    reset)
        reset
        ;;
    *)
        echo "Usage: $0 {start|stop|debug|status|restart|reload|config|reset}"
        exit 1
esac

exit $?
