# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tinc/tinc-1.0.16-r3.ebuild,v 1.1 2012/01/31 22:53:03 blueness Exp $

EAPI="4"

inherit eutils

DESCRIPTION="tinc is an easy to configure VPN implementation"
HOMEPAGE="http://www.tinc-vpn.org/"
SRC_URI="http://www.tinc-vpn.org/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~x86-linux ~ppc-macos ~x86-macos"
IUSE="+lzo +zlib raw uml vde"

DEPEND=">=dev-libs/openssl-0.9.7c
	lzo? ( dev-libs/lzo:2 )
	zlib? ( >=sys-libs/zlib-1.1.4-r2 )
	vde? ( net-misc/vde )"
RDEPEND="${DEPEND}"

src_prepare() {
	local COUNT=0
	use raw && COUNT=$(($COUNT+1))
	use uml && COUNT=$(($COUNT+1))
	use vde && COUNT=$(($COUNT+1))

	if [[ ${COUNT} -gt 1 ]]; then
		eerror
		eerror "\033[1;31m**************************************************\033[1;31m"
		eerror
		eerror "\033[1;31m If you selected either raw, uml or vde,\033[1;31m"
		eerror "\033[1;31m you can select only one.\033[1;31m"
		eerror
		eerror "\033[1;31m**************************************************\033[1;31m"
		eerror
		die
	fi

	epatch "${FILESDIR}"/fix-missing-vde.patch
	epatch "${FILESDIR}"/fix-compile-vde-uml.patch
}

src_configure() {
	econf  --enable-jumbograms $(use_enable lzo) $(use_enable zlib)
	use raw && cd "${S}"/src && ln -sf raw_socket/device.c
	use uml && cd "${S}"/src && ln -sf uml_socket/device.c
	use vde && cd "${S}"/src && ln -sf vde/device.c
}

src_install() {
	emake DESTDIR="${D}" install
	dodir /etc/tinc
	dodoc AUTHORS NEWS README THANKS
	newinitd "${FILESDIR}"/tincd.1 tincd
	newinitd "${FILESDIR}"/tincd.lo.1 tincd.lo
	doconfd "${FILESDIR}"/tinc.networks
	newconfd "${FILESDIR}"/tincd.conf.1 tincd
}

pkg_postinst() {
	elog "This package requires the tun/tap kernel device."
	elog "Look at http://www.tinc-vpn.org/ for how to configure tinc"
}
