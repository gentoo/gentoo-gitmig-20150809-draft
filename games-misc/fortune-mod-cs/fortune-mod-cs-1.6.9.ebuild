# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-cs/fortune-mod-cs-1.6.9.ebuild,v 1.1 2004/09/13 09:10:52 mr_bones_ Exp $

DESCRIPTION="Database of the Czech and Slovak cookies for the fortune(6) program"
HOMEPAGE="http://ftp.fi.muni.cz/pub/linux/people/zdenek_pytela/"
SRC_URI="http://ftp.fi.muni.cz/pub/linux/people/zdenek_pytela/${P/-mod/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${P/-mod/}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f LICENSE install.sh fortune-cs.* *xpm
}

src_compile() {
	local f

	for f in [[:lower:]]*
	do
		strfile -s ${f} || die "strfile ${f} failed"
	done
}

src_install() {
	insinto /usr/share/fortune/cs
	doins [[:lower:]]* || die "doins failed"
	dodoc [[:upper:]]*
}
