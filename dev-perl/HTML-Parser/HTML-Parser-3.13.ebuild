# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Parser/HTML-Parser-3.13.ebuild,v 1.2 2000/11/01 06:27:09 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A HTML parser Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/HTML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/HTML/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=sys-libs/glibc-2.1.3
	>=dev-perl/HTML-Tagset-3.02"

src_compile() {

    cd ${S}
    cp ${FILESDIR}/Makefile.PL .
    perl Makefile.PL $PERLINSTALL
    try make 
    try make test
}

src_install () {

    cd ${S}
    try make install
    prepman
    dodoc ANNOUNCEMENT Changes MANIFEST README TODO

}







