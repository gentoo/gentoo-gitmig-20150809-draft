# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/soldieroffortune/soldieroffortune-1.06a.ebuild,v 1.9 2005/03/07 13:55:38 wolf31o2 Exp $

inherit games

DESCRIPTION="Soldier of Fortune - First-person shooter based on the mercenary trade"
HOMEPAGE="http://www.lokigames.com/products/sof/"
SRC_URI="ftp://ftp.planetmirror.com/pub/lokigames/updates/sof/sof-${PV}-cdrom-x86.run
	ftp://snuffleupagus.animearchive.org/loki/updates/sof/sof-${PV}-cdrom-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	virtual/opengl"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	ewarn "The installed game takes about 725MB of space!"
	cdrom_get_cds sof.xpm
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto ${dir}
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/sof
	insinto ${dir}

	cp ${CDROM_ROOT}/{README,kver.pub,sof.xpm} ${Ddir}

	cd ${Ddir}

	tar xzf ${CDROM_ROOT}/paks.tar.gz || die "uncompressing data"
	tar xzf ${CDROM_ROOT}/binaries.tar.gz || die "uncompressing binaries"

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
	doins ${CDROM_ROOT}/sof.xpm

	prepgamesdirs
	make_desktop_entry sof "Soldier of Fortune" sof.xpm
}

pkg_postinst() {
	games_pkg_postinst
	einfo "To play the game run:"
	einfo " sof"
}
