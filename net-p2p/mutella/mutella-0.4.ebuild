# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mutella/mutella-0.4.ebuild,v 1.2 2002/07/26 05:04:29 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="mutella is a text-mode gnutella client."
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/mutella/${P}.tar.gz"
HOMEPAGE="http://mutella.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc
	>=sys-libs/readline-4.2"
RDEPEND=${DEPEND}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die "compile problem"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL LICENSE KNOWN-BUGS README TODO
}


