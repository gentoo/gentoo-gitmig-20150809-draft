# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/advancemame/advancemame-0.77.2.ebuild,v 1.5 2004/01/10 21:29:16 vapier Exp $

inherit games eutils

DESCRIPTION="GNU/Linux port of the MAME emulator with GUI menu"
HOMEPAGE="http://advancemame.sourceforge.net/"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2 xmame"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="debug static svga fbcon alsa oss slang sdl"

RDEPEND="virtual/glibc
	app-arch/unzip
	x86? ( >=dev-lang/nasm-0.98 )
	sdl? ( media-libs/libsdl )
	slang? ( sys-libs/slang )
	alsa? ( media-libs/alsa-lib )
	svga? ( >=media-libs/svgalib-1.9 )"
DEPEND="${RDEPEND}
	virtual/os-headers"

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
		--with-emu=${PN/advance} \
		|| die
	emake || die
}

src_install() {
	dogamesbin adv* || die "dogamesbin failed"

	dodir ${GAMES_DATADIR}/advance/{artwork,diff,image,rom,sample,snap}
	insinto ${GAMES_DATADIR}/advance
	doins support/event.dat

	dodoc HISTORY README RELEASE
	cd obj/doc
	dodoc *.txt
	dohtml *.html
	for m in *.1 ; do
		newman ${m} ${m/1/6}
	done

	prepgamesdirs
}
