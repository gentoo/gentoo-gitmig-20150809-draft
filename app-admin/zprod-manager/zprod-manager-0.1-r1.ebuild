# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/zprod-manager/zprod-manager-0.1-r1.ebuild,v 1.1 2004/09/18 16:04:19 batlogg Exp $

DESCRIPTION="Gentoo Zope Product selection tool"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86 ~ppc ~sparc"

DEPEND=""
RDEPEND=">=dev-util/dialog-0.7
	sys-apps/grep
	sys-apps/sed
	>=net-zope/zope-2.6.0-r2"

src_install() {
	dosbin ${FILESDIR}/${PV}/zprod-manager
}
