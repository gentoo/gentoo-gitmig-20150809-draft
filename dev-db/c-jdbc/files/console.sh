#!/bin/sh

java=`java-config -J`

cp=`java-config -p kunststoff-2.0`:`java-config -p dtdparser-1.21`
cp=${cp}:`java-config -p crimson-1`:`java-config -p c-jdbc-1`
cp=${cp}:`java-config -p jcommon`:`java-config -p jfreechart`
cp=${cp}:`java-config -p commons-cli-1`:`java-config -p mx4j-2.1`
cp=${cp}:`java-config -p log4j`:`java-config -p dom4j-1`
cp=${cp}:`java-config -p jaxen-1.1`
cp=${cp}:${CJDBC_HOME}/xml:${CJDBC_HOME}/config/language

# Java Command.
${java} -classpath ${cp} -Dswing.defaultlaf=com.incors.plaf.kunststoff.KunststoffLookAndFeel org.objectweb.cjdbc.console.text.ConsoleLauncher  "$@"
