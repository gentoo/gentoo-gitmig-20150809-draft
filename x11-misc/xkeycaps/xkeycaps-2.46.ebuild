# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkeycaps/xkeycaps-2.46.ebuild,v 1.2 2002/07/08 21:31:08 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GUI frontend to xmodmap"
SRC_URI="http://www.jwz.org/${PN}/${P}.tar.Z"
HOMEPAGE="http://www.jwz.org/xkeycaps/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	cp Makefile Makefile.old
	sed -e "s,all:: xkeycaps.\$(MANSUFFIX).html,all:: ,g" 		\
		Makefile.old > Makefile
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc README
}



