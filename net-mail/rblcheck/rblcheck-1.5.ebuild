# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Enrico Morelli - 05/08/2002

S=${WORKDIR}/${P}
DESCRIPTION="Perform lookups in RBL-styles services."
SRC_URI="mirror://sourceforge/rblcheck/${P}.tar.gz"
HOMEPAGE="http://rblcheck.sourceforge.net/"
KEYWORDS="*"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	./configure --prefix=/usr
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe rbl rblcheck

	dodoc README docs/rblcheck.ps docs/rblcheck.rtf

}
