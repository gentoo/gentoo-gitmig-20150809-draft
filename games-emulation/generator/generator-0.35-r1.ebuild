# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/generator/generator-0.35-r1.ebuild,v 1.2 2006/04/20 03:45:38 vapier Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Sega Genesis / Mega Drive console emulator"
HOMEPAGE="http://www.ghostwhitecrab.com/generator/"
SRC_URI="http://www.ghostwhitecrab.com/generator/${P}-cbiere.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="svga gtk"

S=${WORKDIR}/${P}-cbiere

RDEPEND="media-libs/jpeg
	gtk? (
		=x11-libs/gtk+-1*
		media-libs/libsdl
	)
	svga? ( media-libs/svgalib )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir my-bins

	epatch "${FILESDIR}"/${P}-gcc.patch

	sed -i \
		-e '/CFLAGS.*-O3/d' \
		-e 's/-minline-all-stringops//g' \
		configure || die "sed configure failed"

	if [[ $(gcc-major-version) -eq 3 ]] ; then
		sed -i \
			-e "s/-malign-functions/-falign-functions/" \
			-e "s/-malign-loops/-falign-loops/" \
			-e "s/-malign-jumps/-falign-jumps/" \
			configure || die "sed configure failed"
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

	for mygui in ${myguis:-gtk} ; do
		[[ -f Makefile ]] && make -s clean
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
