#!/bin/sh

PROGRAM_DIR=##PROGRAM_DIR##		# directory where all the files were extracted

AZ_CONFIG="${HOME}/.Azureus/gentoo.config"
if [ -f ~/.Azureus/gentoo.config ]; then
	. ~/.Azureus/gentoo.config
else
	if [ ! -e ~/.Azureus ]; then
		mkdir ~/.Azureus
		echo "Creating ~/.Azureus..."
	fi

	# Setup defaults
	UI_OPTIONS="--ui=swt"

	# Create the config file
	cat > ${AZ_CONFIG} <<END
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
MSG1="Attempting to start Azureus..."

AZDIR=./
if [ ! -e id.azureus.dir.file ]; then
	AZDIR=$PROGRAM_DIR
	if [ ! -d $AZDIR ]; then
		echo $MSG0 >&2
		exit -1
	fi
fi

cd ${AZDIR}
echo $MSG1

# This should work as long as your classpath is setup right...
#JARS=`ls *.jar | grep -v Azureus2`
#for FILE in $JARS; do CLASSPATH="${FILE}:${CLASSPATH}"; done
#java -cp $CLASSPATH -Djava.library.path="/usr/lib:${AZDIR}" -jar Azureus2.jar ${UI_OPTIONS} "$1"

# Try this if the above doesn't work
for FILE in *.jar; do CLASSPATH="${FILE}:${CLASSPATH}"; done
java -cp $CLASSPATH -Djava.library.path="/usr/share/swt/lib:${AZDIR}" org.gudy.azureus2.ui.swt.Main "$1"

if [ $? -ne 0 ]; then
	echo "If you recieved an error about a missing java class, you need to setup"
	echo "your classpath correctly."
	echo "This should do the trick (as root):"
	echo "java-config --add-system-classpath=junit,log4j,commons-cli-1,systray4j,swt"
	echo "env-update && source /etc/profile"
	echo
	echo "Currently, your classpath (including azureus additions) is:"
	echo "${CLASSPATH}"
fi
