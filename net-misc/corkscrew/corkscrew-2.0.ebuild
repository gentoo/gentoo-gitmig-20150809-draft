# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $

DESCRIPTION="Corkscrew is a tool for tunneling SSH through HTTP proxies."
HOMEPAGE="http://www.agroman.net/corkscrew/"
LICENSE="GPL-2"
DEPEND=""
KEYWORDS="~x86"
IUSE=""
SLOT="0"
SRC_URI="http://www.agroman.net/corkscrew/${P}.tar.gz"

src_compile() {
	econf
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
