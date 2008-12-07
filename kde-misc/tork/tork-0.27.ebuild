# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tork/tork-0.27.ebuild,v 1.4 2008/12/07 00:31:06 patrick Exp $

ARTS_REQUIRED="never"

inherit kde multilib

DESCRIPTION="TorK is a powerful anonymity manager for the KDE and acts as a frontend to Tor."
HOMEPAGE="http://tork.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="gnutls"

DEPEND="dev-libs/openssl
	>=dev-libs/geoip-1.4.0
	gnutls? ( >=net-libs/gnutls-2.2.2 )
	!gnutls? ( >=dev-libs/openssl-0.9.8g )
	|| ( =kde-base/libkonq-3.5* =kde-base/kdebase-3.5* )"

RDEPEND="${DEPEND}
	>=net-misc/tor-0.1.2.14
	>=net-proxy/privoxy-3.0.3-r5
	>=net-proxy/tsocks-1.8_beta5-r2"

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-ext_tsocks.patch"
	"${FILESDIR}/${P}+gcc-4.3.patch" )

src_compile() {
	# Fix desktop file
	sed -i -e "s:^\(Categories=.*\):\1;:" "${S}/src/tork.desktop"

	local myconf="--with-external-geoip --with-conf=/etc/socks/tsocks.conf"
	use gnutls && myconf="${myconf} --enable-gnutls"

	rm "${S}"/configure
	kde_src_compile
}

pkg_postinst() {
	if ! built_with_use --missing false net-proxy/tsocks tordns; then
		ewarn "WARNING: you have net-proxy/tsocks installed without"
		ewarn "the patch to avoid DNS leaking while using Tor."
		ewarn "For better privacy, please emerge again net-proxy/tsocks"
		ewarn "with the USE flag 'tordns' enabled."
	fi
}
