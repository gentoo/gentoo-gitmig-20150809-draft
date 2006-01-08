# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnuboy/gnuboy-1.0.3.ebuild,v 1.9 2006/01/08 01:06:35 mr_bones_ Exp $

inherit games

DESCRIPTION="Gameboy emulator with multiple renderers"
HOMEPAGE="http://gnuboy.unix-fu.org/"
SRC_URI="http://gnuboy.unix-fu.org/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X fbcon sdl svga"

DEPEND="X? ( virtual/x11 )
	sdl? ( media-libs/libsdl )
	svga? ( media-libs/svgalib )
	!X? ( !svga ( !fbcon ( media-libs/libsdl ) ) )"

src_compile() {
	local myconf

	if ! use X && ! use svga && ! use fbcon; then
		myconf="--with-sdl"
	fi

	egamesconf \
		$(use_with X x) \
		$(use_with fbcon fb) \
		$(use_with sdl) \
		$(use_with svga svgalib) \
		$(use_enable x86 asm) \
		${myconf} \
		--disable-arch \
		--disable-optimize
	emake || die "emake failed"
}

src_install() {
	for f in fbgnuboy sdlgnuboy sgnuboy xgnuboy
	do
		if [[ -f $f ]] ; then
			dogamesbin $f || die "dogamesbin failed"
		fi
	done
	dodoc README docs/{CHANGES,CONFIG,CREDITS,FAQ,HACKING,WHATSNEW}
	prepgamesdirs
}
