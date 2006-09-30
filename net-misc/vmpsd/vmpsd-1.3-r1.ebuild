# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vmpsd/vmpsd-1.3-r1.ebuild,v 1.1 2006/09/30 17:25:04 robbat2 Exp $

inherit eutils

DESCRIPTION="An open-source VLAN management system"
HOMEPAGE="http://vmps.sourceforge.net"
SRC_URI="mirror://sourceforge/vmps/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="snmp"
DEPEND="virtual/libc
		snmp? ( net-analyzer/net-snmp )"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	use snmp && epatch ${FILESDIR}/${P}-snmp-support.patch
}

src_compile() {
	econf \
		--sysconfdir=/etc/vmpsd \
		`use_enable snmp` \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd "${S}"
	emake DESTDIR="${D}" install || die
	dodoc README INSTALL AUTHORS doc/*txt
	newdoc external/README README.external
	newdoc tools/README README.tools
	dodoc external/simple tools/vqpcli.pl
}
