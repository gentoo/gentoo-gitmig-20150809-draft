#! /bin/sh

LOG=/var/log/monetdb/Mserver.log
echo `date` Starting MonetDB >> $LOG
/usr/bin/Mserver $@ >> $LOG 2>&1 &
MPID=$!
echo `date` Mserver started, PID: $MPID >> $LOG
rm -f ~monetdb/Mserver.pid > /dev/null
sleep 2
ALIVE=`ps --no-heading --format pid -p $MPID`
if [ $ALIVE -eq $MPID ]; then
	echo $MPID > ~monetdb/Mserver.pid
else
	echo Mserver died immediately
	exit -1
fi
