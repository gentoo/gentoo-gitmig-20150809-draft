# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/wxsvg/wxsvg-1.0.2-r1.ebuild,v 1.2 2010/07/04 22:15:29 hwoarang Exp $

EAPI=2
WX_GTK_VER="2.8"

inherit autotools eutils wxwidgets

MY_P=${P}_1

DESCRIPTION="C++ library to create, manipulate and render SVG files."
HOMEPAGE="http://wxsvg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND="x11-libs/wxGTK:2.8[X]
	>=dev-libs/expat-2.0.1-r3
	>=dev-libs/glib-2.12
	>=dev-libs/libxml2-2.6.26
	>=media-libs/fontconfig-2.4
	>=media-libs/freetype-2.2.0
	>=media-libs/libart_lgpl-2.3.17
	>=media-video/ffmpeg-0.4.9_p20080326
	>=x11-libs/pango-1.14.9"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-external-expat.patch
	eautoreconf
}

src_configure() {
	econf --with-sys-expat || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog TODO
}
