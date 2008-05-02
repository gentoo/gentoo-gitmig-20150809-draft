# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-2.0.5-r1.ebuild,v 1.4 2008/05/02 15:57:03 cardoe Exp $

inherit eutils flag-o-matic

DESCRIPTION="A DHCP client only"
HOMEPAGE="http://developer.berlios.de/projects/dhcpcd/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="build debug static"

DEPEND=""
PROVIDE="virtual/dhcpc"

pkg_setup() {
	if use debug ; then
		ewarn "WARNING: dhcpcd will provide good debugging output with the"
		ewarn "debug USE flag enabled but will not actually configure the"
		ewarn "interface or setup /etc/resolv.conf"
	fi
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Never take the interface down
	epatch "${FILESDIR}/${PN}-2.0.0-alwaysup.patch"

	# Redefine the location of ntp.drift
	sed -i 's:/etc/ntp\.drift:/var/lib/ntp/ntp.drift:' src/dhcpconfig.c
}

src_compile() {
	local myconf="$(use_enable debug)"
	use static && append-flags -static

	econf ${myconf} || die
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

pkg_postinst() {
	if use kernel_linux ; then
		ewarn
		ewarn "${PN} requires kernel support for Packet Socket (CONFIG_PACKET)."
		ewarn
	fi
}
