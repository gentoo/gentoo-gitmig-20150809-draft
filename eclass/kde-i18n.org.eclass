# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-i18n.org.eclass,v 1.7 2002/10/25 19:55:52 vapier Exp $
# Contains the locations of i18n ftp.kde.org packages and their mirrors

ECLASS=kde-i18n.org
INHERITED="$INHERITED $ECLASS"

case $PV in
	'3.0.2'|'3.0.3')
		# new location format starting with 3.0.2
		SRC_PATH="kde/stable/${PV}/src/kde-i18n/${P}.tar.bz2"
		;;
	*)
		SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
		;;
esac

SRC_URI="$SRC_URI ftp://ftp.kde.org/pub/$SRC_PATH
		ftp://download.us.kde.org/pub/$SRC_PATH
		ftp://download.uk.kde.org/pub/$SRC_PATH
		ftp://download.au.kde.org/pub/$SRC_PATH
		ftp://download.at.kde.org/pub/$SRC_PATH
		ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
		ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

debug-print "$ECLASS: finished, SRC_URI=$SRC_URI"
