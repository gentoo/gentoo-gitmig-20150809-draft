# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/superadduser/superadduser-1.0-r2.ebuild,v 1.2 2002/08/18 00:17:50 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Interactive adduser script"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND="sys-apps/shadow"


src_install () {
	dosbin ${FILESDIR}/${PV}/superadduser
	doman ${FILESDIR}/${PV}/superadduser.8
}
