# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

inherit games eutils

DESCRIPTION="Frontend for AdvanceMAME, MAME, MESS, RAINE and any other emulator"
HOMEPAGE="http://advancemame.sourceforge.net/menu-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="debug static svga alsa oss slang sdl"

RDEPEND="virtual/glibc
	games-emulation/advancemame
	sys-libs/zlib
	x86? ( >=dev-lang/nasm-0.98 )
	sdl? ( media-libs/libsdl )
	slang? ( sys-libs/slang )
	alsa? ( media-libs/alsa-lib )
	svga? ( >=media-libs/svgalib-1.9 )"
DEPEND="${RDEPEND}
	fbcon? ( virtual/os-headers )"

src_compile() {
	export PATH="${PATH}:${T}"
	ln -s `which nasm` ${T}/${CHOST}-nasm
	use sdl && ln -s `which sdl-config` ${T}/${CHOST}-sdl-config
	egamesconf \
		`use_enable debug` \
		`use_enable static` \
		`use_enable x86 asm` \
		`use_enable svga svgalib` \
		`use_enable fbcon fb` \
		`use_enable alsa` \
		`use_enable oss` \
		`use_enable slang` \
		`use_enable sdl` \
		|| die
	emake || die
}

src_install() {
	dogamesbin advmenu advcfg advv		|| die "dogamesbin failed"

	dodoc HISTORY README RELEASE obj/doc/*.txt
	dohtml obj/doc/*.html

	for i in obj/doc/*.1; do
		doman ${i}
	done

	prepgamesdirs
}

pkg_postinst() {
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
