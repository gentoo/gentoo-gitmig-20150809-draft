# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Writer/XML-Writer-0.4.ebuild,v 1.6 2002/04/27 11:08:09 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XML Writer Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {

	perl Makefile.PL 
	make || die
#	make test || die

}

src_install () {

	make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die
	dodoc README MANIFEST Changes
}
