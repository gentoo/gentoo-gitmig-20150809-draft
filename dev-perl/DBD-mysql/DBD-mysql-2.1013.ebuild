# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.1013.ebuild,v 1.1 2002/09/19 21:20:35 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBD:mysql Module"
SRC_URI="http://www.cpan.org/authors/id/JWIED/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="${DEPEND}
	dev-perl/DBI
	dev-db/mysql"

mydoc="ToDo"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile.PL Makefile.PL.orig
	patch -p0 <${FILESDIR}/makemaker.patch
}

