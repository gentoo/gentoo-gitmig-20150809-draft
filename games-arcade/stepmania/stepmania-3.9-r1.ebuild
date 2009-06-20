# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/stepmania/stepmania-3.9-r1.ebuild,v 1.1 2009/06/20 23:05:23 ssuominen Exp $

EAPI=2
inherit autotools eutils games

MY_P=StepMania-${PV}
DESCRIPTION="An advanced DDR simulator"
HOMEPAGE="http://www.stepmania.com/stepmania/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.gz
	mirror://sourceforge/${PN}/${MY_P}-linux.tar.gz
	http://dev.gentoo.org/~ssuominen/distfiles/${P}-patches-4.tar.gz
	mirror://gentoo/${P}-patches-4.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug ffmpeg force-oss gtk jpeg mad vorbis"

RESTRICT="test"

RDEPEND="gtk? ( x11-libs/gtk+:2 )
	mad? ( media-libs/libmad )
	>=dev-lang/lua-5
	media-libs/libsdl[joystick,opengl]
	jpeg? ( media-libs/jpeg )
	media-libs/libpng
	ffmpeg? ( >=media-video/ffmpeg-0.5 )
	vorbis? ( media-libs/libvorbis )
	virtual/opengl
	virtual/glu"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}-src

src_prepare() {
	sed "s:/usr/share/games/${PN}:${GAMES_DATADIR}/${PN}:" \
		"${FILESDIR}"/${P}-gentoo.patch > "${T}"/${P}.patch

	EPATCH_SUFFIX=patch epatch "${T}"/${P}.patch "${WORKDIR}"/patches
	AT_M4DIR=autoconf/m4 eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_with debug) \
		$(use_with jpeg) \
		$(use_with vorbis) \
		$(use_with mad mp3) \
		$(use_enable gtk gtk2) \
		$(use_enable force-oss)
}

src_install() {
	local dir=${GAMES_DATADIR}/${PN}

	exeinto "${dir}"
	doexe src/stepmania || die "doexe failed"

	if use gtk; then
		doexe src/GtkModule.so || die "doexe failed"
	fi

	cd "${WORKDIR}"/${MY_P}

	insinto "${dir}"
	doins -r Announcers BGAnimations CDTitles Characters Courses Data Docs \
		NoteSkins RandomMovies Songs Themes Visualizations || die "doins failed"

	dodoc Copying.txt NEWS
	dohtml README-FIRST.html

	newicon "Themes/default/Graphics/Common window icon.png" ${PN}.png
	make_desktop_entry ${PN} StepMania

	games_make_wrapper ${PN} "${dir}"/${PN} "${dir}"
	prepgamesdirs
}
