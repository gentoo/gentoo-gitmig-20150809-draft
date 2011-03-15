# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libticables2/libticables2-1.3.1.ebuild,v 1.1 2011/03/15 21:18:16 bicatali Exp $

EAPI=2
inherit eutils

DESCRIPTION="Library to handle different link cables for TI calculators"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI="mirror://sourceforge/tilp/tilp2-linux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc nls static-libs usb"

RDEPEND="dev-libs/glib:2
	usb? ( dev-libs/libusb )
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_enable usb libusb)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS LOGO NEWS README ChangeLog docs/api.txt
	use doc && dohtml docs/html/*
}

pkg_postinst() {
	elog "Please read README in /usr/share/doc/${PF}"
	elog "if you encounter any problem with a link cable"
}
