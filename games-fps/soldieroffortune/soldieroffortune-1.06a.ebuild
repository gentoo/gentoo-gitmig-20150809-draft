# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/soldieroffortune/soldieroffortune-1.06a.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games

IUSE=""
DESCRIPTION="Soldier of Fortune - First-person shooter based on the mercinary trade"
HOMEPAGE="http://www.lokigames.com/products/sof/"
SRC_URI="ftp://ftp.planetmirror.com/pub/lokigames/updates/sof/sof-${PV}-cdrom-x86.run
	ftp://snuffleupagus.animearchive.org/loki/updates/sof/sof-${PV}-cdrom-x86.run"

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
	ewarn "The installed game takes about 725MB of space!"
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir ${dir}
	games_get_cd sof.xpm
	games_verify_cd "Soldier of Fortune"
	einfo "Copying files... this may take a while..."
	exeinto /opt/soldieroffortune
	doexe ${GAMES_CD}/bin/x86/glibc-2.1/sof
	insinto /opt/soldieroffortune

	cp ${GAMES_CD}/{README,kver.pub,sof.xpm} ${Ddir}

	cd ${Ddir}

	tar xzf ${GAMES_CD}/paks.tar.gz || die "uncompressing data"
	tar xzf ${GAMES_CD}/binaries.tar.gz || die "uncompressing binaries"

	cd ${S}
	bin/Linux/x86/loki_patch --verify patch.dat
	bin/Linux/x86/loki_patch patch.dat ${Ddir} >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find ${Ddir} -exec touch '{}' \;

	dodir ${GAMES_BINDIR}
	dogamesbin ${FILESDIR}/sof
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/sof
	insinto /usr/share/pixmaps
	doins ${GAMES_CD}/sof.xpm

	prepgamesdirs
	make_desktop_entry sof "Soldier of Fortune" "sof.xpm"
}

pkg_postinst() {
	einfo "To play the game run:"
	einfo " sof"

	games_pkg_postinst
}
