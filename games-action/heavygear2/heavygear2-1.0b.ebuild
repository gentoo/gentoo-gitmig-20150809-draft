# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/heavygear2/heavygear2-1.0b.ebuild,v 1.3 2004/02/15 23:23:18 wolf31o2 Exp $

inherit games

IUSE="3dfx videos"
DESCRIPTION="Heavy Gear II - 3D first-person Mechanized Assault"
HOMEPAGE="http://www.activision.com/games/heavygearii/"
SRC_URI="ftp://ftp.planetmirror.com/pub/lokigames/updates/hg2/hg2-${PV}-cdrom-x86.run
	ftp://snuffleupagus.animearchive.org/loki/updates/hg2/hg2-${PV}-cdrom-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
	=media-libs/freetype-1*
	virtual/opengl"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	check_license || die "License check failed"
	cdrom_get_cds shell/movies/asteroid.mpg
	if [ "`use videos`" ]; then
		ewarn "The installed game takes about 500MB of space!"
	else
		ewarn "The installed game takes about 400MB of space!"
	fi
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto /opt/heavygear2
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/hg2
	insinto /opt/heavygear2
	use 3dfx && doins ${CDROM_ROOT}/bin/x86/glibc-2.1/LibMesaVoodooGL.so.1.2.030300

	cp ${CDROM_ROOT}/{README,icon.{bmp,xpm}} ${Ddir}
	use videos && cp -r ${CDROM_ROOT}/shell ${Ddir}

	cd ${Ddir}
	use 3dfx && dosym LibMesaVoodooGL.so.1.2.030300 libGL.so.1

	tar xzf ${CDROM_ROOT}/data.tar.gz || die "uncompressing data"
	tar xzf ${CDROM_ROOT}/binaries.tar.gz || die "uncompressing binaries"

	cd ${S}
	bin/Linux/x86/loki_patch --verify patch.dat
	bin/Linux/x86/loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	dodir ${GAMES_BINDIR}
	dogamesbin ${FILESDIR}/hg2
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/hg2
	insinto /usr/share/pixmaps
	newins ${CDROM_ROOT}/icon.xpm HG2.xpm

	prepgamesdirs
	make_desktop_entry hg2 "Heavy Gear II" "HG2.xpm"
}

pkg_postinst() {
	if [ ! "`use videos`" ]; then
		einfo "You will need to mount the Heavy Gear II CD to see the cut-scene videos."
		echo
	fi
	einfo "To play the game run:"
	einfo " hg2"

	games_pkg_postinst
}
