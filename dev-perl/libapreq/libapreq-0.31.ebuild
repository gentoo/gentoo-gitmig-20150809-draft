# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libapreq/libapreq-0.31.ebuild,v 1.3 2001/05/03 16:38:58 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Apache Request Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/Apache/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/Apache/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/mod_perl-1.25"

src_compile() {

    perl Makefile.PL
    try make
    try make test
}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc ChangeLog MANIFEST README* TODO

}



