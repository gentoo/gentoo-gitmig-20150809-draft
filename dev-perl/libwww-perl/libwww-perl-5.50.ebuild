# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libwww-perl/libwww-perl-5.50.ebuild,v 1.2 2001/05/03 16:38:58 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A collection of Perl Modules for the WWW"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/WWW/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/WWW/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/libnet-1.0703
	>=dev-perl/HTML-Parser-3.13
	>=dev-perl/URI-1.0.9
	>=dev-perl/Digest-MD5-2.12"

src_compile() {

    perl Makefile.PL
    try make
#    try make test
}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	INSTALLMAN1DIR=${D}/usr/share/man/man1 install
    dodoc ChangeLog MANIFEST README* TODO

}



