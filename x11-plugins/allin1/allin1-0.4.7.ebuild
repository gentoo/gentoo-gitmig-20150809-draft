# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/allin1/allin1-0.4.7.ebuild,v 1.4 2004/07/15 00:59:13 agriffis Exp $

inherit eutils

S=${WORKDIR}/${PN}
DESCRIPTION="All in one monitoring dockapp: RAM, CPU, Net, Power, df"
HOMEPAGE="http://digilander.libero.it/tailchaser/en_linux_allin1.html"
SRC_URI="mirror://sourceforge/allinone/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-pl1.patch
}

src_compile() {
	make || die
}

src_install() {
	preplib /usr

	dobin src/allin1
	doman docs/allin1.1
	dodoc INSTALL COPYING README README.it TODO ChangeLog BUGS \
	allin1.spec src/allin1.conf.example
}
