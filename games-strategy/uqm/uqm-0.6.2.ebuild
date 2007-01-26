# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/uqm/uqm-0.6.2.ebuild,v 1.1 2007/01/26 04:02:30 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="The Ur-Quan Masters: Port of Star Control 2"
HOMEPAGE="http://sc2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sc2/${P}-source.tgz
	mirror://sourceforge/sc2/${PN}-0.6.0-content.uqm
	music? ( mirror://sourceforge/sc2/${PN}-0.6.0-3domusic.uqm )
	voice? ( mirror://sourceforge/sc2/${PN}-0.6.0-voice.uqm )
	remix? ( mirror://sourceforge/sc2/${PN}-remix-pack1.zip \
		mirror://sourceforge/sc2/${PN}-remix-pack2.zip \
		mirror://sourceforge/sc2/${PN}-remix-pack3.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="music opengl remix voice"

RDEPEND="media-libs/libvorbis
	media-libs/jpeg
	media-libs/libpng
	>=media-libs/libsdl-1.2.8
	>=media-libs/sdl-image-1.2.4
	media-libs/libogg
	media-libs/libvorbis
	sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	local myopengl

	unpack ${P}-source.tgz
	cd "${S}"

	# Because the new 0.6.* source archives have
	# everything in a subdir called "sc2". This,
	# I have found, is the simplest way to get
	# around that problem. (That doesn't change
	# the fact that the rest of this ebuild is
	# very nasty. I was not able to clean it up.)
	mv ./sc2/* ./

	use opengl \
		&& myopengl=opengl \
		|| myopengl=pure

	cat <<-EOF > config.state
	CHOICE_debug_VALUE='nodebug'
	CHOICE_graphics_VALUE='${myopengl}'
	CHOICE_sound_VALUE='mixsdl'
	CHOICE_accel_VALUE='plainc'
	INPUT_install_prefix_VALUE='${GAMES_PREFIX}'
	INPUT_install_bindir_VALUE='\$prefix/bin'
	INPUT_install_libdir_VALUE='\$prefix/lib'
	INPUT_install_sharedir_VALUE='${GAMES_DATADIR}/'
	EOF

	# Take out the read so we can be non-interactive.
	sed -i \
		-e '/read CHOICE/d' build/unix/menu_functions \
		|| die "sed menu_functions failed"

	# support the user's CFLAGS.
	sed -i \
		-e "s/-O3/${CFLAGS}/" build/unix/build.config \
		|| die "sed build.config failed"
}

src_compile() {
	./build.sh uqm || die "build failed"
}

src_install() {
	# Using the included install scripts seems quite painful.
	# This manual install is totally fragile but maybe they'll
	# use a sane build system for the next release.
	newgamesbin uqm-wrapper uqm || die "newgamesbin failed"
	exeinto "${GAMES_LIBDIR}/${PN}"
	echo "${GAMES_LIBDIR}/${PN}"
	ls "${GAMES_LIBDIR}/${PN}"
	doexe uqm || die "doexe failed"

	insinto "${GAMES_DATADIR}/${PN}/content/packages"
	doins "${DISTDIR}"/${PN}-0.6.0-content.uqm || die "doins failed"
	echo ${P} > "${D}${GAMES_DATADIR}"/${PN}/content/version \
		|| die "creating version file failed"

	insinto "${GAMES_DATADIR}/${PN}/content/packages"
	if use music; then
		doins "${DISTDIR}"/${PN}-0.6.0-3domusic.uqm || die "doins failed"
	fi

	if use voice; then
		doins "${DISTDIR}"/${PN}-0.6.0-voice.uqm || die "doins failed"
	fi

	if use remix; then
		insinto "${GAMES_DATADIR}"/${PN}/content/packages/addons/uqmremix
		doins "${DISTDIR}"/${PN}-remix-pack{1,2,3}.zip || die "doins failed"
	fi

	dodoc AUTHORS ChangeLog Contributing README WhatsNew doc/users/manual.txt
	docinto devel
	dodoc doc/devel/*
	make_desktop_entry uqm "The Ur-Quan Masters"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if use remix ; then
		echo
		einfo "To hear all the remixed music made by the The Ur-Quan Masters"
		einfo "project's Precursors Team instead of the original ones,"
		einfo "start the game with:"
		einfo "    --addon uqmremix"
		echo
	fi
}
