# Copyright 2002 Niek van der Maas
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/Welcome2L/Welcome2L-3.04.ebuild,v 1.5 2003/08/06 07:53:16 vapier Exp $

inherit eutils

DESCRIPTION="Welcome to Linux, ANSI login logo for Linux"
HOMEPAGE="http://www.littleigloo.org/" 
SRC_URI="http://www.chez.com/littleigloo/files/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_unpack() { 
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
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
