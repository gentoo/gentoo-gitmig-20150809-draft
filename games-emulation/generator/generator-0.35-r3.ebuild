# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/generator/generator-0.35-r3.ebuild,v 1.2 2007/02/03 08:01:50 nyhm Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Sega Genesis / Mega Drive emulator"
HOMEPAGE="http://www.ghostwhitecrab.com/generator/"
SRC_URI="http://www.ghostwhitecrab.com/generator/${P}-cbiere-r2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk sdlaudio svga"

S=${WORKDIR}/${P}-cbiere-r2

RDEPEND="media-libs/jpeg
	media-libs/libsdl
	gtk? ( =x11-libs/gtk+-1.2* )
	svga? ( media-libs/svgalib )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir my-bins

	epatch "${FILESDIR}"/${P}-execstacks.patch

	sed -i \
		-e '/CFLAGS.*-O3/d' \
		configure || die "sed configure failed"
}

# builds SDL by default since otherwise -svga -gtk builds nothing
src_compile() {
	local myconf mygui myguis

	use x86 \
		&& myconf="--with-raze" \
		|| myconf="--with-cmz80"

	myguis="sdl"
	use gtk && myguis="${myguis} gtk"
	use svga && myguis="${myguis} svgalib"

	for mygui in ${myguis}; do
		[[ -f Makefile ]] && make -s clean
		egamesconf \
			${myconf} \
			--with-${mygui} \
			--with-gcc=$(gcc-major-version) \
			$(use_with sdlaudio sdl-audio) \
			--disable-dependency-tracking || die
		emake -j1 || die "building ${mygui}"
		mv main/generator-${mygui} my-bins/
	done
}

src_install() {
	dogamesbin my-bins/* || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog NEWS README TODO docs/*
	prepgamesdirs
}
