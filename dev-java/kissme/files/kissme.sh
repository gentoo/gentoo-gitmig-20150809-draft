#! /bin/sh
#
# Copyright (c) 2002-2004, Karl Trygve Kalleberg <karltk@gentoo.org>
# 
# Licensed under the GNU General Public License, v2

bootclasspath=$(java-config -p kissme)

CLASSPATH=${bootclasspath}:${CLASSPATH}

if [ -z "$*" ] ; then 
	/usr/bin/kissmebin
else
	/usr/bin/kissmebin -cp ${CLASSPATH} $*
fi
