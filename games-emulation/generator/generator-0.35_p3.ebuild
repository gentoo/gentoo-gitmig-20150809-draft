# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/generator/generator-0.35_p3.ebuild,v 1.5 2008/05/05 20:28:26 maekke Exp $

inherit autotools eutils toolchain-funcs games

MY_P=${PN}-${PV/_p/-cbiere-r}
DESCRIPTION="Sega Genesis / Mega Drive emulator"
HOMEPAGE="http://www.ghostwhitecrab.com/generator/"
SRC_URI="http://www.ghostwhitecrab.com/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="sdlaudio svga"

RDEPEND="media-libs/jpeg
	media-libs/libsdl
	svga? ( media-libs/svgalib )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir my-bins

	epatch \
		"${FILESDIR}"/${P}-execstacks.patch \
		"${FILESDIR}"/${P}-configure.patch

	# make it yasm-syntax-friendly
	sed -i \
		-e 's/-praze/-Praze/' \
		raze/Makefile.am \
		|| die 'sed failed'
	# USE32 is redundent with elf
	sed -i \
		-e 's/USE32//' \
		raze/raze.asm.in \
		|| die 'sed failed'
	sed -i \
		-e 's/@GTK_CFLAGS@//g' \
		main/Makefile.am \
		|| die "sed failed"
	eautoreconf
}

# builds SDL by default since otherwise -svga builds nothing
src_compile() {
	local myconf mygui myguis

	use x86 \
		&& myconf="--with-raze" \
		|| myconf="--with-cmz80"

	myguis="sdl"
	use svga && myguis="${myguis} svgalib"

	for mygui in ${myguis}; do
		[[ -f Makefile ]] && emake clean
		egamesconf \
			${myconf} \
			--with-${mygui} \
			--without-gtk \
			--without-tcltk \
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
