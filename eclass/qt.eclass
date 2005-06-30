# Copyright 2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/qt.eclass,v 1.3 2005/06/30 13:29:13 caleb Exp $
#
# Author Caleb Tennis <caleb@gentoo.org>
#
# If you inherit this class, it assumes that you want to make sure the user has a version of Qt3
# installed.  The logic is as follows:
#
# Currently, it forces a dependency on any Qt3 version.  If the ebuild also sets the version directly, then
# both should be in effect.

inherit versionator

ECLASS=qt
INHERITED="$INHERITED $ECLASS"

QTPKG="x11-libs/qt-"
QT3VERSIONS="3.3.4-r5 3.3.4-r4 3.3.4-r3 3.3.4-r2 3.3.4-r1 3.3.4 3.3.3-r3 3.3.3-r2 3.3.3-r1 3.3.3 3.3.2 3.3.1-r2 3.3.1-r1 3.3.1 3.3.0-r1 3.3.0 3.2.3-r1 3.2.3 3.2.2-r1 3.2.2 3.2.1-r2 3.2.1-r1 3.2.1 3.2.0 3.1.2-r4 3.1.2-r3 3.1.2-r2 3.1.2-r1 3.1.2 3.1.1-r2 3.1.1-r1 3.1.1 3.1.0-r3 3.1.0-r2 3.1.0-r1 3.1.0"

qt3_min_version() {
	echo -n "|| ( "
	qt3_min_version_list $@
	echo " )"
}

qt3_min_version_list() {
	local MINVER=$1
	local VERSIONS=""

	case $MINVER in
		3) VERSIONS="${QTPKG}3*";;
		3.0) VERSIONS="${QTPKG}3*";;
		3.0.0) VERSIONS="${QTPKG}3*";;
		*)
			for x in $QT3VERSIONS; do
				if $(version_is_at_least $MINVER $x); then
					VERSIONS="${VERSIONS} =${QTPKG}${x}"
				fi
			done
		;;
	esac
	
	echo -n $VERSIONS
}
