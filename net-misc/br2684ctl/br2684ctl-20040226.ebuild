# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit gcc eutils

DEBIANPKG_TARBALL="${PN}_${PV}.orig.tar.gz"
DEBIANPKG_PATCH="${PN}_${PV}-1.diff.gz"
DEBIANPKG_BASE="mirror://debian/pool/main/${PN:0:1}/${PN}"

DESCRIPTION="Utility for configuring RFC 2684 ATM/Ethernet bridging"
HOMEPAGE="http://packages.debian.org/unstable/net/${PN}"
SRC_URI="${DEBIANPKG_BASE}/${DEBIANPKG_TARBALL}
		 ${DEBIANPKG_BASE}/${DEBIANPKG_PATCH}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=net-dialup/linux-atm-2.4.1"
DEPEND="virtual/os-headers
		${RDEPEND}"

S=${WORKDIR}/${P}.orig

src_unpack() {
	unpack ${DEBIANPKG_TARBALL}
	cd ${S}
	EPATCH_OPTS="-p1" epatch ${DISTDIR}/${DEBIANPKG_PATCH}
}

src_compile() {
	echo $(gcc-getCC) ${CFLAGS} -latm ${PN}.c -o ${PN}
	$(gcc-getCC) ${CFLAGS} -latm ${PN}.c -o ${PN} || die "Failed to compile!"
}

src_install() {
	doman ${PN}.8
	into /
	dosbin ${PN}
	# there really is no better documentation than the sourcecode :-)
	dodoc ${PN}.c
}

pkg_postinst() {
	einfo "br2684ctl can be use to setup Ethernet bridge interface of"
	einfo "some ADSL USB modem devices"
	einfo "Ethernet interface name are nas0 (,nas1,nas2 ...) not eth0"
	einfo "You can use >=sys-apps/baselayout-1.10, where it can be start with"
	einfo "preup script to run br2684ctl and setup bridge before start"
	einfo "PPPoE, dhcp or configure interface using /etc/init.d/net.nas0"
	einfo "and /etc/conf/net"
	einfo ""
	einfo "Example:"
	einfo "preup() {"
	einfo "   if [ \"\${IFACE}\"=\"nas0\" ]; then"
	einfo "      einfo \"Setting up RFC2684 ATM Brigde for \${IFACE}\""
	einfo "      /sbin/br2684ctl -a 0.100 -b 1 || return 1"
	einfo "      return 0"
	einfo "   fi"
	einfo "}"
	einfo ""
	einfo "Using >=sys-apps/baselayout-1.11.6 strongly recommended."
	einfo "Note: Replace 0.100 with your VPI.VCI of your provider"
	einfo "      see br2684ctl(8) for more information"
}

