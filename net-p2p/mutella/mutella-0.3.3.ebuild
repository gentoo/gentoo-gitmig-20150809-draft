# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mutella/mutella-0.3.3.ebuild,v 1.5 2002/11/03 17:38:25 mkennedy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Text-mode gnutella client."
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/mutella/mutella-0.3.3.tar.gz"
HOMEPAGE="http://mutella.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc sys-libs/readline"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd ${S} && patch -p1 <${FILESDIR}/mutella-gcc3-gentoo.patch || die
}

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
	dodoc AUTHORS ChangeLog COPYING INSTALL KNOWN-BUGS README TODO
}


