# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gnuboy/gnuboy-1.0.3.ebuild,v 1.12 2006/09/28 12:45:03 nyhm Exp $

inherit games

DESCRIPTION="Gameboy emulator with multiple renderers"
HOMEPAGE="http://gnuboy.unix-fu.org/"
SRC_URI="http://gnuboy.unix-fu.org/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X fbcon sdl svga"

RDEPEND="sdl? ( media-libs/libsdl )
	     !X? ( !svga? ( !fbcon? ( media-libs/libsdl ) ) )
		 X? ( x11-libs/libXext )
		 fbcon? ( sys-apps/fbset )"
DEPEND="${RDEPEND}
	svga? ( media-libs/svgalib )
	X? ( x11-proto/xextproto
		x11-proto/xproto )"

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
