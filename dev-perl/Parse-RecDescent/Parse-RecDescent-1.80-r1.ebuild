# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-RecDescent/Parse-RecDescent-1.80-r1.ebuild,v 1.1 2002/03/27 12:40:38 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Parse/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Parse/${P}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {

	perl Makefile.PL 
	emake || die
	make test || die

}

src_install () {

	make \
		PREFIX=${D}/usr	\
		INSTALLMAN3DIR=${D}/usr/share/man/man3	\
		install || die
	dodoc Changes README MANIFEST
	dohtml -r tutorial
}
