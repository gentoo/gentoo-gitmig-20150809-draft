# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Writer/XML-Writer-0.4.ebuild,v 1.8 2002/07/25 04:13:27 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XML Writer Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

SLOT="0"
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
