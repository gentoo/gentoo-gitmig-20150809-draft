# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/URI/URI-1.10.ebuild,v 1.2 2001/03/12 10:52:49 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A URI Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/URI/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/URI/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/MIME-Base64-2.11"

src_compile() {

    perl Makefile.PL 
    try make 
    make test
}

src_install () {

    try make PREFIX=${D}/usr install
    dodoc Changes MANIFEST README rfc2396.txt

}







