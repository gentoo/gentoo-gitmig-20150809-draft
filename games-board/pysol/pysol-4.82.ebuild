# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol/pysol-4.82.ebuild,v 1.3 2004/01/24 13:58:21 mr_bones_ Exp $

DESCRIPTION="An exciting collection of more than 200 solitaire card games"
SRC_URI="http://www.oberhumer.com/opensource/pysol/download/${P}.tar.bz2"
HOMEPAGE="http://www.oberhumer.com/opensource/pysol/"

DEPEND="virtual/python
	>=sys-apps/sed-4"
RDEPEND="virtual/python
	>=games-board/pysol-sound-server-3.0
	>=dev-lang/tk-8.0"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

pkg_setup() {
	if ! python -c "import Tkinter" >/dev/null 2>&1
	then
		eerror "You need to recompile python with Tkinter support."
		eerror "That means: USE='tcltk' emerge python"
		echo
		die "missing tkinter support with installed python"
	fi
}

src_install () {
	local prefix
	local datadir
	local pkgdatadir

	prefix="/usr"
	datadir="${prefix}/share"
	pkgdatadir=${datadir}/${PN}/${PV}

	sed -i \
		-e "s|@prefix@|${prefix}|" \
		-e "s|@pkgdatadir@|${pkgdatadir}|" pysol || \
			die "sed pysol failed"
	dobin pysol

	make prefix=${D}/usr install-data

	insinto /usr/X11R6/include/X11/pixmaps
	doins data/pysol.xpm

	doman pysol.6

#	cp -a ${WORKDIR}/pysol-cardsets-4.40/data/cardset-* ${D}/opt/${P}/data/
#	cp -a ${WORKDIR}/pysol-music-4.40/data/music/* ${D}/opt/${P}/data/music/
	dodoc INSTALL NEWS README
}

pkg_postinst() {
	einfo "Please make sure that python was built with TK support:"
	einfo "grep tcltk /var/db/pkg/dev-lang/python*/USE"
	einfo "If the grep fails, then:"
	einfo "USE='tcltk' emerge python"
}
