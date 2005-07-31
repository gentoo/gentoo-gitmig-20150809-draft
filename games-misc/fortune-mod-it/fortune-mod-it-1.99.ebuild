# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-it/fortune-mod-it-1.99.ebuild,v 1.3 2005/07/31 14:31:51 corsair Exp $

DESCRIPTION="Database of the Italian cookies for the fortune program"
HOMEPAGE="http://www.fortune-it.net/"
SRC_URI="http://www.fortune-it.net/download/fortune-it-${PVR}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="offensive"

DEPEND="games-misc/fortune-mod"

S="${WORKDIR}/fortune-it-${PVR}"

src_unpack() {
	unpack ${A}
	use offensive || rm -f "${S}"/testi/*-o
}

src_compile() {
	local f
	for f in testi/* ; do
		strfile -s ${f} || die "strfile ${f} failed"
	done
}

src_install() {
	dodir /usr/share/fortune
	cp ${S}/testi/* "${D}"/usr/share/fortune || die "cp failed"
	dodoc README
}
