# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol/pysol-4.81-r1.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PySol card game"
SRC_URI="http://www.oberhumer.com/opensource/pysol/download/${P}.tar.bz2"
HOMEPAGE="http://www.oberhumer.com/opensource/pysol/"

DEPEND="virtual/python"
RDEPEND=">=app-games/pysol-sound-server-3.0
	>=dev-lang/tk-8.0
	${DEPEND}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

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
	#tar -xvjf ${DISTDIR}/${P}.tar.bz2 -C ${D}/opt || die
	local prefix
	local datadir
	local pkgdatadir

	prefix="/usr"
	datadir="${prefix}/share"
	pkgdatadir=${datadir}/${PN}/${PV}

	mv ${S}/pysol ${S}/pysol.orig
	sed -e "s|@prefix@|${prefix}|" -e "s|@pkgdatadir@|${pkgdatadir}|" < pysol.orig > pysol
	dobin pysol

	make prefix=${D}/usr install-data

	insinto /usr/X11R6/include/X11/pixmaps
	doins data/pysol.xpm

	doman pysol.6

#	cp -a ${WORKDIR}/pysol-cardsets-4.40/data/cardset-* ${D}/opt/${P}/data/
#	cp -a ${WORKDIR}/pysol-music-4.40/data/music/* ${D}/opt/${P}/data/music/
	dodoc COPYING INSTALL NEWS README
}

pkg_postinst() {
	einfo "Please make sure that python was built with TK support:"
	einfo "grep tcltk /var/db/pkg/dev-lang/python*/USE"
	einfo "If the grep fails, then:"
	einfo "USE='tcltk' emerge python"
}
