# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclperl/tclperl-2.5.ebuild,v 1.3 2004/10/17 10:13:53 dholm Exp $

DESCRIPTION="a Perl package for Tcl"
HOMEPAGE="http://jfontain.free.fr/tclperl.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/tcl-8.0
	dev-lang/perl"

src_compile() {
	${CC} -shared -o tclperl.so.${PV} -fPIC ${CFLAGS} -Wall tclperl.c `perl -MExtUtils::Embed -e ccopts -e ldopts` || die
}

src_install() {
	insinto /usr/lib/tclperl
	doins tclperl.so.${PV}
	doins pkgIndex.tcl

	dodoc CHANGES INSTALL README
	dohtml tclperl.htm
}
