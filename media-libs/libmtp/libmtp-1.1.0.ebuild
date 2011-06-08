# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmtp/libmtp-1.1.0.ebuild,v 1.1 2011/06/08 18:32:46 ken69267 Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="An implementation of Microsoft's Media Transfer Protocol (MTP)."
HOMEPAGE="http://libmtp.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
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
		--with-udev=/$(get_libdir)/udev/ \
		--with-udev-rules="65-mtp.rules" \
		--with-udev-group="plugdev" \
		--with-udev-mode="0660"
}

src_install() {
	emake DESTDIR="${D}" install || die
	find "${D}" -name '*.la' -exec rm -f {} +

	dodoc AUTHORS ChangeLog README TODO || die

	if use examples; then
		docinto examples
		dodoc examples/*.{c,h,sh}
	fi
}
