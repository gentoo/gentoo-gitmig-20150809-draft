# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/welcome2l/welcome2l-3.04.ebuild,v 1.5 2004/04/06 23:14:31 weeve Exp $

inherit eutils

MY_PN=Welcome2L
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Welcome to Linux, ANSI login logo for Linux"
HOMEPAGE="http://www.littleigloo.org/"
SRC_URI="http://www.chez.com/littleigloo/files/${MY_P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ~sparc"

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
	dobin ${MY_PN}
	doman ${MY_PN}.1
	dodoc AUTHORS README INSTALL COPYING ChangeLog BUGS TODO
	exeinto /etc/init.d ; newexe ${FILESDIR}/${PN}.initscript ${MY_PN}
}

pkg_postinst() {
	einfo "NOTE: To start Welcome2L on boot, please type:"
	einfo "rc-update add Welcome2L default"
}
