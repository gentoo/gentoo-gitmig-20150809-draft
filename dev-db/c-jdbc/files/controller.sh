#!/bin/sh

# JAVA setup.
#
# We try to use first the java JVM in JAVA_HOME and if not found,
# we use the one found in the path.
# You can specify additional options to give to the Java JVM in the
# JAVA_OPTS environment variable.
java=`java-config -J`
sax_parser_class=org.apache.crimson.parser.XMLReaderImpl
  
cp=${CJDBC_HOME}/config/language:${CJDBC_HOME}/config/controller:$CJDBC_HOME/xml
cp=${cp}:${CJDBC_HOME}/config/virtualdatabase:${CJDBC_HOME}/config:${CJDBC_HOME}/xsl
cp=${cp}:`java-config -p jakarta-regexp-1.3`:`java-config -p xerces-2`
cp=${cp}:`java-config -p octopus-3.0`:`java-config -p c-jdbc-1`
cp=${cp}:`java-config -p hsqldb`:`java-config -p crimson-1`
cp=${cp}:`java-config -p jgroups`:`java-config -p dom4j-1`
cp=${cp}:`java-config -p jaxen-1.1`:`java-config -p log4j`
cp=${cp}:`java-config -p commons-cli-1`:`java-config -p mx4j-2.1`
cp=${cp}:`java-config -p xalan`

# Java Command.
${java} -classpath ${cp}  -Xmx200m  -Xms200m  -Dcjdbc.home=${CJDBC_HOME} -Dorg.xml.sax.driver=${sax_parser_class} -Djava.security.policy=${CJDBC_HOME}/config/java.policy org.objectweb.cjdbc.controller.core.Controller  "$@"
