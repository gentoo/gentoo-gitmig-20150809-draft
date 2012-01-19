# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/focuswriter/focuswriter-1.3.5.2.ebuild,v 1.2 2012/01/19 11:45:17 ssuominen Exp $

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

DEPEND="
	app-text/hunspell
	dev-libs/libzip
	x11-libs/qt-gui:4
	media-libs/sdl-mixer[wav]
	"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog README )

src_prepare() {
	sed -i -e '/PREFIX/s:/usr/local:/usr:' ${PN}.pro || die
	qt4-r2_src_prepare
}
