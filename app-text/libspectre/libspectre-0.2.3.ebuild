# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libspectre/libspectre-0.2.3.ebuild,v 1.1 2009/11/03 18:36:47 tgurr Exp $

inherit libtool

DESCRIPTION="Library to render Postscript documents."
HOMEPAGE="http://libspectre.freedesktop.org/wiki/"
SRC_URI="http://libspectre.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
IUSE="debug doc test"

RDEPEND=">=app-text/ghostscript-gpl-8.62"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	test? ( x11-libs/cairo
		dev-util/pkgconfig )"

src_unpack() {
	unpack ${A}
	elibtoolize
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable debug asserts) \
		$(use_enable debug checks) \
		$(use_enable test) \
		|| die "econf failed"

	emake || die "emake failed"

	if use doc; then
		doxygen || die "doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc NEWS README TODO || die "installing docs failed"
	if use doc; then
		dohtml -r "${S}"/doc/html/*
	fi
}
