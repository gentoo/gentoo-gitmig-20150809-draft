# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmtp/libmtp-1.0.3-r2.ebuild,v 1.1 2010/11/30 03:17:48 ken69267 Exp $

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

src_prepare() {
	# Fix device permissions
	epatch "${FILESDIR}"/permissions.patch
}

src_configure() {
	econf \
		--enable-shared \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	find "${D}" -name '*.la' -exec rm -f '{}' +

	dodoc AUTHORS ChangeLog README TODO || die

	insinto /$(get_libdir)/udev/rules.d
	newins libmtp.rules 65-mtp.rules

	insinto /usr/share/hal/fdi/information/20thirdparty
	newins libmtp.fdi 10-libmtp.fdi

	if use examples; then
		docinto examples
		dodoc examples/*.{c,h,sh}
	fi
}
