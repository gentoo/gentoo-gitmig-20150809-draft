# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/generator/generator-0.35.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games gcc

DESCRIPTION="Sega Genesis / Mega Drive console emulator"
HOMEPAGE="http://www.squish.net/generator/"
SRC_URI="http://www.squish.net/generator/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="svga tcltk gtk" #allegro fails to compile

DEPEND="gtk? ( =x11-libs/gtk+-1* media-libs/libsdl )
	svga? ( media-libs/svgalib )
	jpeg? ( media-libs/jpeg )
	x86? ( dev-lang/nasm )"
#	allegro? ( media-libs/allegro )
#	tcltk? ( dev-lang/tk dev-lang/tcl ) #deprecated upstream

src_unpack() {
	unpack ${A}

	cd ${S}
	if [ "${ARCH}" == "ppc" ]; then
		sed -i -e 's/-minline-all-stringops//g' configure
	fi
}

src_compile() {
	mkdir my-bins

	local myconf="--with-gcc=`gcc-major-version`"
	[ "${ARCH}" == "x86" ] \
		&& myconf="${myconf} --with-raze" \
		|| myconf="${myconf} --with-cmz80"

	local mygui
	for mygui in `use gtk` `use svga` ; do #`use allegro` `use tcltk`
		[ "${mygui}" == "svga" ] && mygui=svgalib
		make clean
		egamesconf ${myconf} --with-${mygui} || die
		make || die "building ${mygui}"
		mv main/generator-${mygui} my-bins/
	done
	if [ -z "`use gtk``use allegro``use svga``use tcltk`" ] ; then
		egamesconf ${myconf} --with-gtk || die
		make || die "building ${mygui}"
		mv main/generator-gtk my-bins/
	fi
}

src_install() {
	#make install DESTDIR=${D} || die #all it does is install the binary ;)
	dogamesbin my-bins/*
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
