# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DB_File/DB_File-1.803.ebuild,v 1.14 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Berkeley DB Support Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/DB_File/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/DB_File/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	>=sys-libs/db-3.2"

mydoc="Changes"

src_compile() {

	cp ${FILESDIR}/config.in .
	perl-module_src_compile

}
