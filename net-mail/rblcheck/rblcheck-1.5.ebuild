# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Enrico Morelli - 05/08/2002
# $Header: /var/cvsroot/gentoo-x86/net-mail/rblcheck/rblcheck-1.5.ebuild,v 1.5 2003/06/12 21:32:03 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Perform lookups in RBL-styles services."
HOMEPAGE="http://rblcheck.sourceforge.net/"
SRC_URI="mirror://sourceforge/rblcheck/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa mips arm"

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
