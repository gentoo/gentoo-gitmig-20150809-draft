# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

DESCRIPTION="Database of the Italian cookies for the fortune program"
HOMEPAGE="http://www.orson.it/~fedeliallalinea/"
SRC_URI="http://www.orson.it/~fedeliallalinea/files/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE="offensive"

DEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	use offensive || rm -f "${S}/zozzital"
}

src_compile() {
	local f

	for f in *
	do
		strfile -s ${f} || die "strfile ${f} failed"
	done
}

src_install() {
	dodir /usr/share/fortune
	cp * "${D}/usr/share/fortune" || die "cp failed"
	dodoc ../README
}
