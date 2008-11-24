# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/stepmania/stepmania-3.9.ebuild,v 1.17 2008/11/24 16:48:22 ssuominen Exp $

inherit autotools eutils games

MY_PV=${PV/_/-}

DESCRIPTION="An advanced DDR simulator"
HOMEPAGE="http://www.stepmania.com/stepmania/"
SRC_URI="mirror://sourceforge/stepmania/StepMania-${MY_PV}-src.tar.gz
	mirror://sourceforge/stepmania/StepMania-${MY_PV}-linux.tar.gz
	mirror://gentoo/${PN}-patches-3.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug gtk jpeg mad ffmpeg vorbis force-oss"

RESTRICT="test"

RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
	mad? ( media-libs/libmad )
	>=dev-lang/lua-5
	media-libs/libsdl
	jpeg? ( media-libs/jpeg )
	media-libs/libpng
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20080326 )
	vorbis? ( media-libs/libvorbis )
	virtual/opengl
	virtual/glu"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

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
		"${FILESDIR}"/${P}-gentoo.patch > "${T}"/gentoo.patch

	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patches
	epatch "${T}"/gentoo.patch

	epatch "${FILESDIR}/${P}-newffmpeg.diff"
	epatch "${FILESDIR}/${P}-newerffmpeg.diff" #Bug 242054

	AT_M4DIR="autoconf/m4"
	eautoreconf
}

src_compile() {
	econf --disable-dependency-tracking \
		$(use_with debug) \
		$(use_with jpeg) \
		$(use_with vorbis) \
		$(use_with mad mp3) \
		$(use_enable gtk gtk2) \
		$(use_enable force-oss)
	emake || die "emake failed."
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
