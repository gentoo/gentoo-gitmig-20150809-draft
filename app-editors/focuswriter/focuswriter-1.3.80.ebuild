# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/focuswriter/focuswriter-1.3.80.ebuild,v 1.1 2012/08/14 07:58:11 pesa Exp $

EAPI=4

#does nothing useful, LANGS="cs de el en es_MX es fi fr hu it nl pl pt_BR pt ru sv uk"

inherit qt4-r2

DESCRIPTION="A fullscreen and distraction-free word processor"
HOMEPAGE="http://gottcode.org/focuswriter/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	app-text/enchant
	dev-libs/libzip
	media-libs/sdl-mixer[wav]
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

DOCS=( ChangeLog CREDITS README )

src_configure() {
	eqmake4 PREFIX="${EPREFIX}/usr"
}
