# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/stepmania/stepmania-3.9.ebuild,v 1.1 2006/04/26 22:42:07 tupone Exp $

inherit eutils games

IUSE="debug gtk jpeg mp3 mpeg vorbis force-oss"

MY_PV="${PV/_/-}"
S="${WORKDIR}/StepMania-${MY_PV}-src"
SMDATA="${WORKDIR}/StepMania-${MY_PV}"
DESCRIPTION="An advanced DDR simulator"
HOMEPAGE="http://www.stepmania.com/stepmania/"
SRC_URI="mirror://sourceforge/stepmania/StepMania-${MY_PV}-src.tar.gz
	mirror://sourceforge/stepmania/StepMania-${MY_PV}-linux.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="gtk? ( >=x11-libs/gtk+-2.0 )
	mp3? ( media-libs/libmad )
	>=dev-lang/lua-5.0
	media-libs/libsdl
	jpeg? ( media-libs/jpeg )
	media-libs/libpng
	sys-libs/zlib
	mpeg? ( media-video/ffmpeg )
	vorbis? ( media-libs/libvorbis )
	virtual/opengl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gentoo.patch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-ffmpeg.patch \
		"${FILESDIR}/${P}"-alsa.patch
}

src_compile() {
	econf \
		$(use_with debug) \
		$(use_with jpeg) \
		$(use_with vorbis) \
		$(use_with mp3) \
		$(use_enable gtk gtk2) \
		$(use_enable force-oss) \
		|| die "Configure failed"

	emake || die "Make failed"
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}

	dodir ${dir}
	exeinto ${dir}
	doexe src/stepmania || die "Install failed"
	if use gtk; then
		doexe src/GtkModule.so || die "Install failed"
	fi

	insinto ${dir}

	cd ${SMDATA}
	doins Copying.txt NEWS README-FIRST.html || die "Install failed"
	cp -r Announcers BGAnimations CDTitles Characters Courses Data Docs \
		NoteSkins RandomMovies Songs Themes Visualizations ${D}/${dir} || die "Install failed"

	make_desktop_entry stepmania Stepmania stepmania.png
	newicon Themes/default/Graphics/Common\ window\ icon.png stepmania.png

	games_make_wrapper stepmania ${dir}/stepmania ${dir}

	prepgamesdirs
}
