# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fotoxx/fotoxx-11.04.ebuild,v 1.1 2011/04/05 18:54:04 grozin Exp $
EAPI=3
inherit eutils toolchain-funcs

DESCRIPTION="Program for improving image files made with a digital camera."
HOMEPAGE="http://kornelix.squarespace.com/fotoxx"
SRC_URI="http://kornelix.squarespace.com/storage/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:2
	media-libs/tiff"
RDEPEND="${DEPEND}
	media-libs/exiftool
	media-gfx/ufraw
	x11-misc/xdg-utils"

src_prepare() {
	epatch "${FILESDIR}"/${PF}-makefile.patch
}

src_compile() {
	tc-export CXX
	emake PREFIX=/usr || die
}

src_install() {
	pushd doc > /dev/null
	mv ${PN}.man ${PN}.1
	doman ${PN}.1
	rm COPYING ${PN}.1
	bzip2 -9 userguide-changes
	popd > /dev/null
	# For the Help menu items to work, *.html must be in /usr/share/doc/${PF},
	# and README, CHANGES, TRANSLATIONS must not be compressed
	emake DESTDIR="${D}" PREFIX=/usr install || die
	make_desktop_entry ${PN} "Fotoxx" /usr/share/${PN}/icons/${PN}.png \
		"Application;Graphics;2DGraphics"
}
