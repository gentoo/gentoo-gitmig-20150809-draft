# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-it/fortune-mod-it-1.51.ebuild,v 1.4 2006/07/17 05:00:23 vapier Exp $

DESCRIPTION="Database of the Italian cookies for the fortune program"
HOMEPAGE="http://www.orson.it/~fedeliallalinea/"
SRC_URI="http://www.orson.it/~fedeliallalinea/files/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="offensive"

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	use offensive || rm -f zozzital
}

src_compile() {
	local f
	for f in * ; do
		strfile -s ${f} || die "strfile ${f} failed"
	done
}

src_install() {
	insinto /usr/share/fortune
	doins * || die "cp failed"
	dodoc ../README
}
