# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/cabextract/cabextract-0.5.ebuild,v 1.5 2002/07/17 20:44:57 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Extracts files from Microsoft .cab files"
SRC_URI="http://www.kyz.uklinux.net/downloads/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.kyz.uklinux.net/cabextract.php3"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {

	./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man || die
	emake || die
}

src_install() {

	dobin cabextract
	doman cabextract.1
	dodoc COPYING NEWS README TODO AUTHORS
}
