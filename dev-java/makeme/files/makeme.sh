#!/bin/sh
# makeme Launch Script
# Author: Dylan Carlson
# May 2003
# $Header: /var/cvsroot/gentoo-x86/dev-java/makeme/files/makeme.sh,v 1.3 2003/05/24 04:21:00 absinthe Exp $

JAVA_HOME=`/usr/bin/java-config --jdk-home`
if [ -z "${JAVA_HOME}" ] ; then
	JAVA_HOME=`/usr/bin/java-config --jre-home`
fi
CLASSPATH="${CLASSPATH}:`/usr/bin/java-config --classpath=antlr,makeme`"

if [ ! -f ${JAVA_HOME}/bin/java ] ; then
	echo " "
	echo "I tried using the following Java Runtime:"
	echo "${JAVA_HOME}/bin/java" 
	echo " "
	echo "Java Runtime missing.  Please run java-config(1) and ensure"
	echo "your environment is configured properly."
	exit 1
else
	echo " "
	echo "Using Java Runtime:"
	echo "${JAVA_HOME}/bin/java" 
	echo " "
	echo "Using CLASSPATH:"
	echo "${CLASSPATH}"
	echo " "
fi

${JAVA_HOME}/bin/java gnu.makeme.MakeMe $*
