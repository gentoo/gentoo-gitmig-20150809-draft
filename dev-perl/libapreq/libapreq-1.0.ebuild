# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libapreq/libapreq-1.0.ebuild,v 1.1 2002/04/28 04:42:19 g2boojum Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Apache Request Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/Apache/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/Apache/${P}.readme"

DEPEND="virtual/glibc >=sys-devel/perl-5
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



