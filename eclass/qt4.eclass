# Copyright 2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/qt4.eclass,v 1.2 2006/05/08 11:13:57 caleb Exp $
#
# Author Caleb Tennis <caleb@gentoo.org>
#
# This eclass is simple.  Inherit it, and in your depend, do something like this:
#
# DEPEND="$(qt_min_version 4)"
#
# and it handles the rest for you
#

inherit versionator

QTPKG="x11-libs/qt-"
QT4MAJORVERSIONS="4.1 4.0"
QT4VERSIONS="4.1.2 4.1.1 4.1.0 4.0.1 4.0.0"

qt_min_version() {
	echo "|| ("
	qt_min_version_list "$@"
	echo ")"
}

qt_min_version_list() {
	local MINVER="$1"
	local VERSIONS=""

	case "${MINVER}" in
		4|4.0|4.0.0) VERSIONS="=${QTPKG}4*";;
		4.1|4.1.0)
			for x in ${QT4MAJORVERSIONS}; do
				if $(version_is_at_least "${MINVER}" "${x}"); then
					VERSIONS="${VERSIONS} =${QTPKG}${x}*"
				fi
			done
			;;
		4*)
			for x in ${QT4VERSIONS}; do
				if $(version_is_at_least "${MINVER}" "${x}"); then
					VERSIONS="${VERSIONS} =${QTPKG}${x}"
				fi
			done
			;;
		*) VERSIONS="=${QTPKG}4*";;
	esac

	echo "${VERSIONS}"
}
