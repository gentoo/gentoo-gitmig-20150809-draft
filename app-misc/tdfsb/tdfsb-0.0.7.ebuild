# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tdfsb/tdfsb-0.0.7.ebuild,v 1.1 2002/12/21 01:15:52 zhen Exp $

DESCRIPTION="SDL based graphical file browser"
HOMEPAGE="http://www.hgb-leipzig.de/~leander/TDFSB/"
SRC_URI="http://www.hgb-leipzig.de/~leander/TDFSB/${P}.tar.gz"
LICENSE="GPL"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND=">=libsdl-1.2.5
		>=sdl-image-1.2.2
		>=glut-3.7.1"

RDEPEND=""
S=${WORKDIR}/${P}

src_compile() {
		
		./compile.sh

}

src_install() {
	
	dobin tdfsb || die
	dodoc README || die
}
