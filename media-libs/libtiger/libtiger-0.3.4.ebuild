# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libtiger/libtiger-0.3.4.ebuild,v 1.2 2012/01/04 18:10:58 ago Exp $

EAPI=2

inherit libtool

DESCRIPTION="A rendering library for Kate streams using Pango and Cairo"
HOMEPAGE="http://code.google.com/p/libtiger/"
SRC_URI="http://libtiger.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND="x11-libs/pango
	>=media-libs/libkate-0.2.0
	x11-libs/cairo"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	elibtoolize
}

src_configure() {
	econf $(use_enable doc) --docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc THANKS README ChangeLog AUTHORS || die
	find "${D}" -name '*.la' -delete
}
