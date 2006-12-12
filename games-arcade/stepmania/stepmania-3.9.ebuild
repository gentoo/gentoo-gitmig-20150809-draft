# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/stepmania/stepmania-3.9.ebuild,v 1.8 2006/12/12 17:51:33 wolf31o2 Exp $

WANT_AUTOCONF=latest
inherit eutils autotools games

MY_PV="${PV/_/-}"
DESCRIPTION="An advanced DDR simulator"
HOMEPAGE="http://www.stepmania.com/stepmania/"
SRC_URI="mirror://sourceforge/stepmania/StepMania-${MY_PV}-src.tar.gz
	mirror://sourceforge/stepmania/StepMania-${MY_PV}-linux.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug gtk jpeg mp3 mpeg vorbis force-oss"
RESTRICT="test"

DEPEND="gtk? ( >=x11-libs/gtk+-2.0 )
	mp3? ( media-libs/libmad )
	>=dev-lang/lua-5.0
	media-libs/libsdl
	jpeg? ( media-libs/jpeg )
	media-libs/libpng
	mpeg? ( media-video/ffmpeg )
	vorbis? ( media-libs/libvorbis )
	virtual/opengl
	virtual/glu"

S=${WORKDIR}/StepMania-${MY_PV}-src

pkg_setup() {
	games_pkg_setup
	built_with_use media-libs/libsdl opengl \
		|| die "You need to compile media-libs/libsdl with USE=opengl."
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed "s:/usr/share/games/${PN}:${GAMES_DATADIR}/${PN}:" \
		"${FILESDIR}"/${P}-gentoo.patch > "${T}"/gentoo.patch \
		|| die "sed failed"
	epatch \
		"${T}"/gentoo.patch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-64bits.patch \
		"${FILESDIR}/${P}"-ffmpeg.patch \
		"${FILESDIR}/${P}"-vorbis.patch \
		"${FILESDIR}/${P}"-sdl.patch \
		"${FILESDIR}/${P}"-alsa.patch \
		"${FILESDIR}/${P}"-alias.patch
	eautoconf
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_with debug) \
		$(use_with jpeg) \
		$(use_with vorbis) \
		$(use_with mp3) \
		$(use_enable gtk gtk2) \
		$(use_enable force-oss) \
		|| die
	emake || die "emake failed"
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}

	exeinto "${dir}"
	doexe src/stepmania || die "doexe failed"
	if use gtk; then
		doexe src/GtkModule.so || die "doexe failed"
	fi

	cd "${WORKDIR}"/StepMania-${MY_PV}

	insinto "${dir}"
	doins -r Announcers BGAnimations CDTitles Characters Courses Data Docs \
		NoteSkins RandomMovies Songs Themes Visualizations || die "doins failed"

	dodoc Copying.txt NEWS README-FIRST.html

	make_desktop_entry ${PN} Stepmania
	newicon "Themes/default/Graphics/Common window icon.png" ${PN}.png

	games_make_wrapper ${PN} "${dir}"/${PN} "${dir}"

	prepgamesdirs
}
