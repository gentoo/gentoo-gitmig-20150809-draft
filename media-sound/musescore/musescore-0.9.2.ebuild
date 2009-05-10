# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musescore/musescore-0.9.2.ebuild,v 1.3 2009/05/10 08:03:42 ssuominen Exp $

EAPI=2
inherit cmake-utils eutils font

MY_P=mscore-${PV}

DESCRIPTION="WYSIWYG Music Score Typesetter"
HOMEPAGE="http://mscore.sourceforge.net"
SRC_URI="mirror://sourceforge/mscore/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="sys-libs/zlib
	media-libs/alsa-lib
	media-sound/fluidsynth
	media-sound/jack-audio-connection-kit
	media-libs/portaudio
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	x11-libs/qt-qt3support:4"
DEPEND="${RDEPEND}
	|| ( dev-texlive/texlive-context app-text/tetex )
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}/mscore
VARTEXFONTS=${T}/fonts
FONT_SUFFIX=otf
FONT_S=${S}/mscore/fonts
MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	epatch "${FILESDIR}"/${P}-install.patch
}

src_install() {
	cmake-utils_src_install
	font_src_install
	dodoc ChangeLog NEWS README
	doman packaging/mscore.1
}
