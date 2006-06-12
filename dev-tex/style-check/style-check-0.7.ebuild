# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/style-check/style-check-0.7.ebuild,v 1.4 2006/06/12 19:47:11 blubb Exp $

IUSE=""

DESCRIPTION="Parses latex-formatted text in search of forbidden phrases"
HOMEPAGE="http://www.cs.umd.edu/~nspring/software/style-check-readme.html"
SRC_URI="http://www.cs.umd.edu/~nspring/software/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~x86"
DEPEND="virtual/ruby"

src_install() {
	dodir /etc/style-check.d
	make PREFIX=/usr DESTDIR=${D} install || die
	dodoc README
	dohtml README.html
}
