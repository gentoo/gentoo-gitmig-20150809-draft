# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/generator/generator-0.35-r1.ebuild,v 1.1 2006/03/30 23:01:11 wolf31o2 Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Sega Genesis / Mega Drive console emulator"
HOMEPAGE="http://www.ghostwhitecrab.com/generator/"
SRC_URI="http://www.ghostwhitecrab.com/generator/${P}-cbiere.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="svga gtk"

S=${WORKDIR}/${P}-cbiere

RDEPEND="virtual/libc
	gtk? (
		=x11-libs/gtk+-1*
		media-libs/libsdl
	)
	svga? ( media-libs/svgalib )
	media-libs/jpeg"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}

	cd ${S}
	mkdir my-bins
	if use ppc ; then
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
}

src_compile() {
	local myconf="--with-gcc=$(gcc-major-version)"
	local mygui myguis

	use x86 \
		&& myconf="${myconf} --with-raze" \
		|| myconf="${myconf} --with-cmz80"

	use gtk && myguis="gtk"
	use svga && myguis="svgalib"
	[ -n "${myguis}" ] || myguis="gtk"

	for mygui in ${myguis}; do
		if [ -f Makefile ] ; then
			make clean
		fi
		egamesconf \
			${myconf} \
			--with-${mygui} || die
		emake -j1 || die "building ${mygui}"
		mv main/generator-${mygui} my-bins/
	done
}

src_install() {
	dogamesbin my-bins/* || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
