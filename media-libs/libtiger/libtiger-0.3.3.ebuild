# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libtiger/libtiger-0.3.3.ebuild,v 1.9 2009/09/22 02:10:30 fauli Exp $

EAPI=2

inherit libtool eutils

DESCRIPTION="A rendering library for Kate streams using Pango and Cairo"
HOMEPAGE="http://code.google.com/p/libtiger/"
SRC_URI="http://libtiger.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE="doc"

RDEPEND="x11-libs/pango
	>=media-libs/libkate-0.2.0
	x11-libs/cairo"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}/${P}-check.patch"
	elibtoolize
}

src_configure() {
	econf $(use_enable doc) --docdir=/usr/share/doc/${PF}
}

src_test() {
	LC_ALL=C emake check || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	find "${D}" -name '*.la' -delete
}
