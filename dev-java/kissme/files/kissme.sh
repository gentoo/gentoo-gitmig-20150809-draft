#! /bin/sh

if [ -z "$CLASSPATH" ]  ; then
	CLASSPATH=`cat /usr/share/kissme/eclasspath`
else
	CLASSPATH=`cat /usr/share/kissme/eclasspath`:${CLASSPATH}
fi

if [ -z "$*" ] ; then 
	/usr/bin/kissme-bin
else
	/usr/bin/kissme-bin -cp ${CLASSPATH} $*
fi