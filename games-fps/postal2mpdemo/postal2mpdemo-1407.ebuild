# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/postal2mpdemo/postal2mpdemo-1407.ebuild,v 1.2 2004/02/20 06:40:07 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="You play the Postal Dude: POSTAL 2 is only as violent as you are."
HOMEPAGE="http://www.gopostal.com/home/"
SRC_URI="postal2mpdemo-lnx-${PV}.tar.bz2"

LICENSE="postal2"
SLOT="0"
KEYWORDS="x86"
RESTRICT="fetch"

RDEPEND="virtual/x11
	virtual/glibc"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit http://www.gopostal.com/postal2/demo.php"
	einfo "and download ${A} into ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	unpack_makeself postal2mpdemo-lnx-${PV}.run
	rm postal2mpdemo-lnx-${PV}.run
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	tar -xf postal2mpdemo.tar -C ${D}/${dir}/ || die "failed unpacking postal2mpdemo.tar"
	tar -xf linux-specific.tar -C ${D}/${dir}/ || die "failed unpacking linux-specific.tar"

	insinto ${dir}
	doins README.linux postal2mpdemo.xpm postal2mpdemo_eula.txt

	exeinto ${dir}
	doexe bin/postal2mpdemo
	dodir ${GAMES_BINDIR}
	dosym ${dir}/postal2mpdemo ${GAMES_BINDIR}/postal2mpdemo

	prepgamesdirs
}
