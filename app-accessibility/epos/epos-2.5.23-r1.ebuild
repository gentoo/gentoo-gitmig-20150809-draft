# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/epos/epos-2.5.23-r1.ebuild,v 1.1 2004/06/15 21:01:10 squinky86 Exp $

inherit eutils

DESCRIPTION="language independent text-to-speech system"
HOMEPAGE="http://epos.ure.cas.cz/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/epos-waveform.patch
	cd ${S}
}

src_install() {
	einstall || die
	mv ${D}/usr/bin/say ${D}/usr/bin/epos_say
	exeinto /etc/init.d
	doexe ${FILESDIR}/epos
	dodoc WELCOME THANKS Changes ${FILESDIR}/README.gentoo
}
