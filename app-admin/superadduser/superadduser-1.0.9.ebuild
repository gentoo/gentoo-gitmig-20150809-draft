# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/superadduser/superadduser-1.0.9.ebuild,v 1.4 2004/10/26 22:47:18 seemant Exp $

DESCRIPTION="Interactive adduser script from Slackware"
SRC_URI=""
HOMEPAGE="http://www.interlude.org.uk/unix/slackware/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ~ppc64"
IUSE=""

RDEPEND="sys-apps/shadow"

src_install() {
	dosbin ${FILESDIR}/${PV}/superadduser
	doman ${FILESDIR}/superadduser.8
}
