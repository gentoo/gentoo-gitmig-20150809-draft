# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart/Chart-0.99.3_pre3.ebuild,v 1.3 2002/04/27 10:34:23 seemant Exp $

MY_P=${PN}-0.99c-pre3
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Chart Module"
SRC_URI="http://www.cpan.org/modules/by-module/Chart/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Chart/${MY_P}.readme"

DEPEND=">=dev-perl/GD-1.19
	>=sys-devel/perl-5"

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

	dodoc TODO MANIFEST README

}
