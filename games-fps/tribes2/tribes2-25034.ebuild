# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/tribes2/tribes2-25034.ebuild,v 1.13 2006/04/13 21:13:57 wolf31o2 Exp $

inherit eutils games

IUSE=""
DESCRIPTION="Tribes 2 - Team Combat on an Epic Scale"
HOMEPAGE="http://www.lokigames.com/products/tribes2/"
SRC_URI="http://www.libsdl.org/projects/${PN}/release/${P}-cdrom-x86.run
	mirror://3dgamers/${PN}/${P}-cdrom-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="mirror strip"

DEPEND="virtual/libc
	games-util/loki_patch"
RDEPEND="${DEPEND}
	virtual/opengl"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	ewarn "The installed game takes about 507MB of space!"
	cdrom_get_cds README.tribes2d
}

src_unpack() {
	unpack_makeself || die "unpacking patch"
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto ${dir}
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/{t2launch,tribes2,tribes2.dynamic,tribes2d,tribes2d-restart.sh,tribes2d.dynamic} || die "doexe failed"

	cp ${CDROM_ROOT}/{README,README.tribes2d,Tribes2_Manual.pdf,console_start.cs,kver.pub} ${Ddir} || die "copy failed"

	# Video card profiles
	tar xzf ${CDROM_ROOT}/profiles.tar.gz -C ${Ddir} || die "uncompressing profiles"

	# Base (Music, Textures, Maps, etc.)
	cp -rf ${CDROM_ROOT}/base ${CDROM_ROOT}/menu ${Ddir} || die "copying data"

	cd ${S}
	loki_patch --verify patch.dat
	loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	newicon ${CDROM_ROOT}/icon.xpm tribes2.xpm
	games_make_wrapper t2launch ./t2launch "${dir}" "${dir}"
	make_desktop_entry t2launch "Tribes 2" tribes2.xpm

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "To play the game run:"
	einfo " t2launch"
}
