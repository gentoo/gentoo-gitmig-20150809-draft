# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent3/descent3-1.4.0b.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games

IUSE="nocd videos"
DESCRIPTION="Descent 3 - 3-Dimensional indoor/outdoor spaceship combat"
HOMEPAGE="http://www.lokigames.com/products/descent3/"
SRC_URI="ftp://ftp.planetmirror.com/pub/lokigames/updates/descent3/descent3-1.4.0a-x86.run
	ftp://ftp.planetmirror.com/pub/lokigames/updates/descent3/${P}-x86.run"

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
	if [ "`use videos`" ]; then
		ewarn "The installed game takes about 1.2GB of space!"
	fi
	if [ "`use nocd`" ]; then
		ewarn "The installed game takes about 510MB of space!"
	else
		ewarn "The installed game takes about 220MB of space!"
	fi
	games_pkg_setup
}

src_unpack() {
	mkdir ${S}/{a,b}
	cd ${S}/a
	unpack_makeself ${PN}-1.4.0a-x86.run
	cd ${S}/b
	unpack_makeself ${P}-x86.run
}

src_install() {
	dodir ${dir}
	games_get_cd missions/d3.mn3
	games_verify_cd "Descent 3 Disk 1"
	einfo "Copying files... this may take a while..."
	exeinto /opt/descent3
	doexe ${GAMES_CD}/bin/x86/glibc-2.1/{descent3,nettest}
	insinto /opt/descent3

	cp ${GAMES_CD}/{FAQ.txt,README,README.mercenary,d3.hog,icon.{bmp,xpm}} ${Ddir}

	cd ${Ddir}

	tar xzf ${GAMES_CD}/data.tar.gz || die "uncompressing data"
	tar xzf ${GAMES_CD}/shared.tar.gz || die "uncompressing shared"

	use nocd && cp ${GAMES_CD}/missions/* ${Ddir}/missions

	if [ "`use videos`" ]; then
		games_get_cd movies/level1.mve
		games_verify_cd "Descent 3 Disk 2"
		cp ${GAMES_CD}/movies/* ${Ddir}/movies || die "copying movies"
	fi

	cd ${S}/a
	bin/Linux/x86/loki_patch --verify patch.dat
	bin/Linux/x86/loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"
	cd ${S}/b
	bin/Linux/x86/loki_patch --verify patch.dat
	bin/Linux/x86/loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	dodir ${GAMES_BINDIR}
	dogamesbin ${FILESDIR}/descent3
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/descent3
	insinto /usr/share/pixmaps
	newins ${GAMES_CD}/icon.xpm descent3.xpm

	prepgamesdirs
	make_desktop_entry descent3 "Descent 3" "descent3.xpm"
}

pkg_postinst() {
	einfo "To play the game run:"
	einfo " descent3"

	games_pkg_postinst
}
