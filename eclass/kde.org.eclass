# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde.org.eclass,v 1.7 2002/05/07 19:26:22 danarmak Exp $
# Contains the locations of ftp.kde.org packages and their mirrors
ECLASS=kde.org

SRC_PATH="kde/stable/${PV}/src/${P}.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
		ftp://download.us.kde.org/pub/kde/$SRC_PATH
		ftp://download.uk.kde.org/pub/kde/$SRC_PATH
		ftp://download.au.kde.org/pub/kde/$SRC_PATH
		ftp://download.at.kde.org/pub/kde/$SRC_PATH
		ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
		ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"

debug-print "$ECLASS: finished, SRC_URI=$SRC_URI"
