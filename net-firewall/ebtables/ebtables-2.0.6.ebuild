# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ebtables/ebtables-2.0.6.ebuild,v 1.11 2005/06/08 02:14:47 solar Exp $

inherit eutils toolchain-funcs

MY_P="${PN}-v${PV}"

DESCRIPTION="Utility that enables basic Ethernet frame filtering on a Linux bridge, MAC NAT and brouting."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://ebtables.sourceforge.net/"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${MY_P}"

DEPEND="virtual/libc"

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix "label at end of compound statement" error that
	# prevents ebtables from being compilable with >=gcc-3.4
	epatch ${FILESDIR}/ebtables-2.0.6-gcc34.patch
}

src_install() {
	dodir /sbin/
	einstall MANDIR=${D}/usr/share/man ETHERTYPESPATH=${D}/etc/ BINPATH=${D}/sbin/ || die
}
