#! /bin/sh

if [ -z "$JAVA_HOME" ] ; then
	echo "!!! JAVA_HOME not set"
	exit -1
fi

newcp=""
for i in antlr makeme ; do
	newcp=`cat < /usr/share/$i/eclasspath`:${newcp}
done

CLASSPATH=${newcp}:${CLASSPATH}

${JAVA_HOME}/bin/java -cp ${CLASSPATH} gnu.makeme.MakeMe $*
