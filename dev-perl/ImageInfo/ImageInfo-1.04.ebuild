# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageInfo/ImageInfo-1.04.ebuild,v 1.4 2002/04/27 10:42:10 seemant Exp $

MY_P=Image-Info-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Image-Info Module"
SRC_URI="http://www.cpan.org/modules/by-module/Image/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Image/${MY_P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/IO-String-1.01"


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

	dodoc ChangeLog MANIFEST README ToDo
}
