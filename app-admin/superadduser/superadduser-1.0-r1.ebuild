# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/superadduser/superadduser-1.0-r1.ebuild,v 1.3 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Interactive adduser script"
SRC_URI=""
SLOT="0"
HOMEPAGE=""

RDEPEND="sys-apps/shadow"

src_install () {
	dosbin ${FILESDIR}/superadduser
	doman ${FILESDIR}/superadduser.8
}
