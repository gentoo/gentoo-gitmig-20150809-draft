#!/bin/bash
# $Header: /var/cvsroot/gentoo-x86/net-www/orion/files/1.5.2b/start_orion.sh,v 1.2 2003/03/14 20:32:22 absinthe Exp $

source /etc/conf.d/orion
JAVAC=${JAVA_HOME}/bin/javac
JDK_HOME=${JAVA_HOME}

cd ${ORION_DIR}

${JAVA_HOME}/bin/java -jar /usr/share/orion/lib/orion.jar -quiet -out ${ORION_OUT} -err ${ORION_ERR} &
