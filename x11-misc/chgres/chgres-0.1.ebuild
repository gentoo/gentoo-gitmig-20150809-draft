# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/chgres/chgres-0.1.ebuild,v 1.4 2003/09/05 23:18:18 msterret Exp $

IUSE=""
DESCRIPTION="A very simple command line utility for changing X resolutions"
HOMEPAGE="http://hpwww.ec-lyon.fr/~vincent/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

SRC_URI="http://hpwww.ec-lyon.fr/~vincent/${P}.tar.gz"

DEPEND="x11-base/xfree"

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe chgres
	dodoc README
}
