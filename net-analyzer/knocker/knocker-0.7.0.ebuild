# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/knocker/knocker-0.7.0.ebuild,v 1.1 2002/05/30 00:42:41 spider Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Knocker is an easy to use security port scanner written in C"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/knocker/${P}.tar.gz"
HOMEPAGE="http://knocker.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

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
