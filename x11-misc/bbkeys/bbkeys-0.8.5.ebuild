# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbkeys/bbkeys-0.8.5.ebuild,v 1.2 2002/10/04 06:41:51 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Use keyboard shortcuts in the blackbox wm"
HOMEPAGE="http://bbkeys.sourceforge.net"
SRC_URI="mirror://sourceforge/bbkeys/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/blackbox"

src_compile() {
	./configure		\
		--host=${CHOST}	\
		--prefix=/usr || die "./configure failed"
	emake || die
}

src_install () {
	make 	\
		prefix=${D}/usr	\
		install || die
	rm -rf ${D}/usr/doc
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
