# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/uqm/uqm-0.5.0.ebuild,v 1.3 2006/12/12 17:23:48 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="The Ur-Quan Masters: Port of Star Control 2"
HOMEPAGE="http://sc2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sc2/${P}-source.tar.gz
	mirror://sourceforge/sc2/${P}-content.uqm
	music? ( mirror://sourceforge/sc2/${P}-3domusic.uqm )
	voice? ( mirror://sourceforge/sc2/${P}-voice.uqm )
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
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-image-1.2.3
	media-libs/libogg
	media-libs/libvorbis
	sys-libs/zlib"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	local myopengl

	unpack ${P}-source.tar.gz
	cd "${S}"

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
	doexe uqm || die "doexe failed"

	insinto "${GAMES_DATADIR}/${PN}/content/packages"
	doins "${DISTDIR}"/${P}-content.uqm || die "doins failed"
	echo ${P} > "${D}${GAMES_DATADIR}"/${PN}/content/version \
		|| die "creating version file failed"

	insinto "${GAMES_DATADIR}/${PN}/content/packages"
	if use music; then
		doins "${DISTDIR}"/${P}-3domusic.uqm || die "doins failed"
	fi

	if use voice; then
		doins "${DISTDIR}"/${P}-voice.uqm || die "doins failed"
	fi

	if use remix; then
		insinto "${GAMES_DATADIR}"/${PN}/content/packages/addons/uqmremix
		doins "${DISTDIR}"/${PN}-remix-pack{1,2,3}.zip || die "doins failed"
	fi

	dodoc AUTHORS ChangeLog Contributing README TODO WhatsNew \
		doc/users/manual.txt
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
