#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/www-servers/orion/files/2.0.2/start_orion.sh,v 1.1 2004/08/08 17:51:02 stuart Exp $

source /etc/conf.d/orion
JAVAC=${JAVA_HOME}/bin/javac
JDK_HOME=${JAVA_HOME}

cd ${ORION_DIR}

${JAVA_HOME}/bin/java -jar /usr/share/orion/lib/orion.jar -quiet -out ${ORION_OUT} -err ${ORION_ERR} &
