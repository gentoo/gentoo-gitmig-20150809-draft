# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsetimon/wmsetimon-0.5.ebuild,v 1.1 2005/01/08 01:07:31 s4t4n Exp $

IUSE=""
S=${WORKDIR}/${PN}/${PN}
DESCRIPTION="WindowMaker DockApp: Monitors, starts, and stops 1 to 9 SETI@home processes."
SRC_URI="http://goupilfr.org/arch/${P}.tar.gz"
HOMEPAGE="http://goupilfr.org/?soft=wmsetimon"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
DEPEND="virtual/x11
	>=sys-apps/sed-4"

src_compile() {
	mv Makefile Makefile.orig
	sed 's/^CFLAGS/#CFLAGS/' Makefile.orig > Makefile
	rm Makefile.orig
	emake || die "Compilation failed!"
}

src_install () {
	dobin wmsetimon
	dodoc wmsetimonrc
	cd ..
	dodoc README
}
