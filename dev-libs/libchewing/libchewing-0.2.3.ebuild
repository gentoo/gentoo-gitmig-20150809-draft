# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libchewing/libchewing-0.2.3.ebuild,v 1.2 2004/10/03 14:12:25 usata Exp $

inherit flag-o-matic

IUSE=""
DESCRIPTION="Library for Chinese Phonetic input method"
HOMEPAGE="http://jserv.sayya.org/wiki/index.php/Qooing"
SRC_URI="http://jserv.sayya.org/qooing/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}
