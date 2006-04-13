# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/stepmania/stepmania-3.9_rc3.ebuild,v 1.5 2006/04/13 20:14:56 wolf31o2 Exp $

inherit eutils games

IUSE="debug gtk jpeg mad mpeg vorbis"

MY_PV="${PV/_/-}"
S="${WORKDIR}/StepMania-${MY_PV}-src"
SMDATA="${WORKDIR}/StepMania-${MY_PV}"
DESCRIPTION="An advanced DDR simulator"
HOMEPAGE="http://www.stepmania.com/stepmania/"
SRC_URI="mirror://sourceforge/stepmania/StepMania-${MY_PV}-src.tar.gz
	mirror://sourceforge/stepmania/StepMania-${MY_PV}-linux.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 ~ppc ~amd64"

DEPEND="gtk? ( >=x11-libs/gtk+-2.0 )
	mad? ( media-libs/libmad )
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
	epatch ${FILESDIR}/stepmania-${MY_PV}-gentoo.patch
	cd ${S}
}

src_compile() {
	local myconf
	use debug && myconf="${myconf} --with-debug"
	use jpeg || myconf="${myconf} --without-jpeg"
	use vorbis || myconf="${myconf} --without-vorbis"
	use mad || myconf="${myconf} --without-mp3"
	use gtk || myconf="${myconf} --disable-gtk2"

	econf ${myconf} || die "Configure failed"

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

	games_make_wrapper stepmania ${dir}/stepmania ${dir}

	prepgamesdirs
}
