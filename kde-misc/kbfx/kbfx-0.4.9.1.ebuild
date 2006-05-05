# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kbfx/kbfx-0.4.9.1.ebuild,v 1.1 2006/05/05 16:37:03 genstef Exp $

inherit kde

DESCRIPTION="KDE alternative K-Menu"
HOMEPAGE="http://www.kbfx.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

need-kde 3.3
src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:\$(LIB_KIO):-L${KDEDIR}/lib -lkio:" kbfxconfigapp/Makefile.am
	make -f Makefile.cvs
}
