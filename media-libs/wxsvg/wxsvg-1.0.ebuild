# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/wxsvg/wxsvg-1.0.ebuild,v 1.4 2009/08/17 14:23:41 ssuominen Exp $

EAPI=2
WX_GTK_VER="2.8"
inherit autotools wxwidgets

DESCRIPTION="C++ library to create, manipulate and render SVG files."
HOMEPAGE="http://wxsvg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="ffmpeg"

RDEPEND="=x11-libs/wxGTK-2.8*
	>=dev-libs/glib-2.12
	>=dev-libs/libxml2-2.6.26
	>=media-libs/fontconfig-2.4
	>=media-libs/freetype-2.2.0
	>=media-libs/libart_lgpl-2.3.17
	>=x11-libs/pango-1.14.9
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20080326 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	AT_M4DIR="${S}" eautoreconf
}

src_configure() {
	econf \
		--with-wx-config="${WXCONFIG}"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog TODO
}
