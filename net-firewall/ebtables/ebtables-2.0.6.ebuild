# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ebtables/ebtables-2.0.6.ebuild,v 1.7 2004/07/20 02:45:13 lv Exp $

DESCRIPTION="Utility that enables basic Ethernet frame filtering on a Linux bridge, MAC NAT and brouting."
SRC_URI="mirror://sourceforge/${PN}/${PN}-v${PV}.tar.gz"
HOMEPAGE="http://${PN}.sourceforge.net/"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

inherit eutils

S=${WORKDIR}/${PN}-v${PV}/

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix a silly little "label at end of compound statement" error that
	# prevents ebtables from being compilable with gcc 3.4
	epatch ${FILESDIR}/ebtables-2.0.6-gcc34.patch
}

src_install() {
	dodir /sbin/
	einstall MANDIR=${D}/usr/share/man ETHERTYPESPATH=${D}/etc/ BINPATH=${D}/sbin/ || die
}
