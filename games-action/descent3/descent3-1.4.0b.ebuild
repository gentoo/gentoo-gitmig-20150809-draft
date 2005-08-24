# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent3/descent3-1.4.0b.ebuild,v 1.11 2005/08/24 14:52:23 wolf31o2 Exp $

inherit eutils games

IUSE="nocd videos"
DESCRIPTION="Descent 3 - 3-Dimensional indoor/outdoor spaceship combat"
HOMEPAGE="http://www.lokigames.com/products/descent3/"
SRC_URI="ftp://ftp.planetmirror.com/pub/lokigames/updates/${PN}/${PN}-1.4.0a-x86.run
	ftp://ftp.planetmirror.com/pub/lokigames/updates/${PN}/${P}-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip"

DEPEND="games-util/loki_patch"
RDEPEND="virtual/opengl"

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	if use videos ; then
		ewarn "The installed game takes about 1.2GB of space!"
		cdrom_get_cds missions/d3.mn3 movies/level1.mve
	else
		cdrom_get_cds missions/d3.mn3
	fi
	if use nocd ; then
		ewarn "The installed game takes about 510MB of space!"
	else
		ewarn "The installed game takes about 220MB of space!"
	fi
	games_pkg_setup
}

src_unpack() {
	mkdir -p ${S}/{a,b}
	cd ${S}/a
	unpack_makeself ${PN}-1.4.0a-x86.run
	cd ${S}/b
	unpack_makeself ${P}-x86.run
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto ${dir}
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/{${PN},nettest} \
		|| die "copying executables"
	insinto ${dir}
	doins ${CDROM_ROOT}/{FAQ.txt,README{,.mercenary},d3.hog,icon.{bmp,xpm}} \
		|| die "copying files"

	cd ${Ddir}
	tar xzf ${CDROM_ROOT}/data.tar.gz || die "uncompressing data"
	tar xzf ${CDROM_ROOT}/shared.tar.gz || die "uncompressing shared"

	if use nocd; then
		doins -r ${CDROM_ROOT}/missions || die "copying missions"
	fi

	if use videos ; then
		cdrom_load_next_cd
		doins -r ${CDROM_ROOT}/movies || die "copying movies"
	fi

	cd ${S}/a
	loki_patch --verify patch.dat
	loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"
	cd ${S}/b
	loki_patch --verify patch.dat
	loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	games_make_wrapper ${PN} ./${PN} ${dir}
	newicon ${CDROM_ROOT}/icon.xpm ${PN}.xpm

	# Fix for 2.6 kernel crash
	cd ${Ddir}
	ln -sf ppics.hog PPics.Hog

	prepgamesdirs
	make_desktop_entry ${PN} "Descent 3" ${PN}
}

pkg_postinst() {
	einfo "To play the game run:"
	einfo " descent3"

	games_pkg_postinst
}
