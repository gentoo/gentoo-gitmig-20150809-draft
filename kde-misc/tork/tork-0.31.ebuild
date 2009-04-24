# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/tork/tork-0.31.ebuild,v 1.1 2009/04/24 22:03:04 patrick Exp $

EAPI="0"

ARTS_REQUIRED="never"

inherit kde multilib

DESCRIPTION="TorK is a powerful anonymity manager for the KDE and acts as a frontedn to Tor."
HOMEPAGE="http://tork.sourceforge.net/"
SRC_URI="http://www.anonymityanywhere.com/pre-release/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="arts gnutls"

DEPEND="dev-libs/openssl
	>=dev-libs/geoip-1.4.0
	gnutls? ( >=net-libs/gnutls-2.2.2 )
	!gnutls? ( >=dev-libs/openssl-0.9.8g )
	|| ( =kde-base/libkonq-3.5* =kde-base/kdebase-3.5* )"

RDEPEND="${DEPEND}
	>=net-misc/tor-0.1.2.14
	>=net-proxy/tsocks-1.8_beta5-r2"

need-kde 3.5

PATCHES=( "${FILESDIR}/${PN}-0.27+gcc-4.3.patch" )

src_compile() {
	# Fix desktop file
	sed -i -e "s:^\(Categories=.*\):\1;:" "${S}/src/tork.desktop"

	local myconf="--with-external-geoip --with-conf=/etc/socks/tsocks.conf"
	use gnutls && myconf="${myconf} --enable-gnutls"

	if ! use arts ; then
		myconf="${myconf} --without-arts"
	fi

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
