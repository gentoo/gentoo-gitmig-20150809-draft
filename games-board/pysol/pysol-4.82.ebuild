# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol/pysol-4.82.ebuild,v 1.9 2004/11/20 03:51:27 mr_bones_ Exp $

DESCRIPTION="An exciting collection of more than 200 solitaire card games"
HOMEPAGE="http://www.oberhumer.com/opensource/pysol/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="virtual/python
	>=sys-apps/sed-4"
RDEPEND="virtual/python
	>=games-board/pysol-sound-server-3.0
	>=dev-lang/tk-8.0"

pkg_setup() {
	if ! python -c "import Tkinter" >/dev/null 2>&1 ; then
		eerror "You need to recompile python with Tkinter support."
		eerror "That means: USE='tcltk' emerge python"
		echo
		die "missing tkinter support with installed python"
	fi
}

src_install () {
	local prefix="/usr"
	local datadir="${prefix}/share"
	local pkgdatadir=${datadir}/${PN}/${PV}

	sed -i \
		-e "s|@prefix@|${prefix}|" \
		-e "s|@pkgdatadir@|${pkgdatadir}|" pysol || \
			die "sed pysol failed"

	dobin pysol || die "dobin failed"
	make prefix="${D}/usr" install-data
	insinto /usr/X11R6/include/X11/pixmaps
	doins data/pysol.xpm
	doman pysol.6
	dodoc INSTALL NEWS README
}
