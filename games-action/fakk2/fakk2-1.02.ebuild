# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/fakk2/fakk2-1.02.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games

IUSE="nocd"
DESCRIPTION="Heavy Metal: FAKK2 - 3D third-person action shooter based on the Heavy Metal comics/movies"
HOMEPAGE="http://www.lokigames.com/products/fakk2/"
SRC_URI=""

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
	virtual/opengl"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	if [ "`use nocd`" ]; then
		ewarn "The installed game takes about 378MB of space!"
	fi
	games_pkg_setup
}

src_install() {
	dodir ${dir}
	games_get_cd fakk
	games_verify_cd "Heavy Metal: FAKK2"
	einfo "Copying files... this may take a while..."
	exeinto /opt/fakk2
	doexe ${GAMES_CD}/bin/x86/glibc-2.1/fakk2
	insinto /opt/fakk2
	doins ${GAMES_CD}/{README,icon.{bmp,xpm}}
	dodir ${dir}/fakk
	exeinto /opt/fakk2/fakk
	doexe ${GAMES_CD}/bin/x86/glibc-2.1/fakk/{c,f}game.so
	if [ "`use nocd`" ]; then
		insinto /opt/fakk2/fakk
		doins ${GAMES_CD}/fakk/pak{0,1,2,3}.pk3
	fi

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	dodir ${GAMES_BINDIR}
	dogamesbin ${FILESDIR}/fakk2
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/fakk2
	insinto /usr/share/pixmaps
	newins ${GAMES_CD}/icon.xpm fakk2.xpm

	prepgamesdirs
	make_desktop_entry fakk2 "FAKK2" "fakk2.xpm"
}

pkg_postinst() {
	einfo "To play the game run:"
	einfo " fakk2"

	games_pkg_postinst
}
