# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk-800.022.ebuild,v 1.2 2002/04/27 11:11:13 seemant Exp $

MY_P=Tk800.022
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Perl Module for Tk"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Tk/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Tk/${MY_P}.readme"

DEPEND=">=sys-devel/perl-5
	virtual/x11"

src_compile() {

	perl Makefile.PL 
	make || die
#	make test || die

}

src_install () {

	make \
		PREFIX=${D}/usr \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		install || die

	dodoc Change.log Changes COPYING README* MANIFEST*
	dodoc ToDo VERSIONS
}
