# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/jcode_pl/jcode_pl-2.13.ebuild,v 1.2 2003/08/07 02:26:01 vapier Exp $

DESCRIPTION="Japanese Kanji code converter for Perl"
HOMEPAGE="http://srekcah.org/jcode/"
SRC_URI="http://srekcah.org/jcode/${P/_/.}"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"
RDEPEND=">=dev-lang/perl-5"

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} jcode.pl
}

src_install() {
	insinto /usr/lib/perl5/site_perl
	doins jcode.pl
}
