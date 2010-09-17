# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tinc/tinc-1.0.8.ebuild,v 1.2 2010/09/17 09:48:50 robbat2 Exp $

DESCRIPTION="tinc is an easy to configure VPN implementation"
HOMEPAGE="http://www.tinc-vpn.org/"
SRC_URI="http://www.tinc-vpn.org/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86"
IUSE="nls"

DEPEND=">=dev-libs/openssl-0.9.7c
	>=dev-libs/lzo-2
	>=sys-libs/zlib-1.1.4-r2
	nls? ( sys-devel/gettext )"

src_compile() {
	econf --enable-jumbograms $(use_enable nls) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodir /etc/tinc
	dodoc AUTHORS NEWS README THANKS
	doinitd "${FILESDIR}"/tincd
	doconfd "${FILESDIR}"/tinc.networks
}

pkg_postinst() {
	elog "This package requires the tun/tap kernel device."
	elog "Look at http://www.tinc-vpn.org/ for how to configure tinc"
}
