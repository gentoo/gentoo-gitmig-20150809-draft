# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/superadduser/superadduser-1.0-r1.ebuild,v 1.4 2002/07/25 13:48:39 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Interactive adduser script"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="sys-apps/shadow"

src_install () {
	dosbin ${FILESDIR}/superadduser
	doman ${FILESDIR}/superadduser.8
}
