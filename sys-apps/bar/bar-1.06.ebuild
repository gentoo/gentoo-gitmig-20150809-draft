# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bar/bar-1.06.ebuild,v 1.4 2004/07/15 01:42:56 agriffis Exp $

DESCRIPTION="Console Progress Bar"
HOMEPAGE="http://clpbar.sourceforge.net/"
KEYWORDS="x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/clpbar/${P}.tar.gz"
DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr \
		    --sysconfdir=/etc || die
	emake || die
}

src_install() {
	einstall
}
