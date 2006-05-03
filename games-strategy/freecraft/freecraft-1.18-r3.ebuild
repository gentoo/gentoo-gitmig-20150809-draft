# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecraft/freecraft-1.18-r3.ebuild,v 1.10 2006/05/03 07:28:57 mr_bones_ Exp $

inherit eutils games

MY_P=${PN}-030311
DESCRIPTION="realtime strategy game engine for games like Warcraft/Starcraft/etc."
HOMEPAGE="http://www.math.sfu.ca/~cbm/cd/"
SRC_URI="${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
RESTRICT="fetch"

DEPEND=">=media-libs/libpng-1.2.3
	>=media-libs/libsdl-1.2.4
	sys-libs/zlib"

S="${WORKDIR}/${MY_P}"

pkg_nofetch() {
	einfo "Due to a Ceast and Desist given by Blizzard,"
	einfo "you must obtain the sources for this game yourself."
	einfo "For more information, please visit: ${HOMEPAGE}"
	einfo "Also, you'll have to place the files ${A}"
	einfo "into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-setup.patch"
	env GENTOO_CFLAGS="${CFLAGS}" ./setup || die
}

src_compile() {
	make depend || die "depend generation failed"
	make || die "build failed"
}

src_install() {
	exeinto "${GAMES_LIBDIR}/${PN}"
	doexe freecraft || die "doexe failed"
	dogamesbin "${FILESDIR}/freecraft" || die "dogamesbin failed"
	sed -i \
		-e  "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e  "s:GENTOO_LIBDIR:${GAMES_LIBDIR}/${PN}:" \
		"${D}${GAMES_BINDIR}/freecraft" \
		|| die "sed failed"

	exeinto "${GAMES_DATADIR}/${PN}/tools"
	doexe tools/{build.sh,aledoc,startool,wartool} || die "doexe failed"

	dodir "${GAMES_DATADIR}/${PN}"
	cp -r contrib data "${D}/${GAMES_DATADIR}/${PN}/" || die "cp failed"

	dohtml -r doc
	dodoc README

	prepgamesdirs

	# make sure we dont clobber files freecraft and freecraft-fcmp share #39278
	local fcmpver="$(best_version games-strategy/freecraft-fcmp)"
	if [ ! -z "${fcmpver}" ] ; then
		cd "${D}/${GAMES_DATADIR}/${PN}/data/ccl"
		for f in $(grep ${GAMES_DATADIR}/${PN}/data/ccl/ /var/db/pkg/${fcmpver}/CONTENTS) ; do
			[ -d "${f}" ] && continue
			[ -e "${f}" -a -e "${D}/${f}" ] && rm "${D}/${f}"
		done
	fi
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Freecraft is now installed but in order to actually play"
	einfo "you will need to either use a Warcraft CD or install the"
	einfo "freecraft-fcmp ebuild.  To use a Warcraft CD:"
	einfo " 1 mount the cd as /mnt/cdrom"
	einfo " 2 cd ${GAMES_DATADIR}/${PN}"
	einfo " 3 run tools/build.sh"
	einfo "This will extract the data files to the correct place."
	einfo "Note that the CD is still needed for the music.  To"
	einfo "start a game just run \"playfreecraft\"."
	einfo "For more info, review \"freecraft --help\"."
}
