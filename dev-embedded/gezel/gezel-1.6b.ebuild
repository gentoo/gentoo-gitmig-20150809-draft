# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gezel/gezel-1.6b.ebuild,v 1.2 2007/03/25 16:53:13 calchan Exp $

inherit eutils

DESCRIPTION="GEZEL is a language and open environment for exploration, simulation and implementation of domain-specific micro-architectures."
HOMEPAGE="http://www.ee.ucla.edu/~schaum/gezel/"
SRC_URI="http://www.ee.ucla.edu/~schaum/gezel/package/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-libs/gmp"

src_unpack() {
	unpack ${A}

	# Fix for bug #151566
	sed -i -e '/^%option c++/ i\
%option noyywrap' ${S}/gezel/fdl.ll
	sed -i -e '/^istream & operator >> (istream &is, gval &v);/ i\
gval * make_gval(unsigned _wordlength, unsigned _sign);\
gval * make_gval(char *);\
gval * make_gval(unsigned _wordlength, unsigned _sign, char *valuestr);\
' ${S}/gezel/gval.h
}

src_compile() {
	econf --enable-gezel51 || die 'configure failed'
	# other config options failing for various reasons
	# --enable-armcosim (compile failure) --enable-systemccosim (missing gmp lib symbol) failing for unknown reasons
	emake || die 'compile failed'
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS NEWS README TODO doc/*.*
	docinto umlistings
	dodoc doc/umlistings/*
}
