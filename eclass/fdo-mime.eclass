# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/fdo-mime.eclass,v 1.2 2004/10/19 19:51:12 vapier Exp $

# Author:
# foser <foser@gentoo.org>

# utility eclass to update the desktop mime info as laid out in the freedesktop specs & implementations
# <references here>

ECLASS="fdo-mime"
INHERITED="$INHERITED $ECLASS"

# Updates the desktop database
# Generates a list of mimetypes linked to applications that can handle them

fdo-mime_desktop_database_update() {

	if [ -x ${ROOT}/usr/bin/update-desktop-database ]
	then
		einfo "Updating desktop mime database ..."
		update-desktop-database -q /usr/share/applications
	fi

}

# Update the mime database
# Creates a general list of mime types from several sources

fdo-mime_mime_database_update() {

	if [ -x ${ROOT}/usr/bin/update-mime-database ]
	then
		einfo "Updating shared mime info database ..."
		update-mime-database /usr/share/mime
	fi

}
