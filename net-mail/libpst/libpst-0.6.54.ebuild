# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/libpst/libpst-0.6.54.ebuild,v 1.1 2012/01/01 01:51:12 radhermit Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Tools and library for reading Outlook files (.pst format)"
HOMEPAGE="http://www.five-ten-sg.com/libpst/"
SRC_URI="http://www.five-ten-sg.com/${PN}/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug dii doc python static-libs"

RDEPEND="dii? ( media-gfx/imagemagick[png] )"
DEPEND="${RDEPEND}
	virtual/libiconv
	dii? ( media-libs/gd[png] )
	python? ( >=dev-libs/boost-1.35.0-r5[python] )"

src_prepare() {
	# Don't build the static python library
	epatch "${FILESDIR}"/${PN}-0.6.52-no-static-python-lib.patch

	# Fix pkgconfig file for static linking
	epatch "${FILESDIR}"/${PN}-0.6.53-pkgconfig-static.patch

	# Conditionally install the extra documentation
	use doc || sed -i -e "/SUBDIRS/s: html::" Makefile.am

	eautomake
}

src_configure() {
	econf \
		--enable-libpst-shared \
		$(use_enable debug pst-debug) \
		$(use_enable dii) \
		$(use_enable python) \
		$(use_enable static-libs static)
}

src_install() {
	default

	# Remove useless .la files
	find "${ED}" -name '*.la' -exec rm {} +
}
