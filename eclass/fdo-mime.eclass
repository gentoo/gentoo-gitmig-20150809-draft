# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/fdo-mime.eclass,v 1.9 2011/04/21 20:59:59 eva Exp $

# @ECLASS: fdo-mime.eclass
# @MAINTAINER: freedesktop-bugs@gentoo.org
#
#
# Original author: foser <foser@gentoo.org>
# @BLURB: Utility eclass to update the desktop mime info as laid out in the freedesktop specs & implementations

# @ECLASS-VARIABLE: FDO_MIME_UPDATE_DESKTOP_BIN
# @DESCRIPTION:
# Path to update-desktop-database
: ${FDO_MIME_UPDATE_DESKTOP_BIN:="/usr/bin/update-desktop-database"}

# @ECLASS-VARIABLE: FDO_MIME_UPDATE_MIME_BIN
# @DESCRIPTION:
# Path to update-mime-database
: ${FDO_MIME_UPDATE_MIME_BIN:="/usr/bin/update-mime-database"}

# @FUNCTION: fdo_mime_desktop_savelist
# @DESCRIPTION:
# Find the .desktop files that are about to be installed and save their location
# in the FDO_MIME_DESKTOP_FILES environment variable
fdo_mime_desktop_savelist() {
	has ${EAPI:-0} 0 1 2 && ! use prefix && ED="${D}"
	pushd "${ED}" &> /dev/null
	export FDO_MIME_DESKTOP_FILES=$(find 'usr/share/applications' -type f -name '*.desktop' 2> /dev/null)
	popd &> /dev/null
}

# @FUNCTION: fdo_mime_mime_savelist
# @DESCRIPTION:
# Find the .desktop files that are about to be installed and save their location
# in the FDO_MIME_MIME_FILES environment variable
fdo_mime_mime_savelist() {
	has ${EAPI:-0} 0 1 2 && ! use prefix && ED="${D}"
	pushd "${ED}" &> /dev/null
	export FDO_MIME_MIME_FILES=$(find 'usr/share/mime' -type f -name '*.xml' 2> /dev/null)
	popd &> /dev/null
}

# @FUNCTION: fdo-mime_desktop_database_update
# @DESCRIPTION:
# Updates the desktop database.
# Generates a list of mimetypes linked to applications that can handle them
fdo-mime_desktop_database_update() {
	has ${EAPI:-0} 0 1 2 && ! use prefix && EROOT="${ROOT}"
	local updater="${EROOT}${FDO_MIME_UPDATE_DESKTOP_BIN}"

	if [ ! -x "${updater}" ]; then
		debug-print "${updater} is not executable"
		return
	fi

	if [ -z  "${FDO_MIME_DESKTOP_FILES}" ]; then
		debug-print "No desktop file to install"
		return
	fi

	ebegin "Updating desktop mime database ..."
	"${updater}" -q "${EROOT}/usr/share/applications"
	eend $?
}

# @FUNCTION: fdo-mime_mime_database_update
# @DESCRIPTION:
# Update the mime database.
# Creates a general list of mime types from several sources
fdo-mime_mime_database_update() {
	has ${EAPI:-0} 0 1 2 && ! use prefix && EROOT="${ROOT}"
	local updater="${EROOT}${FDO_MIME_UPDATE_MIME_BIN}"

	if [ ! -x "${updater}" ]; then
		debug-print "${updater} is not executable"
		return
	fi

	if [ -z  "${FDO_MIME_MIME_FILES}" ]; then
		debug-print "No desktop file to install"
		return
	fi

	ebegin "Updating shared mime info database ..."
	"${updater}" "${EROOT}/usr/share/mime"
	eend $?
}
