# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vconfig/vconfig-1.7-r1.ebuild,v 1.3 2003/09/05 22:01:49 msterret Exp $

MY_PN="vlan"
S=${WORKDIR}/${MY_PN}

DESCRIPTION="802.1Q vlan control utility"
HOMEPAGE="http://www.candelatech.com/~greear/vlan.html"
SRC_URI="http://www.candelatech.com/~greear/vlan/${MY_PN}.${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~arm"
IUSE="static"
DEPEND=">=sys-kernel/linux-headers-2.4.14"
RDEPEND=">=virtual/kernel-2.4.14"

src_compile() {
	use static && LDFLAGS="${LDFLAGS} -static"
	emake CC="gcc" CCFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	into /
	dosbin vconfig || die "dosbin error"

	sed -e "s:/usr/local/bin/vconfig:/sbin/vconfig:" \
		< vlan_test.pl > vlan_test.pl~ && \
		mv vlan_test.pl~ vlan_test.pl
	sed -e "s:/usr/local/bin/vconfig:/sbin/vconfig:" \
		< vlan_test2.pl > vlan_test2.pl~ && \
		mv vlan_test2.pl~ vlan_test2.pl

	doman vconfig.8 || die "doman error"
	dohtml howto.html vlan.html || die "dohtml error"
	dodoc CHANGELOG README vlan_test*.pl || die "dodoc error"

}

pkg_postinst() {
	einfo "802.1Q VLAN support is now in the linux kernel as of 2.4.14."
	ewarn "But MTU problems exist for many ethernet drivers"
}
