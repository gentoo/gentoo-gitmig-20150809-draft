# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gcolor2/gcolor2-0.3.ebuild,v 1.5 2005/08/07 13:24:02 hansmi Exp $

DESCRIPTION="A simple GTK+2 color selector."
HOMEPAGE="http://gcolor2.sourceforge.net/"
LICENSE="GPL-2"
DEPEND=">=x11-libs/gtk+-2.4"

SLOT="0"
KEYWORDS="ppc ppc64 x86"
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
