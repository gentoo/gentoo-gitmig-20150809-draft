#!/bin/sh

java=`java-config -J`
jxplorer_home=/usr/share/jxplorer

cp=`java-config -p jxplorer`:`java-config -p javahelp-bin`
cp=${cp}:`java-config -p log4j`:`java-config -p sun-jaf-bin`
cp=${cp}:`java-config -p commons-logging`:`java-config -p dom4j-1`
cp=${cp}:`java-config -p sun-javamail-bin`:`java-config -p axis-1`
cp=${cp}:`java-config -p sun-dsml-bin-2`:`java-config -p commons-discovery`

if [ ! -d ${HOME}/.jxplorer ]; then
	mkdir ${HOME}/.jxplorer
	cp ${jxplorer_home}/connections.txt ${HOME}/.jxplorer
	touch ${HOME}/.jxplorer/dxconfig.txt
fi
if [ -d ${HOME}/.jxplorer ]; then
	if [ ! -f ${HOME}/.jxplorer/dxconfig.txt ]; then
		touch ${HOME}/.jxplorer/dxconfig.txt
	fi
	if [ ! -f ${HOME}/.jxplorer/connections.txt ]; then
		cp ${jxplorer_home}/connections.txt ${HOME}/.jxplorer
	fi
fi

cd ${jxplorer_home}
${java} -cp ${cp} com.ca.directory.jxplorer.JXplorer >& /dev/null 

