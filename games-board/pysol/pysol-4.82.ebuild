# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pysol/pysol-4.82.ebuild,v 1.11 2005/06/24 00:22:30 vapier Exp $

inherit python

DESCRIPTION="An exciting collection of more than 200 solitaire card games"
HOMEPAGE="http://www.pysol.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/python"
RDEPEND="virtual/python
	>=games-board/pysol-sound-server-3.0
	>=dev-lang/tk-8.0"

pkg_setup() {
	python_tkinter_exists
}

src_install() {
	local prefix="/usr"
	local datadir="${prefix}/share"
	local pkgdatadir=${datadir}/${PN}/${PV}

	sed -i \
		-e "s|@prefix@|${prefix}|" \
		-e "s|@pkgdatadir@|${pkgdatadir}|" \
		pysol || die "sed pysol failed"

	dobin pysol || die "dobin failed"
	make prefix="${D}/usr" install-data || die "install-data failed"
	insinto /usr/include/X11/pixmaps
	doins data/pysol.xpm
	doman pysol.6
	dodoc NEWS README
}
