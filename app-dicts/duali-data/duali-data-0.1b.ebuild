# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/duali-data/duali-data-0.1b.ebuild,v 1.9 2005/04/01 03:45:30 agriffis Exp $

IUSE=""

DESCRIPTION="Dictionary data for the Arab dictionary project duali"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=Duali"
SRC_URI="mirror://sourceforge/arabeyes/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ia64 ~ppc ~sparc alpha ~hppa ~mips"

DEPEND="app-text/duali"

src_compile() {
	dict2db --path ./ || die
}

src_install() {
	insinto /usr/share/duali
	doins stems.db prefixes.db suffixes.db
	doins tableab tableac tablebc

	dodoc gpl.txt README
}
