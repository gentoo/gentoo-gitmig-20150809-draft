# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/superadduser/superadduser-1.0-r2.ebuild,v 1.5 2002/12/09 04:17:36 manson Exp $

DESCRIPTION="Interactive adduser script"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

RDEPEND="sys-apps/shadow"

src_install() {
	dosbin ${FILESDIR}/${PV}/superadduser
	doman ${FILESDIR}/${PV}/superadduser.8
}
