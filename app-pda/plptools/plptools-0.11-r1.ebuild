# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/plptools/plptools-0.11-r1.ebuild,v 1.8 2004/07/13 18:33:34 agriffis Exp $

DESCRIPTION="Libraries and utilities to communicate with a Psion palmtop via serial."
HOMEPAGE="http://plptools.sourceforge.net"
SRC_URI="mirror://sourceforge/plptools/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/libc"
S="${WORKDIR}/${P}"

src_compile() {
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch || die "Patch failed!"

	local myconf

	myconf="${myconf} --disable-kde"

	./configure ${myconf} --prefix=/usr || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc CHANGES README TODO

	insinto /etc/conf.d
	newins ${FILESDIR}/psion.conf psion

	exeinto /etc/init.d
	doexe ${FILESDIR}/psion
}
