# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/superadduser/superadduser-1.0.5.ebuild,v 1.1 2003/05/18 07:23:37 seemant Exp $

DESCRIPTION="Interactive adduser script"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND="sys-apps/shadow"

src_install() {
	dosbin ${FILESDIR}/${PV}/superadduser
	doman ${FILESDIR}/${PV}/superadduser.8
}
