# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/asio/asio-0.3.4.ebuild,v 1.3 2005/10/20 17:21:09 rphillips Exp $

DESCRIPTION="asynchronous network library"
HOMEPAGE="http://asio.sourceforge.net/"
SRC_URI="mirror://sourceforge/asio/${P}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl doc"

DEPEND=">=dev-libs/boost-1.33.0
	doc? ( app-doc/doxygen )
	ssl? ( dev-libs/openssl )"
RDEPEND=""

src_install() {
	einstall || die "install error"

	dodoc README COPYING INSTALL

	if use doc; then
		dodir /usr/share/doc/${PF}/
		mv doc/* ${D}/usr/share/doc/${PF}/
	fi
}
