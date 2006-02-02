# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cabocha/cabocha-0.53.ebuild,v 1.1 2006/02/02 22:48:09 usata Exp $

inherit perl-module

DESCRIPTION="Yet Another Japanese Dependency Structure Analyzer"
HOMEPAGE="http://chasen.org/~taku/software/cabocha/"
SRC_URI="http://chasen.org/~taku/software/cabocha/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

IUSE="perl"
#IUSE="python ruby"

DEPEND="app-text/yamcha
	|| ( app-text/chasen app-text/mecab )"
#RDEPEND=""

src_compile() {
	econf || die
	emake || die

	if use perl ; then
		cd perl
		perl-module_src_compile || die
	fi
}

src_test() {
	make check || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS README TODO

	if use perl ; then
		cd perl
		perl-module_src_install || die
	fi
}
