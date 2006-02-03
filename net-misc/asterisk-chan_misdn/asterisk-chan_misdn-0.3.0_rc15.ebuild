# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_misdn/asterisk-chan_misdn-0.3.0_rc15.ebuild,v 1.1 2006/02/03 19:54:04 genstef Exp $

MY_PN=${PN/asterisk-}
DESCRIPTION="Asterisk channel plugin for mISDN"
HOMEPAGE="http://www.beronet.com/"
SRC_URI="http://www.beronet.com/downloads/chan_misdn/releases/V${PV:0:3}/candidates/${MY_PN}-${PV/_/-}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=net-dialup/misdnuser-0.1_pre20051026
	>=net-misc/asterisk-1.2"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -ir "s:.*MISDNUSERLIB.*::" Makefile || die "sed failed"
}

src_install() {
	exeinto /usr/lib/asterisk/modules
	doexe chan_misdn.so
	insinto /etc/asterisk
	doins misdn.conf

	dodoc README README.misdn
}
