# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/advancemame/advancemame-0.77.2.ebuild,v 1.1 2004/01/06 03:53:00 mr_bones_ Exp $

inherit games

DESCRIPTION="GNU/Linux port of the MAME emulator with GUI menu"
HOMEPAGE="http://advancemame.sourceforge.net/"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2 xmame"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="virtual/glibc
	app-arch/unzip
	x86? ( >=dev-lang/nasm-0.98 )
	media-libs/libsdl
	slang? ( sys-libs/slang )
	alsa? ( media-libs/alsa-lib )
	svga? ( >=media-libs/svgalib-1.9 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	virtual/os-headers"

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i \
		-e 's:slang/slang\.h:slang.h:' advance/linux/{os,vslang}.c \
			|| die "sed failed"
}

src_compile() {
	export PATH="${PATH}:${T}"
	ln -s `which nasm` ${T}/${CHOST}-nasm >& /dev/null
	egamesconf \
		--host="" \
		`use_enable debug` \
		`use_enable static` \
		`use_enable x86 asm` \
		`use_enable svga svgalib` \
		`use_enable fbconf fb` \
		`use_enable alsa` \
		`use_enable oss` \
		`use_enable slang` \
		`use_enable sdl` \
		--with-system=sdl \
		--enable-pthread \
		--with-emu=${PN/advance} \
			|| die
	emake || die "emake failed"
}

src_install() {
	local m

	dogamesbin adv* || die "dogamesbin failed"

	dodir ${GAMES_DATADIR}/advance/{artwork,diff,image,rom,sample,snap}
	insinto ${GAMES_DATADIR}/advance
	doins support/event.dat || die "doins failed"

	dodoc HISTORY README RELEASE obj/doc/*.txt || die "dodoc failed"
	dohtml obj/doc/*.html || die "dohtml failed"
	cd obj/doc
	for m in *.1 ; do
		newman ${m} ${m/.1/.6} || die "newman ${m} ${m/.1/.6} failed"
	done
	prepgamesdirs
}
