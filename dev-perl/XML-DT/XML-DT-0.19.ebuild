# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.19.ebuild,v 1.3 2002/04/27 11:01:08 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A perl XML down translate module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/XML-Parser-2.29"

src_unpack() {

	unpack $A
	cd ${S}
	cp DT.pm DT.pm.orig
#	sed -e "s:(C<-type)):(C<-type>):" DT.pm.orig > DT.pm
}
src_compile() {

	perl Makefile.PL
	make || die
	make test || die

}

src_install () {

	make \
		PREFIX=${D}/usr \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		install || die

	dodoc Changes README MANIFEST
	dohtml DT.html
}
