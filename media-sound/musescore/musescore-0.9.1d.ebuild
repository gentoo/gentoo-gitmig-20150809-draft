# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musescore/musescore-0.9.1d.ebuild,v 1.1 2008/02/01 14:31:20 drac Exp $

inherit cmake-utils eutils font

MY_P=${P/musescore/mscore}

DESCRIPTION="WYSIWYG Music Score Typesetter"
HOMEPAGE="http://mscore.sourceforge.net"
SRC_URI="mirror://sourceforge/mscore/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="doc jack"

RDEPEND=">=x11-libs/qt-4.3
	media-sound/fluidsynth
	media-libs/alsa-lib
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.6
	dev-util/pkgconfig
	doc? ( virtual/tetex app-doc/doxygen )"

S=${WORKDIR}/${MY_P/d}/mscore

FONT_SUFFIX="otf"
FONT_S="${S}"/mscore/fonts

pkg_setup() {
	local fail="Re-emerge x11-libs/qt with USE qt3support."

	if ! built_with_use ">=x11-libs/qt-4.3" qt3support; then
		eerror "${fail}"
		die "${fail}"
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
