# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkeycaps/xkeycaps-2.46.ebuild,v 1.10 2003/02/15 08:16:40 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GUI frontend to xmodmap"
SRC_URI="http://www.jwz.org/${PN}/${P}.tar.Z"
HOMEPAGE="http://www.jwz.org/xkeycaps/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc  ppc"

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	cp Makefile Makefile.old
	sed -e "s,all:: xkeycaps.\$(MANSUFFIX).html,all:: ,g" \
		Makefile.old > Makefile
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc README
}



