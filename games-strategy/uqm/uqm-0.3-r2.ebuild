# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/uqm/uqm-0.3-r2.ebuild,v 1.4 2004/11/24 21:40:47 josejx Exp $

inherit games

DESCRIPTION="The Ur-Quan Masters: Port of Star Control 2"
HOMEPAGE="http://sc2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sc2/${P}-3domusic.zip
	mirror://sourceforge/sc2/${P}-content.zip
	mirror://sourceforge/sc2/${P}-voice.zip
	mirror://sourceforge/sc2/${P}-source.tgz
	mirror://sourceforge/sc2/${PN}-remix-pack1.zip
	mirror://sourceforge/sc2/${PN}-remix-pack2.zip"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
IUSE="opengl"
SLOT="0"

RDEPEND="virtual/libc
	virtual/x11
	media-libs/libvorbis
	media-libs/jpeg
	media-libs/libpng
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-image-1.2.3
	media-libs/libogg
	media-libs/libvorbis
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-apps/coreutils
	app-arch/unzip"

src_unpack() {
	local myopengl

	unpack ${P}-source.tgz
	cd ${S}

	use opengl \
		&& myopengl=opengl \
		|| myopengl=pure

	cat <<-EOF > config.state
	CHOICE_debug_VALUE='nodebug'
	CHOICE_graphics_VALUE='${myopengl}'
	CHOICE_sound_VALUE='mixsdl'
	INPUT_install_prefix_VALUE='${GAMES_PREFIX}'
	INPUT_install_bindir_VALUE='\$prefix/bin'
	INPUT_install_libdir_VALUE='\$prefix/lib'
	EOF

	# Take out the read so we can be non-interactive.
	sed -i \
		-e '/read CHOICE/d' build/unix/menu_functions || \
		die "sed menu_functions failed"

	# support the user's CFLAGS.
	sed -i \
		-e "s/-O3/${CFLAGS}/" build/unix/build.config || \
		die "sed build.config failed"
	cat > ${T}/uqm <<-EOF
	#!/bin/sh
	# Wrapper script for starting The Ur-Quan Masters
	exec /usr/games/lib/uqm/uqm --contentdir="${GAMES_DATADIR}/${PN}/content" "\$@"
EOF
}

src_compile() {
	./build.sh uqm || die
}

src_install() {
	# Using the included install scripts seems quite painful.
	# This manual install is totally fragile but maybe they'll
	# use a sane build system.
	dogamesbin "${T}/uqm" || die "dogamesbin failed"
	exeinto "${GAMES_LIBDIR}/${PN}"
	doexe uqm || die "doexe failed"

	dodir "${GAMES_DATADIR}/${PN}/content/packages/content"
	cp content/version "${D}${GAMES_DATADIR}/${PN}/content" \
		|| die "cp version failed"
	cp ${DISTDIR}/${P}-{3domusic,content,voice}.zip \
		"${D}${GAMES_DATADIR}/${PN}/content/packages" \
			|| die "cp media archives failed"

	dodir "${GAMES_DATADIR}/${PN}/content/packages/addons/uqmremix"
	cp ${DISTDIR}/${PN}-remix-pack{1,2}.zip \
		"${D}${GAMES_DATADIR}/${PN}/content/packages/addons/uqmremix" \
			|| die "cp media archives addons failed"

	dodoc AUTHORS ChangeLog Contributing README TODO WhatsNew \
		doc/users/manual.txt
	docinto devel
	dodoc doc/devel/*

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "To hear all the remixed music made by the The Ur-Quan Masters"
	einfo "project's Precursors Team instead of the original ones,"
	einfo "start the game with:"
	einfo
	einfo "    --addon uqmremix"
	einfo
	echo
}
