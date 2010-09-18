# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmtp/libmtp-1.0.3-r1.ebuild,v 1.2 2010/09/18 17:07:11 armin76 Exp $

EAPI=2

inherit eutils

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
	emake DESTDIR="${D}" install || die "emake install failed"

	rm -f $(find "${D}" -name '*.la')
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"

	insinto /etc/udev/rules.d
	newins libmtp.rules 65-mtp.rules

	insinto /usr/share/hal/fdi/information/20thirdparty
	newins libmtp.fdi 10-libmtp.fdi

	if use examples; then
		docinto examples
		dodoc examples/*.{c,h,sh}
	fi
}
