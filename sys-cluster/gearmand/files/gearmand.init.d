#!/sbin/runscript
# Copyright 2009 Pavel Stratil, senbonzakura.eu
# Distributed under the terms of the GNU General Public License v2

depend() {
	use localmount

	case $PERSISTENT in
	  drizzle)
	    use drizzle
	    ;;
	  memcache)
	    use memcache
	    ;;
	  mysql)
	    use mysql
	    ;;
	  postgre)
	    use postgresql
	    ;;
	  *)
	    ;;
	esac
}

start() {
	case ${PERSISTENT:-none} in
	  drizzle|mysql)
	    GEARMAND_PARAMS="${GEARMAND_PARAMS} -q libdrizzle"
            [ ${PERSISTENT_HOST}   ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libdrizzle-host=${PERSISTENT_HOST}"
            [ ${PERSISTENT_USER}   ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libdrizzle-user=${PERSISTENT_USER}"
            [ ${PERSISTENT_PASS}   ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libdrizzle-password=${PERSISTENT_PASS}"
            [ ${PERSISTENT_DB}     ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libdrizzle-db=${PERSISTENT_DB}"
            [ ${PERSISTENT_TABLE}  ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libdrizzle-table=${PERSISTENT_TABLE}"
            [ ${PERSISTENT_PORT}   ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libdrizzle-port=${PERSISTENT_PORT}"
            [ ${PERSISTENT_SOCKET} ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libdrizzle-uds=${PERSISTENT_SOCKET}"
            [ ${PERSISTENT} == "mysql" ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libdrizzle-mysql"
	    ;;
	  memcache)
	    [ ${PERSISTENT_SERVERLIST} ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} -q libmemcached --libmemcached-servers=${PERSISTENT_SERVERLIST}"
	    ;;
	  postgre)
	    GEARMAND_PARAMS="${GEARMAND_PARAMS} -q libpq"
            [ ${PERSISTENT_HOST}   ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libpq-host=${PERSISTENT_HOST}"
            [ ${PERSISTENT_USER}   ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libpq-user=${PERSISTENT_USER}"
            [ ${PERSISTENT_PASS}   ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libpq-password=${PERSISTENT_PASS}"
            [ ${PERSISTENT_DB}     ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libpq-dbname=${PERSISTENT_DB}"
            [ ${PERSISTENT_PORT}   ] && GEARMAND_PARAMS="${GEARMAND_PARAMS} --libpq-port=${PERSISTENT_PORT}"
            [ ${PERSISTENT_TABLE}  ] && ewarn "Libpq doesn't recognise 'table' parameter."
            [ ${PERSISTENT_SOCKET} ] && ewarn "Libpq doesn't recognise 'socket' parameter. If no host is set, it automatically falls back to a socket."
	    ;;
	  sqlite)
	    GEARMAND_PARAMS="${GEARMAND_PARAMS} -q libsqlite3 --libsqlite3-db=${PERSISTENT_FILE}"
	    ;;
          none)
            ;;
	  *)
            eerror "Wrong persistent queue store setting in /etc/conf.d/gearmand."
	    return 1
	    ;;
	esac

	ebegin "Starting ${SVCNAME}"
        start-stop-daemon --pidfile /var/run/gearmand/gearmand.pid --start \
		--exec /usr/sbin/gearmand -- --pid-file=/var/run/gearmand/gearmand.pid \
		--user=gearmand --daemon \
		--log-file=/var/log/gearmand/gearmand.log ${GEARMAND_PARAMS}
	eend $?
}

stop() {
	ebegin "Stopping ${SVCNAME}"
	start-stop-daemon --pidfile /var/run/gearmand/gearmand.pid --stop \
		--exec /usr/sbin/gearmand
	eend $?
}
