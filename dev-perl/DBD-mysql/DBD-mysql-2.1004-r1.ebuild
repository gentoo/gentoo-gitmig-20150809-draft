# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.1004-r1.ebuild,v 1.1 2002/05/04 02:45:39 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBD:mysql Module"
SRC_URI="http://www.cpan.org/authors/id/JWIED/${P}.tar.gz"

DEPEND="virtual/glibc >=sys-devel/perl-5 dev-perl/DBI dev-db/mysql"
LICENSE="Artistic | GPL-2"
SLOT="0"

src_compile() {
	perl Makefile.PL
	make || die
}

src_install () {
	make \
	PREFIX=${D}/usr \
	INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	INSTALLMAN1DIR=${D}/usr/share/man/man1 \
	install || die

	dodoc ChangeLog MANIFEST README ToDo
}
