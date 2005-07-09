# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gcolor/gcolor-0.4.ebuild,v 1.8 2005/07/09 07:05:04 smithj Exp $

DESCRIPTION="A simple color selector."
HOMEPAGE="http://gcolor.sourceforge.net/"
LICENSE="GPL-2"
DEPEND="x11-libs/gtk+"

SLOT="0"
KEYWORDS="x86 ppc ppc64 amd64"
IUSE=""

SRC_URI="mirror://sourceforge/gcolor/${P}.tar.gz"

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
	dodoc ABOUT-NLS INSTALL README AUTHORS COPYING NEWS ChangeLog
}
