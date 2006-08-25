# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ebtables/ebtables-2.0.6-r1.ebuild,v 1.3 2006/08/25 18:52:01 wolf31o2 Exp $

inherit eutils toolchain-funcs

MY_P="${PN}-v${PV}"

DESCRIPTION="Utility that enables basic Ethernet frame filtering on a Linux bridge, MAC NAT and brouting."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://ebtables.sourceforge.net/"
KEYWORDS="amd64 ppc x86"
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

	# ebtables does not build with gcc-4.x; Bug #119489
	epatch ${FILESDIR}/ebtables-2.0.6-gcc4.patch
}

src_install() {
	dodir /sbin/
	einstall MANDIR=${D}/usr/share/man ETHERTYPESPATH=${D}/etc/ BINPATH=${D}/sbin/ || die
}
