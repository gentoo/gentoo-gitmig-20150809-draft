# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fotoxx/fotoxx-12.11.ebuild,v 1.3 2012/11/15 15:07:36 grozin Exp $
EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="Program for improving image files made with a digital camera."
HOMEPAGE="http://www.kornelix.com/fotoxx.html"
SRC_URI="http://www.kornelix.com/uploads/1/3/0/3/13035936/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:3
	media-libs/libpng
	media-libs/tiff"
RDEPEND="${DEPEND}
	media-libs/exiftool
	media-gfx/ufraw[gtk]
	x11-misc/xdg-utils"

src_prepare() {
	epatch "${FILESDIR}"/${PF}.patch
}

src_compile() {
	tc-export CXX
	emake
}

src_install() {
	# For the Help menu items to work, *.html must be in /usr/share/doc/${PF},
	# and README, CHANGES, TRANSLATIONS must not be compressed
	emake DESTDIR="${D}" install
	make_desktop_entry ${PN} "Fotoxx" /usr/share/${PN}/icons/${PN}.png \
		"Graphics;2DGraphics"
}
