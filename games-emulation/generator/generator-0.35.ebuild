# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/generator/generator-0.35.ebuild,v 1.6 2004/03/20 11:43:42 mr_bones_ Exp $

inherit eutils gcc games

DESCRIPTION="Sega Genesis / Mega Drive console emulator"
HOMEPAGE="http://www.squish.net/generator/"
SRC_URI="http://www.squish.net/generator/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="svga gtk"

DEPEND="virtual/glibc
	gtk? (
		=x11-libs/gtk+-1*
		media-libs/libsdl
	)
	svga? ( media-libs/svgalib )
	jpeg? ( media-libs/jpeg )
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}

	cd ${S}
	mkdir my-bins
	if [ "${ARCH}" == "ppc" ]; then
		sed -i \
			-e 's/-minline-all-stringops//g' configure \
				|| die "sed configure failed"
	fi

	if [ $(gcc-major-version) -eq 3 ] ; then
		sed -i \
			-e "s/-malign-functions/-falign-functions/" \
			-e "s/-malign-loops/-falign-loops/" \
			-e "s/-malign-jumps/-falign-jumps/" configure \
				|| die "sed configure failed"
	fi
	epatch "${FILESDIR}/netbsd-gcc-3.3.patch"
}

src_compile() {
	local myconf="--with-gcc=$(gcc-major-version)"

	[ "${ARCH}" == "x86" ] \
		&& myconf="${myconf} --with-raze" \
		|| myconf="${myconf} --with-cmz80"

	local mygui
	for mygui in `use gtk` `use svga` ; do
		[ "${mygui}" == "svga" ] && mygui=svgalib

		if [ -f Makefile ] ; then
			make clean
		fi
		egamesconf \
			${myconf} \
			--with-${mygui} || die
		emake -j1 || die "building ${mygui}"
		mv main/generator-${mygui} my-bins/
	done
	if [ -z "`use gtk``use svga`" ] ; then
		egamesconf \
			${myconf} \
			--with-gtk || die
		emake -j1 || die "building ${mygui}"
		mv main/generator-gtk my-bins/
	fi
}

src_install() {
	dogamesbin my-bins/* || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
