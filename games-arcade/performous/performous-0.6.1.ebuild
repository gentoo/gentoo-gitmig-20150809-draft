# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/performous/performous-0.6.1.ebuild,v 1.3 2012/03/05 08:07:59 tupone Exp $

EAPI=3

inherit flag-o-matic base cmake-utils games

MY_PN=Performous
MY_P=${MY_PN}-${PV}
SONGS_PN=ultrastar-songs

DESCRIPTION="SingStar GPL clone"
HOMEPAGE="http://sourceforge.net/projects/performous/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-Source.tar.bz2
	songs? (
		mirror://sourceforge/${PN}/${SONGS_PN}-restricted-3.zip
		mirror://sourceforge/${PN}/${SONGS_PN}-jc-1.zip
		mirror://sourceforge/${PN}/${SONGS_PN}-libre-3.zip
		mirror://sourceforge/${PN}/${SONGS_PN}-shearer-1.zip
	)"

LICENSE="GPL-2
	songs? (
		CCPL-Attribution-ShareAlike-NonCommercial-2.5
		CCPL-Attribution-NonCommercial-NoDerivs-2.5
	)"
SLOT="0"
KEYWORDS="~x86"
IUSE="songs tools"
LANGS="da de es fi fr hu it ja nl sv"
for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND="dev-cpp/glibmm
	dev-cpp/libxmlpp
	media-libs/portaudio
	dev-libs/boost
	dev-libs/glib
	dev-libs/libxml2
	gnome-base/librsvg
	media-gfx/imagemagick
	virtual/jpeg
	media-libs/libpng
	media-libs/libsdl
	virtual/opengl
	virtual/glu
	media-video/ffmpeg
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
	!games-arcade/ultrastar-ng"
DEPEND="${RDEPEND}
	media-libs/glew
	sys-apps/help2man"

S="${WORKDIR}"/${MY_P}-Source

PATCHES=(
	"${FILESDIR}"/${P}-ffmpeg.patch
	"${FILESDIR}"/${P}-libpng.patch
	"${FILESDIR}"/${P}-gentoo.patch
)
append-cppflags -DBOOST_FILESYSTEM_VERSION=2

src_prepare() {
	base_src_prepare
	sed -i \
		-e "s:@GENTOO_BINDIR@:${GAMES_BINDIR}:" \
		game/CMakeLists.txt \
		|| die "sed failed"
	cd lang
	for X in $LANGS
	do
		use linguas_$X || rm $X.po
	done
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable tools TOOLS)
		-DSHARE_INSTALL="${GAMES_DATADIR}"/${PN}
	"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	if use songs; then
		insinto "${GAMES_DATADIR}"/${PN}
		doins -r "${S}/songs" || die "doins failed"
	fi
	cd docs
	dodoc {Authors,DeveloperReadme,instruments,TODO}.txt \
		|| die "dodoc failed"
	prepgamesdirs
}
