# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dsx/dsx-0.1.ebuild,v 1.6 2006/01/21 11:01:59 nelchael Exp $

DESCRIPTION="dsx - command line selection of your X desktop environment"
HOMEPAGE="none"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=""
RDEPEND="|| ( x11-apps/xinit virtual/x11 )
	>=dev-lang/python-2.1"

src_install() {
	exeinto /usr/bin
	newexe "${FILESDIR}/${P}" dsx
}
