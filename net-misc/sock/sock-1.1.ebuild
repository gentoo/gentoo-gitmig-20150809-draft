# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sock/sock-1.1.ebuild,v 1.11 2004/11/12 18:23:17 blubb Exp $

DESCRIPTION="A shell interface to network sockets"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/local/mj/net/${P}.tar.gz"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/linux.shtml"
KEYWORDS="x86 sparc ~amd64"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND=""
#RDEPEND=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	exeinto /usr/bin
	doexe sock
	doman sock.1
#	make DESTDIR=${D} install || die
	dodoc README ChangeLog
}
