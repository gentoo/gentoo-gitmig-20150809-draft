# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/tribes2/tribes2-25034.ebuild,v 1.6 2004/09/29 02:01:42 wolf31o2 Exp $

inherit games

IUSE=""
DESCRIPTION="Tribes 2 - Team Combat on an Epic Scale"
HOMEPAGE="http://www.lokigames.com/products/tribes2/"
SRC_URI="http://www.libsdl.org/projects/${PN}/release/${P}-cdrom-x86.run
	mirror://3dgamers/pub/3dgamers/games/${PN}/${P}-cdrom-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip nomirror"

DEPEND="virtual/libc
	games-util/loki_patch"
RDEPEND="${DEPEND}
	virtual/opengl"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license || die "License check failed"
	ewarn "The installed game takes about 507MB of space!"
	cdrom_get_cds README.tribes2d
	games_pkg_setup
}

src_unpack() {
	unpack_makeself || die "unpacking patch"
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto ${dir}
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/{t2launch,tribes2,tribes2.dynamic,tribes2d,tribes2d-restart.sh,tribes2d.dynamic}

	cp ${CDROM_ROOT}/{README,README.tribes2d,Tribes2_Manual.pdf,console_start.cs,kver.pub} ${Ddir}

	# Video card profiles
	tar xzf ${CDROM_ROOT}/profiles.tar.gz -C ${Ddir} || die "uncompressing profiles"

	# Base (Music, Textures, Maps, etc.)
	cp -rf ${CDROM_ROOT}/base ${CDROM_ROOT}/menu ${Ddir}

	cd ${S}
	loki_patch --verify patch.dat
	loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	#dodir ${GAMES_BINDIR}
	#dosym ${dir}/t2launch ${GAMES_BINDIR}/t2launch
	#dosym ${dir}/tribes2 ${GAMES_BINDIR}/tribes2
	#dosym ${dir}/tribes2.dynamic ${GAMES_BINDIR}/tribes2.dynamic
	#dosym ${dir}/tribes2d ${GAMES_BINDIR}/tribes2d
	#dosym ${dir}/tribes2d-restart.sh ${GAMES_BINDIR}/tribes2d-restart.sh
	#dosym ${dir}/tribes2d.dynamic ${GAMES_BINDIR}/tribes2d.dynamic

	games_make_wrapper t2launch ./t2launch ${dir}

	insinto /usr/share/pixmaps
	newins ${CDROM_ROOT}/icon.xpm Tribes2.xpm
	doins ${CDROM_ROOT}/icon.bmp

	prepgamesdirs
	make_desktop_entry t2launch "Tribes 2" "Tribes2.xpm"
}

pkg_postinst() {
	einfo "To play the game run:"
	einfo " t2launch"

	games_pkg_postinst
}
