# Copyright 2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/qt.eclass,v 1.10 2005/06/30 21:26:34 agriffis Exp $
#
# Author Caleb Tennis <caleb@gentoo.org>
#
# This eclass is simple.  Inherit it, and in your depend, do something like this:
#
# DEPEND="$(qt_min_version 3.1)"
#
# and it handles the rest for you
#
# Caveats:
#
# Currently, the ebuild assumes that a minimum version of Qt3 is NOT satisfied by Qt4

inherit versionator

ECLASS=qt
INHERITED="$INHERITED $ECLASS"

QTPKG="x11-libs/qt-"
QT3VERSIONS="3.3.4-r5 3.3.4-r4 3.3.4-r3 3.3.4-r2 3.3.4-r1 3.3.4 3.3.3-r3 3.3.3-r2 3.3.3-r1 3.3.3 3.3.2 3.3.1-r2 3.3.1-r1 3.3.1 3.3.0-r1 3.3.0 3.2.3-r1 3.2.3 3.2.2-r1 3.2.2 3.2.1-r2 3.2.1-r1 3.2.1 3.2.0 3.1.2-r4 3.1.2-r3 3.1.2-r2 3.1.2-r1 3.1.2 3.1.1-r2 3.1.1-r1 3.1.1 3.1.0-r3 3.1.0-r2 3.1.0-r1 3.1.0"
QT4VERSIONS="4.0.0"

qt_pkg_setup() {
	if has_version =x11-libs/qt-3*; then
		if [[ -z $QTDIR ]]; then
			QTDIR="/usr/qt/3"
		fi

		[[ -d "$QTDIR/etc/settings" ]] && addwrite "$QTDIR/etc/settings"
		addpredict "$QTDIR/etc/settings"
	fi
}

qt_min_version() {
	echo "|| ("
	qt_min_version_list "$@"
	echo ")"
}

qt_min_version_list() {
	local MINVER=$1
	local VERSIONS=""

	case $MINVER in
		3|3.0|3.0.0) VERSIONS="=${QTPKG}3*";;
		4|4.0|4.0.0) VERSIONS="=${QTPKG}4*";;
		3*)
			for x in $QT3VERSIONS; do
				if $(version_is_at_least $MINVER $x); then
					VERSIONS="${VERSIONS} =${QTPKG}${x}"
				fi
			done
			;;
		4*)
			for x in $QT4VERSIONS; do
				if $(version_is_at_least $MINVER $x); then
					VERSIONS="${VERSIONS} =${QTPKG}${x}"
				fi
			done
			;;
		*)    
			die "qt_min_version called with invalid parameter: \"$1\""
			;;
	esac

	echo "$VERSIONS"
}

EXPORT_FUNCTIONS pkg_setup
