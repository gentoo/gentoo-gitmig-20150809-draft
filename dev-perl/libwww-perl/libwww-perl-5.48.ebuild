# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libwww-perl/libwww-perl-5.48.ebuild,v 1.3 2000/11/01 06:27:12 achim Exp $

P=libwww-perl-5.48
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A collection of Perl Modules for the WWW"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/WWW/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/WWW/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/libnet-1.0703
	>=dev-perl/HTML-Parser-3.13
	>=dev-perl/URI-1.0.9
	>=dev-perl/Digest-MD5-2.12"

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
    dodoc ChangeLog MANIFEST README* TODO

}



