# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="pari (or pari-gp) : a software package for computer-aided number theory"
HOMEPAGE="http://www.parigp-home.de/"
LICENSE="GPL-2"
DEPEND="app-text/tetex"
RDEPEND=""
SRC_URI="http://www.gn-50uma.de/ftp/pari-2.1/${P}.tar.gz"
KEYWORDS="~x86 ~ppc ~sparc "
SLOT="0"
S=${WORKDIR}/${P}

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
}
