# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libsyncml/libsyncml-0.4.2.ebuild,v 1.1 2006/11/13 22:02:11 peper Exp $

DESCRIPTION="Implementation of the SyncML protocol"
HOMEPAGE="http://libsyncml.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="bluetooth debug doc http obex"
#test

RDEPEND=">=dev-libs/glib-2.0
	>=dev-libs/libwbxml-0.9.2
	dev-libs/libxml2
	http? ( >=net-libs/libsoup-2.2.91 )
	obex? ( >=dev-libs/openobex-1.1 )
	bluetooth? ( net-wireless/bluez-libs )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"
	#test? ( dev-libs/check )

# Some of the tests are broken
RESTRICT="test"

src_compile() {
	econf \
		$(use_enable bluetooth) \
		$(use_enable obex) \
		$(use_enable http) \
		$(use_enable debug) \
		$(use_enable debug tracing) \
		--disable-unit-tests \
		|| die "econf failed"
		#$(use_enable test unit-tests) \

	emake || die "emake failed"

	use doc && doxygen Doxyfile
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README

	use doc && dohtml docs/html/*
}
