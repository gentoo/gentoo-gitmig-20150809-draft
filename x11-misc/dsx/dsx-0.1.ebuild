# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dsx/dsx-0.1.ebuild,v 1.7 2007/07/22 02:52:01 coldwind Exp $

DESCRIPTION="command line selection of your X desktop environment"
HOMEPAGE="none"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=""
RDEPEND="x11-apps/xinit
	>=dev-lang/python-2.1"

src_install() {
	newbin "${FILESDIR}/${P}" dsx
}
