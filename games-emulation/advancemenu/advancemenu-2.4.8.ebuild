# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/advancemenu/advancemenu-2.4.8.ebuild,v 1.1 2005/04/04 05:38:32 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Frontend for AdvanceMAME, MAME, MESS, RAINE and any other emulator"
HOMEPAGE="http://advancemame.sourceforge.net/menu-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="alsa debug expat fbcon ncurses oss sdl slang static svga truetype zlib"

RDEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )
	expat? ( dev-libs/expat )
	ncurses? ( sys-libs/ncurses )
	sdl? ( media-libs/libsdl )
	slang? ( sys-libs/slang )
	svga? ( >=media-libs/svgalib-1.9 )
	truetype? ( >=media-libs/freetype-2 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	x86? ( >=dev-lang/nasm-0.98 )
	fbcon? ( virtual/os-headers )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use x86 && ln -s $(which nasm) "${T}/${CHOST}-nasm"
	use sdl && ln -s $(which sdl-config) "${T}/${CHOST}-sdl-config"
	use truetype && ln -s $(which freetype-config) "${T}/${CHOST}-freetype-config"
}

src_compile() {
	export PATH="${PATH}:${T}"
	egamesconf \
		$(use_enable alsa) \
		$(use_enable debug) \
		$(use_enable expat) \
		$(use_enable fbcon fb) \
		$(use_enable ncurses) \
		$(use_enable truetype freetype) \
		$(use_enable oss) \
		$(use_enable sdl) \
		$(use_enable slang) \
		$(use_enable static) \
		$(use_enable svga svgalib) \
		$(use_enable x86 asm) \
		$(use_enable zlib) \
		|| die
	emake || die "emake failed"
}

src_install() {
	dogamesbin advmenu advcfg advv || die "dogamesbin failed"
	dodoc HISTORY README RELEASE doc/*.txt
	doman doc/*.1
	dohtml doc/*.html
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Execute:"
	einfo "     advmenu -default"
	einfo "To generate a config file"
	ewarn "In order to use advmenu, you must properly configure it!"
	einfo
	einfo "An example emulator config found in advmenu.rc:"
	einfo "     emulator \"snes9x\" generic \"/usr/games/bin/snes9x\" \"%f\""
	einfo "     emulator_roms \"snes9x\" \"/home/user/myroms\""
	einfo "     emulator_roms_filter \"snes9x\" \"*.smc;*.sfc\""
	einfo
	einfo "For more information, see the advmenu man page."
}
