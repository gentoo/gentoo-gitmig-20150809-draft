# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/uqm/uqm-0.3.ebuild,v 1.4 2004/01/24 14:09:56 mr_bones_ Exp $

inherit games

DESCRIPTION="Port of Star Control 2"
HOMEPAGE="http://sc2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sc2/${P}-3domusic.zip
	mirror://sourceforge/sc2/${P}-content.zip
	mirror://sourceforge/sc2/${P}-voice.zip
	mirror://sourceforge/sc2/${P}-source.tgz"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
IUSE="opengl"
SLOT="0"

RDEPEND="virtual/glibc
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

	cp ${DISTDIR}/${P}-{3domusic,content,voice}.zip content/packages/ || \
		die "cp media archives failed"

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
}

src_compile() {
	./build.sh uqm || die
}

src_install() {
	# Now that we've compiled in the right thing, change the variables
	# so it installs in the right place.
	sed -i \
		-e "s:${GAMES_PREFIX}:${D}${GAMES_PREFIX}:" build.vars || \
			die "sed build.vars failed"
	./build.sh uqm install || die "build.sh install failed"

	dodoc AUTHORS ChangeLog Contributing README TODO WhatsNew \
		doc/users/manual.txt
	docinto devel
	dodoc doc/devel/*

	prepgamesdirs
}
