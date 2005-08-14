# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcpcd/dhcpcd-2.0.0.ebuild,v 1.5 2005/08/14 09:50:02 corsair Exp $

inherit flag-o-matic eutils

DESCRIPTION="A DHCP client only"
HOMEPAGE="http://developer.berlios.de/projects/dhcpcd/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="build debug static"

DEPEND=""
PROVIDE="virtual/dhcpc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix compiling on gcc2
	epatch "${FILESDIR}/${P}-gcc2.patch"

	# Redefine the location of ntp.drift
	sed -i 's:/etc/ntp\.drift:/var/lib/ntp/ntp.drift:' src/dhcpconfig.c
}

src_compile() {
	local myconf="$( use_enable debug )"
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
