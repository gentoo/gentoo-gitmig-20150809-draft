#! /bin/bash
#
# Copyright (c) 2005, Petteri Räty <betelgeuse@gentoo.org>
# Copyright (c) 2004, Jochen Maes <sejo@gentoo.org>
# Copyright (c) 2004, Karl Trygve Kalleberg <karltk@gentoo.org>
# Copyright (c) 2004, Gentoo Foundation
#
# Licensed under the GNU General Public License, v2

dotazudir=${HOME}/.Azureus
gentoocfg=${dotazudir}/gentoo.config

if [ -f ${gentoocfg} ] ; then
	. ${gentoocfg}
else
	if [ ! -e ${dotazudir} ] ; then
		mkdir ${dotazudir}
		echo "Creating ${dotazudir}" 
	fi

	# Setup defaults
	UI_OPTIONS="--ui=swt"

	# Create the config file
	cat > ${gentoocfg} <<END
# User Interface options:
# console   - console based
# swt       - swt (GUI) based
#
# When selecting just 1, use '--ui=<ui>'
# When selecting multiple, use '--uis=<ui>,<ui>'
UI_OPTIONS="--ui=swt"

# Options you want to pass to the java binary
JAVA_OPTIONS=""
END

fi

cd ${dotazudir}

CLASSPATH=$(java-config -p junit,log4j,commons-cli-1,swt-3,azureus)
exec $(java-config --java)  -cp ${CLASSPATH} -Djava.library.path=$(java-config -i swt-3) \
	${JAVA_OPTIONS} org.gudy.azureus2.ui.common.Main ${UI_OPTIONS} "${@}"
