# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecraft/freecraft-1.18-r2.ebuild,v 1.1 2004/01/18 01:43:39 vapier Exp $

inherit games eutils

MY_P=${PN}-030311
DESCRIPTION="realtime strategy game engine for games like Warcraft/Starcraft/etc."
HOMEPAGE="http://www.freecraft.org/"
SRC_URI="${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
RESTRICT="fetch"

DEPEND=">=media-libs/libpng-1.2.3
	>=media-libs/libsdl-1.2.4
	sys-libs/zlib"

S=${WORKDIR}/${MY_P}

pkg_nofetch() {
	einfo "Due to a Ceast and Desist given by Blizzard,"
	einfo "you must obtain the sources for this game yourself."
	einfo "For more information, please visit: ${HOMEPAGE}"
	einfo "Also, you'll have to place the files ${A}"
	einfo "into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-setup.patch
	env GENTOO_CFLAGS="${CFLAGS}" ./setup || die
}

src_compile() {
	make depend || die "depend generation failed"
	make || die "build failed"
}

src_install() {
	exeinto ${GAMES_LIBDIR}/${PN}
	doexe freecraft
	dogamesbin ${FILESDIR}/freecraft
	dosed "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/freecraft
	dosed "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/freecraft

	exeinto ${GAMES_DATADIR}/${PN}/tools
	doexe tools/{build.sh,aledoc,startool,wartool}

	dodir ${GAMES_DATADIR}/${PN}/
	cp -r data ${D}/${GAMES_DATADIR}/${PN}/

	insinto ${GAMES_DATADIR}/${PN}/contrib
	cp -r contrib ${D}/${GAMES_DATADIR}/${PN}/

	dohtml -r doc
	dodoc README

	prepgamesdirs
}

pkg_postinst() {
	einfo "Freecraft is now installed but in order to actually play"
	einfo "you will need to either use a Warcraft CD or install the"
	einfo "freecraft-fcmp ebuild.  To use a Warcraft CD:"
	einfo " 1 mount the cd as /mnt/cdrom"
	einfo " 2 cd ${GAMES_DATADIR}"
	einfo " 3 run tools/build.sh"
	einfo "This will extract the data files to the correct place."
	einfo "Note that the CD is still needed for the music.  To"
	einfo "start a game just run \`playfreecraft\`."
	einfo "For more info, review \`freecraft --help\`."

	games_pkg_postinst
}
