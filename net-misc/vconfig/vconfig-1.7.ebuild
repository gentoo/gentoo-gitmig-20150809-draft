# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vconfig/vconfig-1.7.ebuild,v 1.6 2004/07/13 03:06:04 solar Exp $

MY_PN="vlan"
DESCRIPTION="802.1Q vlan control utility"
HOMEPAGE="http://www.candelatech.com/~greear/vlan.html"
SRC_URI="http://www.candelatech.com/~greear/vlan/${MY_PN}.${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc "
IUSE="static"
DEPEND="virtual/os-headers"
S=${WORKDIR}/${MY_PN}

src_compile() {
	use static && LDFLAGS="${LDFLAGS} -static"
	emake CC="gcc" CCFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dosbin vconfig || die "dosbin error"
	doman vconfig.8 || die "doman error"
	dodoc CHANGELOG README || die "dodoc error"
	dohtml howto.html vlan.html || die "dohtml error"
}

pkg_postinst() {
	ewarn "MTU problems exist for many ethernet drivers"
}
