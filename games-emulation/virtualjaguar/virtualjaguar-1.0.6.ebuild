# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/virtualjaguar/virtualjaguar-1.0.6.ebuild,v 1.3 2004/02/20 06:26:48 mr_bones_ Exp $

inherit eutils games

S="${WORKDIR}/${P}-src"
DESCRIPTION="an Atari Jaguar emulator"
HOMEPAGE="http://www.icculus.org/virtualjaguar/"
SRC_URI="http://www.icculus.org/virtualjaguar/tarballs/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86"

RDEPEND=">=media-libs/libsdl-1.2.5
	>=sys-libs/zlib-1.1.4"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:-O3:${CFLAGS}:" Makefile.unix || \
			die "sed Makefile.unix failed"
	epatch ${FILESDIR}/gcc331.patch
}

src_compile() {
	emake -j1 -f Makefile.unix
}

src_install() {
	dogamesbin vj
	dogamesbin ${FILESDIR}/virtualjaguar
	dodoc INSTALL docs/{README,TODO,WHATSNEW}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Please run virtualjaguar to create the necessary directories"
	einfo "in your home directory.  After that you may place ROM files"
	einfo "in ~/.vj and they will be detected when you run virtualjaguar."
	einfo "You may then select which ROM to run from inside the emulator."
}
