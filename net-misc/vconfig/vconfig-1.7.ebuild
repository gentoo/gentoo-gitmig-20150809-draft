# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vconfig/vconfig-1.7.ebuild,v 1.1 2003/06/07 15:12:35 solar Exp $

MY_PN="vlan"
DESCRIPTION="802.1Q vlan control utility"
HOMEPAGE="http://www.candelatech.com/~greear/vlan.html"
SRC_URI="http://www.candelatech.com/~greear/vlan/${MY_PN}.${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~arm"
IUSE="static"
DEPEND=">=sys-kernel/linux-headers-2.4.14"
RDEPEND=">=virtual/kernel-2.4.14"
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
