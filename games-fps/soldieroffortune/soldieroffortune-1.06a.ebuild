# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/soldieroffortune/soldieroffortune-1.06a.ebuild,v 1.2 2004/02/08 21:33:38 vapier Exp $

inherit games eutils

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
	cdrom_get_cds sof.xpm
	games_pkg_setup
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir ${dir}
	einfo "Copying files... this may take a while..."
	exeinto /opt/soldieroffortune
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/sof
	insinto /opt/soldieroffortune

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
	make_desktop_entry sof "Soldier of Fortune" "sof.xpm"
}

pkg_postinst() {
	games_pkg_postinst
	einfo "To play the game run:"
	einfo " sof"
}
