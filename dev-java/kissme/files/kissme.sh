#! /bin/sh

if [ -z "$CLASSPATH" ]  ; then
	CLASSPATH=`cat /usr/share/kissme/classpath.env`
else
	CLASSPATH=`cat /usr/share/kissme/classpath.env`:${CLASSPATH}
fi

if [ -z "$*" ] ; then 
	/usr/bin/kissmebin
else
	/usr/bin/kissmebin -cp ${CLASSPATH} $*
fi
