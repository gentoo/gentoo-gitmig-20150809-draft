# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vmpsd/vmpsd-1.3.ebuild,v 1.2 2004/12/08 08:20:45 mr_bones_ Exp $

inherit eutils

DESCRIPTION="An open-source VLAN management system"
HOMEPAGE="http://vmps.sourceforge.net"
SRC_URI="mirror://sourceforge/vmps/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="" # snmp support is totally broken in this package
DEPEND="virtual/libc"
S="${WORKDIR}/${PN}"

src_compile() {
	# SNMP support is broken in this package
	# It was written for old GCC + UCD-SNMP only.
	econf \
		--sysconfdir=/etc/vmpsd \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	emake DESTDIR=${D} install || die
	dodoc README INSTALL AUTHORS doc/*txt
	newdoc external/README README.external
	newdoc tools/README README.tools
	dodoc external/simple tools/vqpcli.pl
}
