#!/bin/sh

PROGRAM_DIR=##PROGRAM_DIR##		# directory where all the files were extracted

AZ_CONFIG="${HOME}/.azureus/gentoo.config"
if [ -f ~/.azureus/gentoo.config ]; then
	. ~/.azureus/gentoo.config
else
	if [ ! -e ~/.azureus ]; then
		mkdir ~/.azureus
		echo "Creating ~/.azureus..."
	fi

	# Setup defaults
	KDE_SYSTRAY4J_DAEMON=TRUE
	UI_OPTIONS="--ui=swt"

	# Create the config file
	cat > ${AZ_CONFIG} <<END
# KDE_SYSTRAY4J_DAEMON: TRUE or FALSE to enable/disable the KDE systray icon.
KDE_SYSTRAY4J_DAEMON=${KDE_SYSTRAY4J_DAEMON}

# User Interface options:
# web     - web based
# web2    - web based
# console - console based
# swt     - swt (GUI) based
#
# When selecting just 1, use '--ui=<ui>'
# When selecting multiple, use '--uis=<ui>,<ui>'
UI_OPTIONS="--ui=swt"
END

fi

MSG0="ERROR:\nYou must edit this script and change PROGRAM_DIR to point to where you installed Azureus"
MSG1="Attempting to start systray4j KDE daemon..."
MSG2="Systray4j daemon started"
MSG3="Starting for first time: attempting to compile and link..."
MSG4="Compile and link successful"
MSG5="Compile and link FAILED: to fix, please read "
MSG6="Unable to locate systray4jd source files"
MSG7="Systray4j daemon detected already running"
MSG8="Attempting to start Azureus..."

AZDIR=./
if [ ! -e id.azureus.dir.file ]; then
  AZDIR=$PROGRAM_DIR
  if [ ! -d $AZDIR ]; then
    echo $MSG0
	 exit -1
  fi
fi

cd ${AZDIR}

#should we attempt to load systray4j daemon ?
if [ "$KDE_SYSTRAY4J_DAEMON" == "TRUE" ]; then
  echo $MSG1
  #check to make sure it is not already running
  runcount=`ps -ef | grep -v grep | grep -c systray4jd`
  if `test $runcount = 0` ; then
    ./systray4jd&
  else
    echo $MSG7	      
  fi	
fi

echo $MSG8

# DOESN'T WORK	
#JARS=`ls *.jar | grep -v Azureus2`
#for FILE in $JARS; do CLASSPATH="${FILE}:${CLASSPATH}"; done
#java -cp $CLASSPATH -Djava.library.path="${AZDIR}" -jar Azureus2.jar ${UI_OPTIONS} "$1"

# WORKS, BUT ONLY SWT
for FILE in *.jar; do CLASSPATH="${FILE}:${CLASSPATH}"; done
java -cp $CLASSPATH -Djava.library.path="${AZDIR}" org.gudy.azureus2.ui.swt.Main "$1"

if [ $? -ne 0 ]; then
	echo "If you recieved an error about missing log4j or cli, you "
	echo "need to setup your classpath correctly."
	echo "This should do the trick (as root):"
	echo "java-config --add-system-classpath=junit,log4j,commons-cli"
	echo "env-update && source /etc/profile"
fi

proc_id=`ps -ef | grep -v grep | grep systray4jd | awk '{print $2}'`
if [ ! "$proc_id" == "" ] ; then
  kill -9 $proc_id
fi
