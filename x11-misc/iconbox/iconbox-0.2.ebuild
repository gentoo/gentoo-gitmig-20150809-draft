# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/iconbox/iconbox-0.2.ebuild,v 1.7 2011/03/02 17:22:22 signals Exp $

EAPI=2
MY_P="${P/-/_}"

DESCRIPTION="App for placing icons in a menu which auto-hides"
HOMEPAGE="http://elrodeo.de/velopment/iconbox/"
SRC_URI="http://elrodeo.de/velopment/${PN}/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="x11-libs/gtk+:2
	dev-perl/gtk2-perl"

src_compile() {
	true # no compilation is necessary
}

src_install() {
# make install is borked due to a crappy makefile... it is simpler to go around
# it than to fix it... i have notified upstream

	exeinto /usr/bin/
	doexe iconbox iconboxconf || die
	dodoc README Changelog Copyright
	doman *.1 || die
}
