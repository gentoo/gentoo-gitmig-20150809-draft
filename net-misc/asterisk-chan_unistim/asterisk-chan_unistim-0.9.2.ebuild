# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-chan_unistim/asterisk-chan_unistim-0.9.2.ebuild,v 1.1 2005/03/29 15:09:44 stkn Exp $

inherit eutils

MY_PN="chan_unistim"

DESCRIPTION="Unistim channel module for Asterisk"
HOMEPAGE="http://mlkj.net/UNISTIM/"
SRC_URI="http://mlkj.net/asterisk/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=net-misc/asterisk-1.0.5-r1"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${MY_PN}-${PV}-gentoo.diff
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make INSTALL_PREFIX=${D} install config || die "make install failed"

	dodoc README unistim.conf
}

pkg_postinst() {
	einfo "For more information about this module:"
	einfo ""
	einfo "http://www.voip-info.org/wiki-Asterisk+UNISTIM+channels"
	einfo ""
	einfo "http://www.voip-info.org/wiki-Nortel+Phones"
}
