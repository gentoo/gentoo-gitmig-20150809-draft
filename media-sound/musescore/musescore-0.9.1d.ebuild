# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musescore/musescore-0.9.1d.ebuild,v 1.4 2008/04/14 21:48:03 drac Exp $

EAPI=1

inherit cmake-utils eutils font

MY_P=${P/musescore/mscore}

DESCRIPTION="WYSIWYG Music Score Typesetter"
HOMEPAGE="http://mscore.sourceforge.net"
SRC_URI="mirror://sourceforge/mscore/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="doc"

RDEPEND="media-libs/alsa-lib
	media-sound/fluidsynth
	media-sound/jack-audio-connection-kit
	|| ( ( x11-libs/qt-gui:4 x11-libs/qt-svg:4
		x11-libs/qt-qt3support:4 )
		>=x11-libs/qt-4.3:4 )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.6
	dev-util/pkgconfig
	doc? ( virtual/tetex app-doc/doxygen )"

S=${WORKDIR}/${MY_P/d}/mscore

FONT_SUFFIX=otf
FONT_S=${S}/mscore/fonts

pkg_setup() {
	# fixme. we need some checking also for split pkgs.
	if has_version "=x11-libs/qt-4.3*"; then
		local fail="Re-emerge =x11-libs/qt-4.3* with USE accessibility and qt3support."
		built_with_use x11-libs/qt qt3support || die "${fail}"
		built_with_use x11-libs/qt accessibility || die "${fail}"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-desktop-entry.patch
}

src_install() {
	cmake-utils_src_install
	font_src_install
	dodoc ChangeLog NEWS README doc/README*
	domenu packaging/mscore.desktop
}
