#! /bin/sh

LOG=/var/log/monetdb/Mserver.log
if [ -f ~monetdb/Mserver.pid ]; then
	MPID=`cat ~monetdb/Mserver.pid`
else
	echo "No Mserver PID found"
	exit -1
fi

echo `date` Stopping MonetDB \(PID: $MPID\) >> $LOG
kill -TERM $MPID || exit -1
sleep 1
ALIVE=`ps --no-heading --format pid -p $MPID`
if [ "$ALIVE" = "$MPID" ]; then
	echo Mserver still alive after TERM, trying KILL... >> $LOG
	kill -KILL $MPID
	sleep 2
	ALIVE=`ps --no-heading --format pid -p $MPID`
	if [ "$ALIVE" = "$MPID" ]; then
		echo "Failed to stop process $MPID"
		exit -1
	fi
fi
echo `date` Mserver stopped >> $LOG
rm -f ~monetdb/Mserver.pid > /dev/null
