# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclperl/tclperl-3.1.ebuild,v 1.2 2004/10/26 13:50:18 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="a Perl package for Tcl"
HOMEPAGE="http://jfontain.free.fr/tclperl.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/perl-5.6.0"

src_compile() {
	perl Makefile.PL || die
	make OPTIMIZE="${CFLAGS}" Tcl.o || die

	$(tc-getCC) -shared ${CFLAGS} -o tclperl.so.${PV} -fPIC -DUSE_TCL_STUBS \
		tclperl.c tclthread.c `perl -MExtUtils::Embed -e ccopts -e ldopts` \
		/usr/lib/libtclstub`echo 'puts $tcl_version' | tclsh`.a Tcl.o || die
}

src_install() {
	exeinto /usr/lib/tclperl
	doexe tclperl.so.${PV} || die "lib"
	doexe pkgIndex.tcl || die "tcl"

	dodoc CHANGES INSTALL README
	dohtml tclperl.htm
}
