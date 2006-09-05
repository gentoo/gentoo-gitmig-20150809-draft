# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-2.0.8-r3.ebuild,v 1.2 2006/09/05 16:13:59 uberlord Exp $

inherit eutils flag-o-matic linux-info

DESCRIPTION="A DHCP client only"
HOMEPAGE="http://developer.berlios.de/projects/dhcpcd/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="build debug static"

DEPEND=""
PROVIDE="virtual/dhcpc"

pkg_setup() {
	if use kernel_linux ; then
		CONFIG_CHECK="PACKET"
		ERROR_PACKET="${P} requires support for Packet Socket (CONFIG_PACKET)."
		linux-info_pkg_setup
	fi
	
	if use debug ; then
		ewarn "WARNING: dhcpcd will provide good debugging output with the"
		ewarn "debug USE flag enabled but will not actually configure the"
		ewarn "interface or setup /etc/resolv.conf"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Never take the interface down
	epatch "${FILESDIR}/${PN}-2.0.8-alwaysup.patch"

	epatch "${FILESDIR}/${P}-loglevel.patch"
	epatch "${FILESDIR}/${P}-no_resolve_hostname.patch"

	# Redefine the location of ntp.drift
	sed -i 's:/etc/ntp\.drift:/var/lib/ntp/ntp.drift:' src/dhcpconfig.c
}

src_compile() {
	use static && append-flags -static
	econf $(use_enable debug) || die
	emake || die
}

src_install() {
	into /
	dosbin src/dhcpcd || die

	if ! use build ; then
		dodoc AUTHORS ChangeLog NEWS README
		doman src/dhcpcd.8
	fi
}
