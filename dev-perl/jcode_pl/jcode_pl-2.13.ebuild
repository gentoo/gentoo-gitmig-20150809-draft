# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/jcode_pl/jcode_pl-2.13.ebuild,v 1.1 2003/06/30 14:14:10 yakina Exp $

DESCRIPTION="Japanese Kanji code converter for Perl"
SRC_URI="http://srekcah.org/jcode/${P/_/.}"
HOMEPAGE="http://srekcah.org/jcode/"
LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/glibc"
RDEPEND=">=dev-lang/perl-5"
S=${WORKDIR}/${P}
IUSE=""

src_unpack() {
	mkdir -p ${S}
	cd ${S}
	cp ${DISTDIR}/${A} jcode.pl
}

src_install () {
	insinto /usr/lib/perl5/site_perl
	doins jcode.pl
}
