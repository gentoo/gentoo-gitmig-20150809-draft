# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/URI/URI-1.08.ebuild,v 1.2 2000/09/15 20:08:50 drobbins Exp $

P=URI-1.08
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/URI/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/URI/${P}.readme"


src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    try make 
    try make test
}

src_install () {

    cd ${S}
    try make install
    prepman
    dodoc Changes MANIFEST README rfc2396.txt

}







