# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/atari800/atari800-1.3.2.ebuild,v 1.1 2003/12/30 19:09:11 mr_bones_ Exp $

inherit games

DESCRIPTION="Atari 800 emulator"
HOMEPAGE="http://atari800.sourceforge.net/"
SRC_URI="mirror://sourceforge/atari800/${P}.tar.gz
	mirror://sourceforge/atari800/xf25.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE="sdl"

RDEPEND="virtual/x11
	sdl? ( >=media-libs/libsdl-1.2.0 )"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove some not-so-interesting ones
	rm -f DOC/{INSTALL.*,*.in,CHANGES.OLD}
}

src_compile() {
	local target="x11"
	use sdl && target="sdl"

	cd src && \
	egamesconf \
		--enable-crashmenu \
		--enable-break \
		--enable-hints \
		--enable-asm \
		--enable-cursorblk \
		--enable-led \
		--enable-displayled \
		--enable-sndclip \
		--enable-linuxjoy \
		--enable-sound \
		--target=${target} \
		|| die
	emake || die "emake failed"
}

src_install () {
	dogamesbin src/atari800            || die "dogamesbin failed"
	newman src/atari800.man atari800.6 || die "newman failed"
	dodoc README.1ST DOC/*             || die "dodoc failed"
	insinto ${GAMES_DATADIR}/${PN}
	doins ${WORKDIR}/*.ROM             || die "doins failed (ROM)"
	insinto /etc
	doins ${FILESDIR}/atari800.cfg     || die "doins failed (cfg)"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if [ `use sdl` ] ; then
		echo
		echo
		einfo 'The emulator has been compiled using the SDL libraries.  By default,'
		einfo 'atari800 switches to fullscreen mode, so a 400x300 entry in your'
		einfo 'XF86Config-4 file is recommended.  Otherwise, the emulated Atari'
		einfo 'screen is postage-stamp sized in the middle of your display.'
		echo
		einfo 'For example, in the "Screen" section of your /etc/XF86Config-4 file,'
		einfo 'add the entry "400x300" to the end of the list of modes:'
		echo
		einfo '  Section "Screen"'
		einfo '    [...]'
		einfo
		einfo '      Subsection "Display"'
		einfo '          Depth       16'
		einfo '          Modes       "1600x1200" "1024x768" "400x300"'
		einfo '          ViewPort    0 0'
		einfo '      EndSubsection'
		einfo '  EndSection'
		echo
		einfo 'You should not need to specify a modeline for this mode,'
		einfo 'since in most cases it is a standard mode calculated by'
		einfo 'the X server.'
		echo
		echo
		echo
	fi
}
