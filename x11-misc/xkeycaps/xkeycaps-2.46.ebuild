# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkeycaps/xkeycaps-2.46.ebuild,v 1.9 2003/02/13 17:20:31 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GUI frontend to xmodmap"
SRC_URI="http://www.jwz.org/${PN}/${P}.tar.Z"
HOMEPAGE="http://www.jwz.org/xkeycaps/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc "

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



