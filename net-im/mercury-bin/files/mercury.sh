#!/bin/bash
MERCURY_INSTALL_PATH="/opt/mercury-bin"
JDICTRAY_INSTALL_PATH="/opt/jdictrayapi/lib/"
cd ${MERCURY_INSTALL_PATH}
java -Djava.library.path=${JDICTRAY_INSTALL_PATH} -classpath $(java-config -p jdom-1.0_beta6,jdictrayapi,jmf-bin,mercury-bin) com.dMSN.Main
