# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/openipmi/openipmi-1.3.18.ebuild,v 1.1 2005/03/25 22:03:50 robbat2 Exp $

DESCRIPTION="Library interface to IPMI"
HOMEPAGE="http://sourceforge.net/projects/${PN}/"
MY_PN="OpenIPMI"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="crypt snmp"
S="${WORKDIR}/${MY_P}"

DEPEND="virtual/libc
		sys-libs/gdbm
		dev-util/pkgconfig
		crypt? ( dev-libs/openssl )
		snmp? ( net-analyzer/net-snmp )"

src_compile() {
	local myconf=""
	myconf="${myconf} `use_with snmp ucdsnmp yes`"
	myconf="${myconf} `use_with crypt openssl yes`"
	# these binaries are for root!
	econf ${myconf} --bindir=/usr/sbin || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README* FAQ ChangeLog TODO lanserv/README.emulator lanserv/atca.emu
}
