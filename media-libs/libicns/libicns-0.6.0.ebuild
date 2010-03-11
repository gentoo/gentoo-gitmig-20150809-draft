# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libicns/libicns-0.6.0.ebuild,v 1.3 2010/03/11 09:52:02 ssuominen Exp $

EAPI=2

DESCRIPTION="A library for the translation of the icns format"
HOMEPAGE="http://sourceforge.net/projects/icns"
SRC_URI="mirror://sourceforge/icns/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libpng
	media-libs/jasper"

src_prepare() {
	sed -i \
		-e 's:png_set_gray_1_2_4_to_8:png_set_expand_gray_1_2_4_to_8:g' \
		icnsutils/png2icns.c || die
}

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog DEVNOTES README TODO
}
