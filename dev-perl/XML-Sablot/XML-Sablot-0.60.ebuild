# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-0.60.ebuild,v 1.2 2002/04/27 11:06:32 seemant Exp $

MY_P=${PN}ron-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Perl Module for Sablotron"
#SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/${A}"
#HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/xml-sab.act"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${MY_P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${PN}.${PV}.readme"

DEPEND=">=sys-devel/perl-5
	>=app-text/sablotron-0.60"

src_unpack() {

   unpack ${A}

}

src_compile() {

	perl Makefile.PL
	make || die
	make test || die

}

src_install () {

	make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die
	dodoc Changes README MANIFEST
}
