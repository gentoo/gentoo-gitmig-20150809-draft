#!/bin/sh

AZDIR=/opt/azureus

if [ ! -d $AZDIR ]; then
	echo "You have to edit this script and change the location"
	echo "where you installed Azureus"
fi

cd $AZDIR

run=1
while [ $run -gt 0 ]
do
	java -cp Azureus2.jar:swt.jar:swt-pi.jar:systray4j.jar:commons-cli-1.0.jar \
	-Djava.library.path="$AZDIR:$AZDIR/lib" org.gudy.azureus2.ui.common.Main $*
	if [ -f Azureus2-new.jar ] || [ -f ~/.azureus/Azureus2-new.jar ]
	then
		rm Azureus2-new.jar ~/.azureus/Azureus2-new.jar
		xmessage -center 'Please upgrade Azureus using Portage.'
	else
		run=0
	fi
done
[ -f Updater.jar ] && rm Updater.jar
