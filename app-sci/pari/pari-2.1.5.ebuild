# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/pari/pari-2.1.5.ebuild,v 1.2 2003/05/11 05:33:41 george Exp $

IUSE=""

DESCRIPTION="pari (or pari-gp) : a software package for computer-aided number theory"
HOMEPAGE="http://www.parigp-home.de/"
SRC_URI="http://www.gn-50uma.de/ftp/pari-2.1/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="app-text/tetex"

src_compile() {
	./Configure \
		--host=${CHOST} \
		--prefix=/usr \
		--miscdir=/usr/share/doc/${P} \
		--datadir=/usr/share/${P} \
		--mandir=/usr/share/man/man1 || die "./configure failed"
	addwrite "/var/lib/texmf"
	addwrite "/usr/share/texmf"
	addwrite "/var/cache/fonts"
	emake doc gp || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS Announce.2.1 CHANGES README TODO
}
