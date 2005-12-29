#!/bin/bash
MERCURY_INSTALL_PATH="/opt/mercury-bin"
SHARE_DIR="/usr/share/mercury-bin"
OPTIONS="-Djava.library.path=$(java-config -i jdictrayapi)"
CLASSPATH=$(java-config -p jdom-1.0,xpp3,jgoodies-looks-1.3)

for file in $(ls $SHARE_DIR/lib)
do
	CLASSPATH=$CLASSPATH:$SHARE_DIR/lib/$file	
done
cd ${MERCURY_INSTALL_PATH}
java $OPTIONS -classpath $CLASSPATH com.dMSN.Main

