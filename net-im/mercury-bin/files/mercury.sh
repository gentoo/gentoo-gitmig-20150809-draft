#!/bin/bash
MERCURY_INSTALL_PATH="/opt/mercury-bin"
cd ${MERCURY_INSTALL_PATH}
java -Djava.library.path=$(java-config -i jdictrayapi) -classpath $(java-config -p jdom-1.0,jdictrayapi,jmf-bin,mercury-bin,xpp3,jgoodies-looks-1.3) com.dMSN.Main
