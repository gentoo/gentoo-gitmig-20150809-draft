# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmtp/libmtp-1.1.1.ebuild,v 1.7 2012/02/24 19:21:26 ranger Exp $

EAPI=4
inherit eutils multilib

DESCRIPTION="An implementation of Microsoft's Media Transfer Protocol (MTP)."
HOMEPAGE="http://libmtp.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86"
IUSE="doc examples static-libs"

RDEPEND="virtual/libusb:0"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	sys-apps/findutils"

pkg_setup() {
	enewgroup plugdev
}

src_configure() {
	econf \
		--enable-shared \
		$(use_enable static-libs static) \
		$(use_enable doc doxygen) \
		--with-udev-group="plugdev" \
		--with-udev-mode="0660"
}

src_install() {
	emake DESTDIR="${D}" install
	find "${D}" -name '*.la' -exec rm -f {} +

	dodoc AUTHORS ChangeLog README TODO

	if use examples; then
		docinto examples
		dodoc examples/*.{c,h,sh}
	fi
}
