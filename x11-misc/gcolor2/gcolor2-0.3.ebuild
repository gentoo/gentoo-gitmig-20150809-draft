# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gcolor2/gcolor2-0.3.ebuild,v 1.1 2004/10/28 04:22:25 brad Exp $

DESCRIPTION="A simple GTK+2 color selector."
HOMEPAGE="http://gcolor2.sourceforge.net/"
LICENSE="GPL-2"
DEPEND=">=x11-libs/gtk+-2.4"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc INSTALL AUTHORS COPYING
}
