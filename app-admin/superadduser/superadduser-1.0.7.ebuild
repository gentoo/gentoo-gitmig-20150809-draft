# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/superadduser/superadduser-1.0.7.ebuild,v 1.11 2005/01/01 11:27:57 eradicator Exp $

DESCRIPTION="Interactive adduser script"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc alpha hppa ~mips amd64 ~ia64 ~ppc64"
IUSE=""

RDEPEND="sys-apps/shadow"

src_install() {
	dosbin ${FILESDIR}/${PV}/superadduser
	doman ${FILESDIR}/superadduser.8
}
