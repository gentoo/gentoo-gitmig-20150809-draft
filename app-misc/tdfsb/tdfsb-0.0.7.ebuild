# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tdfsb/tdfsb-0.0.7.ebuild,v 1.9 2004/07/18 15:32:46 aliz Exp $

IUSE=""

DESCRIPTION="SDL based graphical file browser"
HOMEPAGE="http://www.hgb-leipzig.de/~leander/TDFSB/"
SRC_URI="http://www.hgb-leipzig.de/~leander/TDFSB/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc -sparc alpha ~amd64"

DEPEND="media-libs/smpeg
	media-libs/sdl-image
	media-libs/glut"

src_unpack() {
	unpack ${A}

	sed -i "s:-O2 -march=i586:${CFLAGS}:" ${S}/compile.sh
}

src_compile() {
	./compile.sh
}

src_install() {
	dobin tdfsb || die
	dodoc README || die
}
