# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mod_perl/mod_perl-1.24.ebuild,v 1.2 2000/09/15 20:08:51 drobbins Exp $

P=mod_perl-1.24
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A Perl Modul for Apache"
SRC_URI="http://perl.apache.org/dist/${A}"
HOMEPAGE="http://perl.apache.org"


src_compile() {

    cd ${S}
    perl Makefile.PL NO_HTTPD=1 $PERLINSTALL
    try make
    cd src/modules/perl
    apxs -c -I /usr/lib/perl5/5.6.0/i686-linux/CORE mod_perl.c
}

src_install () {

    cd ${S}
    try make install
    prepman
    cd src/modules/perl
    insinto /usr/lib/apache
    doins mod_perl.so
    cd ${S}
    dodoc Changes CREDITS MANIFEST README SUPPORT ToDo
    dodoc faq/*.txt
    docinto html
    dodoc apache-modlist.html
    dodoc htdocs/manual/mod/mod_perl.html
    

}



