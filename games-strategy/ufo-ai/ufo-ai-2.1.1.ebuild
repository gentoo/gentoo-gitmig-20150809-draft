# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo-ai/ufo-ai-2.1.1.ebuild,v 1.1 2007/08/17 23:33:57 wolf31o2 Exp $

inherit eutils autotools games

MY_PV=${PV/_rc/-RC}
MY_P="ufoai-${MY_PV}"
MY_SF="mirror://sourceforge/ufoai"

DESCRIPTION="UFO: Alien Invasion - X-COM inspired strategy game"
HOMEPAGE="http://www.ufoai.net/"
SRC_URI="${MY_SF}/music.tar.bz2
	${MY_SF}/${MY_P}-data.tar
	${MY_SF}/${MY_P}-source.tar.bz2
	${MY_SF}/${MY_P}-i18n.tar.bz2"
# Map data is already in the main data tarball
# 	${MY_SF}/${MY_P}-mapsource.tar.bz2

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa arts debug dedicated dga doc ipv6 jack master oss paranoid"

# Info at http://ufoai.ninex.info/wiki/index.php/Compile_for_Linux
UIRDEPEND="virtual/opengl
	virtual/glu
	>=media-libs/libsdl-1.2.7
	>=media-libs/sdl-ttf-2.0.7
	dga? ( x11-libs/libXxf86dga )
	x11-libs/libX11"
UIDEPEND="x11-proto/xf86vidmodeproto
	x11-proto/xproto"
RDEPEND="${UIRDEPEND}
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	>=media-libs/jpeg-6b-r7
	media-libs/libpng
	>=media-libs/libogg-1.1
	>=media-libs/libvorbis-1.1
	jack? ( >=media-sound/jack-0.100.0 )
	sys-devel/gettext
	>=sys-libs/glibc-2.4
	>=sys-libs/zlib-1.2.3"
DEPEND="${RDEPEND}
	${UIDEPEND}
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${MY_P}-source
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	local libdir=$(games_get_libdir)/${PN}
	# Set libdir
	sed -i \
		-e "s:libPath, \"\.\":libPath, \"${libdir}\":" \
		src/{client,ports/linux}/*.c || die "sed *.c failed"

	sed -i \
		-e "s:\"s_libdir\", \"\":\"s_libdir\", \"${libdir}\":" \
		src/client/snd_ref.c || die "sed snd_ref.c failed"

	sed -i \
		-e "s:game\.so\", path:game\.so\", \"${libdir}\":" \
		src/ports/linux/sys_linux.c || die "sed sys_linux.c failed"

	# Set basedir
	sed -i \
		-e "s:\"fs_basedir\", \"\.\":\"fs_basedir\", \"${dir}\":" \
		src/qcommon/files.c || die "sed files.c failed"

	sed -i \
		-e "s:/usr/local/games/ufoai:${dir}:" \
		src/tools/gtkradiant/games/ufoai.game || die "sed ufoai.game failed"

	# Fixes bug in finding text files - it should use fs_basedir
	sed -i \
		-e "s:FS_GetCwd():\"${dir}\":" \
		src/qcommon/common.c || die "sed common.c failed"

	eautoreconf
}

src_compile() {
	yesno() { useq $1 && echo yes || echo no ; }

# Forces building of client.
# gettext is required to show the intro text.
# egamesconf fails with openal.
#		$(use_with openal)
	egamesconf \
		$(use_enable dedicated) \
		$(use_enable master) \
		$(use_enable !debug release) \
		$(use_enable paranoid) \
		--with-vid-glx \
		--with-vid-vidmode \
		--with-sdl \
		--with-snd-sdl \
		$(use_with alsa snd-alsa) \
		$(use_with arts snd-arts) \
		$(use_with jack snd-jack) \
		$(use_with oss snd-oss) \
		$(use_with dga vid-dga) \
		$(use_with ipv6) \
		--with-gettext \
		--without-openal \
		|| die "egamesconf failed"

	emake || die "emake failed"

	if use doc ; then
		emake docs || die "emake docs failed"
	fi
}

src_install() {
	# ufo is usually started by a "ufoai" wrapper script.
	# Might as well standardize on the ebuild name, for minimum confusion.
	newgamesbin ufo ${PN} || die
	newicon src/ports/linux/installer/data/ufo.xpm ${PN}.xpm || die
	make_desktop_entry ${PN} "UFO: Alien Invasion" ${PN}.xpm

	if use dedicated ; then
		dogamesbin ufoded || die
	fi

	if use master ; then
		dogamesbin ufomaster || die
	fi

	if [[ -f ufo2map ]] ; then
		dogamesbin ufo2map || die
	fi

	local libdir=$(games_get_libdir)/${PN}
	exeinto "${libdir}"
	local f
	for f in *.so base/game.so ; do
		doexe "${f}" || die "doexe ${f} failed"
	done

	insinto "${dir}"
	doins -r "${WORKDIR}"/{base,music} \
		|| die "doins -r failed"

	if use doc ; then
		dohtml -r "${WORKDIR}"/docs/html/*
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "To play the game, run:  ${PN}"
	echo
}
