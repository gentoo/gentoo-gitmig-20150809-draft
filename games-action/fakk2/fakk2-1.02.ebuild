# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/fakk2/fakk2-1.02.ebuild,v 1.2 2004/02/15 23:20:02 wolf31o2 Exp $

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
	check_license || die "License check failed"
	if [ "`use nocd`" ]; then
		ewarn "The installed game takes about 378MB of space!"
	fi
	cdrom_get_cds fakk
	games_pkg_setup
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto /opt/fakk2
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/fakk2
	insinto /opt/fakk2
	doins ${CDROM_ROOT}/{README,icon.{bmp,xpm}}
	dodir ${dir}/fakk
	exeinto /opt/fakk2/fakk
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/fakk/{c,f}game.so
	if [ "`use nocd`" ]; then
		insinto /opt/fakk2/fakk
		doins ${CDROM_ROOT}/fakk/pak{0,1,2,3}.pk3
	fi

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	dodir ${GAMES_BINDIR}
	dogamesbin ${FILESDIR}/fakk2
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/fakk2
	insinto /usr/share/pixmaps
	newins ${CDROM_ROOT}/icon.xpm fakk2.xpm

	prepgamesdirs
	make_desktop_entry fakk2 "FAKK2" "fakk2.xpm"
}

pkg_postinst() {
	einfo "To play the game run:"
	einfo " fakk2"

	games_pkg_postinst
}
