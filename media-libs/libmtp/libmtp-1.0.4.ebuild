# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmtp/libmtp-1.0.4.ebuild,v 1.1 2011/01/10 03:10:00 ken69267 Exp $

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
	epatch "${FILESDIR}"/hotplug-permissions-"${PV}".patch
	sed -i -e "s:install-pkgconfigDATA install-udevrulesDATA:install-pkgconfigDATA:" \
		Makefile.in || die "sed failed"
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
