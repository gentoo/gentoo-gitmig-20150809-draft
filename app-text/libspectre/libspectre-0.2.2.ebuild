# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libspectre/libspectre-0.2.2.ebuild,v 1.10 2010/07/27 01:26:40 jer Exp $

inherit libtool

DESCRIPTION="Library to render Postscript documents."
HOMEPAGE="http://libspectre.freedesktop.org/wiki/"
SRC_URI="http://libspectre.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
IUSE="debug doc test"

RDEPEND=">=app-text/ghostscript-gpl-8.61-r1"
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
		$(use_enable test testing) \
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
