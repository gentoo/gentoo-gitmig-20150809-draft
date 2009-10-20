# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-prolinux/fortune-mod-prolinux-0.25.ebuild,v 1.3 2009/10/20 13:03:11 maekke Exp $

DESCRIPTION="Quotes from Prolinux articles and comments"
HOMEPAGE="http://www.pro-linux.de/news/2009/14520.html"
SRC_URI="http://www.pro-linux.de/files/fortunes-prolinux-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="games-misc/fortune-mod"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN/-mod/s}

src_compile() {
	./mkdat cookies
}

src_install() {
	insinto /usr/share/fortune
	doins prolinux prolinux.dat || die
}
