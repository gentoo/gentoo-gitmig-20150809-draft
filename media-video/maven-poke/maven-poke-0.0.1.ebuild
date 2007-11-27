# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/maven-poke/maven-poke-0.0.1.ebuild,v 1.5 2007/11/27 12:14:23 zzam Exp $

IUSE=""

#S=${WORKDIR}/${PN}
DESCRIPTION="Matrox utility to read and set maven registers (tune tvout)"
HOMEPAGE="ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/"
SRC_URI="ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/${P}.tgz"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

src_compile() {
	make all || die

	#prepare small README
	cat >> "${S}"/README << _EOF_
This utility has been created by Petr Vandrovec.
It was formerly called maven-prog (and the executable was matrox).

A listing of maven registers
http://platan.vc.cvut.cz/~vana/maven/mavenreg.html

Not much info here, but here are some pointers
http://davedina.apestaart.org/download/doc/Matrox-TVOUT-HOWTO-0.1.txt
http://www.netnode.de/howto/matrox-fb.html
_EOF_
}

src_install() {
	mv matrox maven-poke
	dobin maven-poke

	dodoc README
}
