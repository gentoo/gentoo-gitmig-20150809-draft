# Copyright 2002 Niek van der Maas
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/Welcome2L/Welcome2L-3.04.ebuild,v 1.3 2003/06/29 23:17:15 aliz Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Welcome to Linux, ANSI login logo for Linux."
SRC_URI="http://www.chez.com/littleigloo/files/${P}.src.tar.gz"
HOMEPAGE="http://www.littleigloo.org/" 

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

src_unpack() { 
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/Welcome2L-3.04-gentoo.patch
}

src_compile() {
	make || die
}

src_install() {
	dobin Welcome2L
	doman Welcome2L.1
	dodoc AUTHORS README INSTALL COPYING ChangeLog BUGS TODO
	exeinto /etc/init.d ; newexe ${FILESDIR}/Welcome2L.initscript Welcome2L
}

pkg_postinst() {
	einfo "NOTE: To start Welcome2L on boot, please type:"
	einfo "rc-update add Welcome2L default"
}
