# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libwww-perl/libwww-perl-5.48.ebuild,v 1.2 2000/09/15 20:08:51 drobbins Exp $

P=libwww-perl-5.48
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A collection of Perl Modules for the WWW"
SRC_URI="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/WWW/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/15_World_Wide_Web_HTML_HTTP_CGI/WWW/${P}.readme"


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



