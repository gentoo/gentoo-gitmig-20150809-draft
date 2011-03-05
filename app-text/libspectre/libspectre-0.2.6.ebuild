# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libspectre/libspectre-0.2.6.ebuild,v 1.8 2011/03/05 01:01:19 ranger Exp $

EAPI=3

inherit autotools eutils

DESCRIPTION="Library to render Postscript documents."
HOMEPAGE="http://libspectre.freedesktop.org/wiki/"
SRC_URI="http://libspectre.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris"
SLOT="0"
IUSE="debug doc static-libs test"

RDEPEND=">=app-text/ghostscript-gpl-8.62"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )
	test? ( x11-libs/cairo )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.2.0-interix.patch
	eautoreconf # need new libtool for interix
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable debug asserts) \
		$(use_enable debug checks) \
		$(use_enable static-libs static) \
		$(use_enable test)
}

src_compile() {
	emake || die "emake failed"

	if use doc; then
		doxygen || die "doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc NEWS README TODO || die "installing docs failed"
	if use doc; then
		dohtml -r "${S}"/doc/html/* || die "dohtml failed"
	fi
}
