#!/bin/bash
source /etc/conf.d/orion
cd ${ORION_DIR}
JAVA_HOME=/opt/sun-jdk-1.4.1.01
JDK_HOME=${JAVA_HOME}
JAVAC=${JAVA_HOME}/bin/javac
CLASSPATH=/usr/share/orion/lib/activation.jar:/usr/share/orion/lib/admin.jar:/usr/share/orion/lib/applicationlauncher.jar:/usr/share/orion/lib/assemblerlauncher.jar:/usr/share/orion/lib/autoupdate.jar:/usr/share/orion/lib/clientassembler.jar:/usr/share/orion/lib/crimson.jar:/usr/share/orion/lib/earassembler.jar:/usr/share/orion/lib/ejb.jar:/usr/share/orion/lib/ejbassembler.jar:/usr/share/orion/lib/ejbmaker.jar:/usr/share/orion/lib/jaas.jar:/usr/share/orion/lib/jaxp.jar:/usr/share/orion/lib/jcert.jar:/usr/share/orion/lib/jdbc.jar:/usr/share/orion/lib/jndi.jar:/usr/share/orion/lib/jnet.jar:/usr/share/orion/lib/jsse.jar:/usr/share/orion/lib/jta.jar:/usr/share/orion/lib/loadbalancer.jar:/usr/share/orion/lib/mail.jar:/usr/share/orion/lib/orion.jar:/usr/share/orion/lib/orionconsole.jar:/usr/share/orion/lib/parser.jar:/usr/share/orion/lib/taglibassembler.jar:/usr/share/orion/lib/webappassembler.jar:/usr/share/orion/lib/xalan.jar:/usr/share/orion/lib/xerces.jar:/opt/orion/tools.jar:${JAVA_HOME}/jre/lib/rt.jar:.
${JAVA_HOME}/bin/java -jar /usr/share/orion/lib/orion.jar -quiet -out ${ORION_OUT} -err ${ORION_ERR} &
