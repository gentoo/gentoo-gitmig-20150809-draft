# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv2/wv2-0.0.9.ebuild,v 1.8 2004/07/14 02:28:44 agriffis Exp $


DESCRIPTION="Excellent MS Word filter lib, used in most Office suites"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.bz2"
HOMEPAGE="http://wvware.sourceforge.net/"

KEYWORDS="x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=gnome-extra/libgsf-1.7.2
	>=media-libs/freetype-2.1
	sys-libs/zlib
	media-libs/libpng"

RDEPEND="$DEPEND media-gfx/imagemagick"

src_compile() {

	econf || die

	make || die
}

src_install () {

	einstall || die

}
