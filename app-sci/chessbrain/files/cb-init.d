#!/sbin/runscript

cpus=`egrep -c "^processor" /proc/cpuinfo`

checkconfig() {
        if [ ! -e ${CHESSBRAIN_DIR} ]
        then
                einfo "Creating ${CHESSBRAIN_DIR}"
                mkdir ${CHESSBRAIN_DIR}
        fi

        if [ $cpus != '1' ]; then
                cd ${CHESSBRAIN_DIR}
                for cpu in `seq 2 $cpus`; do
		if [ ! -e ${CHESSBRAIN_DIR}/cpu${cpu} ]; then
				mkdir ${CHESSBRAIN_DIR}/cpu${cpu}
                                cp ${CHESSBRAIN_DIR}/* ${CHESSBRAIN_DIR}/cpu${cpu} > /dev/null
                                cp ${CHESSBRAIN_DIR}/cbspan.conf ${CHESSBRAIN_DIR}/cpu${cpu}
                        fi
                done
        fi
}

start() {
        checkconfig


        if [ $cpus = '1' ]; then
                ebegin "Starting ChessBrain"
        else
                ebegin "Starting ChessBrain ($cpus processors)"
        fi

        for cpu in `seq 1 $cpus`; do
                cd ${CHESSBRAIN_DIR}
                if [ $cpu != '1' ]; then
                        cd cpu${cpu}
                fi

                ./cbspn >&/dev/null&
        done

        eend $?
}

stop() {
        ebegin "Stopping ChessBrain"
        killall cbspn
        eend $?
}
