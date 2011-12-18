# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musescore/musescore-0.9.4.ebuild,v 1.4 2011/12/18 18:14:52 armin76 Exp $

EAPI=2
inherit cmake-utils eutils font

MY_P=mscore-${PV}

DESCRIPTION="WYSIWYG Music Score Typesetter"
HOMEPAGE="http://mscore.sourceforge.net"
SRC_URI="mirror://sourceforge/mscore/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/zlib
	media-libs/alsa-lib
	media-sound/fluidsynth
	media-sound/jack-audio-connection-kit
	media-libs/portaudio
	x11-libs/qt-core:4
	x11-libs/qt-script:4
	x11-libs/qt-qt3support:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4"
DEPEND="${RDEPEND}
	dev-texlive/texlive-context
	app-doc/doxygen
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}/mscore
VARTEXFONTS=${T}/fonts
FONT_SUFFIX=ttf
FONT_S=${S}/mscore/fonts
MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	cmake-utils_src_make lupdate
	cmake-utils_src_make lrelease
	cmake-utils_src_make
}

src_install() {
	cmake-utils_src_install
	font_src_install
	dodoc ChangeLog NEWS README
	doman packaging/mscore.1
}
