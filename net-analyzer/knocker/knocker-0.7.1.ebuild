# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/knocker/knocker-0.7.1.ebuild,v 1.7 2004/04/15 19:50:16 dholm Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Knocker is an easy to use security port scanner written in C"
SRC_URI="mirror://sourceforge/knocker/${P}.tar.gz"
HOMEPAGE="http://knocker.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"

DEPEND="virtual/glibc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die "emake died"
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc ChangeLog AUTHORS README BUGS TO-DO NEWS
}
