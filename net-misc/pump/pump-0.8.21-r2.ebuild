# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pump/pump-0.8.21-r2.ebuild,v 1.1 2005/07/01 09:47:18 uberlord Exp $

inherit eutils

DESCRIPTION="This is the DHCP/BOOTP client written by RedHat"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/p/pump/"
SRC_URI="mirror://debian/pool/main/p/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/popt-1.5"

PROVIDE="virtual/dhcpc"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Enable the -e (--etc-dir) option to specify where to make
	# resolv.conf - default /etc
	# Enable the -m (--route-metric) option to specify the default
	# metric applied to routes
	# Enable the --script option to specify a script to run on DHCP actions
	# Enable the --keep-up option to keep interfaces up when we release
	epatch "${FILESDIR}/pump-0.8-gentoo.diff"
}

src_compile() {
	make pump RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	into /
	dosbin pump || die

	doman pump.8
	dodoc CREDITS

	into /usr/
	dolib.a libpump.a
	insinto /usr/include/
	doins pump.h

	make -C po install datadir="${D}/usr/share/"
}
