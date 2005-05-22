# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cabocha/cabocha-0.52.ebuild,v 1.1 2005/05/22 16:54:31 usata Exp $

DESCRIPTION="Yet Another Japanese Dependency Structure Analyzer"
HOMEPAGE="http://chasen.org/~taku/software/cabocha/"
SRC_URI="http://chasen.org/~taku/software/cabocha/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
#IUSE="perl python ruby"

DEPEND="app-text/yamcha
	|| ( app-text/chasen app-text/mecab )"
#RDEPEND=""

src_test() {
	make check || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS README TODO
}
