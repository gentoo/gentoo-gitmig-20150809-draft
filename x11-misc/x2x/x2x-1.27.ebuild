# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2x/x2x-1.27.ebuild,v 1.8 2004/03/14 00:40:09 geoman Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An utility to connect the Mouse and KeyBoard to another X"
HOMEPAGE="http://www.the-labs.com/X11/#x2x"
LICENSE="as-is"
DEPEND="virtual/x11"
RDEPEND="virtual/x11"
SRC_URI="http://ftp.digital.com/pub/Digital/SRC/x2x/${P}.tar.gz"
SLOT="0"
KEYWORDS="x86 sparc alpha amd64 ~mips"

src_unpack() {
	unpack ${A}
	cd ${S}
	gunzip < ${FILESDIR}/${P}.diff.gz | patch || die "patch failed"
}

src_compile() {
	xmkmf
	cp x2x.1 x2x.man
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	doman x2x.1
	dodoc ${S}/LICENSE
}
