# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/npadmin/npadmin-0.8.7.ebuild,v 1.1 2005/02/26 09:46:12 robbat2 Exp $

inherit eutils
DESCRIPTION="Network printer command-line adminstration tool"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tar.gz"
HOMEPAGE="http://npadmin.sourceforge.net/"
# this does NOT link against SNMP
DEPEND="virtual/libc"
KEYWORDS="~x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-${PV}-stdlib.patch
}

src_compile() {
	econf || die
	emake || die "Make failed."
}

src_install() {
	dobin npadmin
	doman npadmin.1
	dodoc README AUTHORS ChangeLog INSTALL NEWS README TODO
}
