# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libxml-perl/libxml-perl-0.07.ebuild,v 1.7 2002/04/27 11:09:16 seemant Exp $

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Collection of Perl modules for working with XML"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/XML-Parser-2.29"

src_compile() {

	perl Makefile.PL 
	make || die
	make test

}

src_install () {

	make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die
	dodoc README ChangeLog Changes
}
