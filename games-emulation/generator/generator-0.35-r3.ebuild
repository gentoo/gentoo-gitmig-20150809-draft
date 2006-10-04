# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils toolchain-funcs flag-o-matic games

DESCRIPTION="Sega Genesis / Mega Drive emulator"
HOMEPAGE="http://www.ghostwhitecrab.com/generator/"
SRC_URI="http://www.ghostwhitecrab.com/generator/${P}-cbiere-r2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="svga gtk sdlaudio"

S="${WORKDIR}/${P}-cbiere-r2"

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

	# these are removed from configure by the sed above
	use x86 && append-flags -ffast-math -fomit-frame-pointer

	for mygui in ${myguis}; do
		[[ -f Makefile ]] && make -s clean
		egamesconf \
			${myconf} \
			--with-${mygui} \
			--with-gcc=$(gcc-major-version) \
			$(use_with sdlaudio sdl-audio) \
			--disable-dependency-tracking || die "econf failed"
		emake -j1 || die "building ${mygui}"
		mv main/generator-${mygui} my-bins/
	done
}

src_install() {
	dogamesbin my-bins/* || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog NEWS README TODO docs/*
	prepgamesdirs
}
