#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/net-www/orion/files/2.0.1/start_orion.sh,v 1.1 2003/05/01 17:50:29 absinthe Exp $

source /etc/conf.d/orion
JAVAC=${JAVA_HOME}/bin/javac
JDK_HOME=${JAVA_HOME}

cd ${ORION_DIR}

${JAVA_HOME}/bin/java -jar /usr/share/orion/lib/orion.jar -quiet -out ${ORION_OUT} -err ${ORION_ERR} &
