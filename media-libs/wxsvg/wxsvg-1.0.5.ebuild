# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/wxsvg/wxsvg-1.0.5.ebuild,v 1.5 2011/08/13 07:43:44 xarthisius Exp $

EAPI=2
WX_GTK_VER="2.8"

inherit wxwidgets

DESCRIPTION="C++ library to create, manipulate and render SVG files."
HOMEPAGE="http://wxsvg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/wxGTK:2.8[X]
	>=dev-libs/expat-2.0.1-r3
	>=dev-libs/glib-2.12
	>=dev-libs/libxml2-2.6.26
	>=media-libs/fontconfig-2.4
	>=media-libs/freetype-2.2.0
	>=media-libs/libart_lgpl-2.3.17
	virtual/ffmpeg
	>=x11-libs/pango-1.14.9"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog TODO
}
