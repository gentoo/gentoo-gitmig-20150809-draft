# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mod_perl/mod_perl-1.24.1.ebuild,v 1.1 2000/11/11 13:38:18 achim Exp $

P=mod_perl-1.24
A=${P}_01.tar.gz
S=${WORKDIR}/${P}_01
CATEGORY="dev-perl"
DESCRIPTION="A Perl Modul for Apache"
SRC_URI="http://perl.apache.org/dist/${A}"
HOMEPAGE="http://perl.apache.org"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-perl/libwww-perl-5.48
	>=dev-perl/HTML-Parser-3.13
	>=dev-perl/URI-1.09
	>=net-www/apache-ssl-1.3"

src_compile() {

    cd ${S}
    perl Makefile.PL USE_APXS=1 \
	WITH_APXS=/usr/sbin/apxs EVERYTHING=1
    cp Makefile Makefile.orig
    sed -e "s:apxs_install doc_install:doc_install:" Makefile.orig > Makefile
    try make
#    cd src/modules/perl
#    apxs -c -I /usr/lib/perl5/5.6.0/i686-linux-thread-multi/CORE mod_perl.c
}

src_install () {

    cd ${S}
    try make PREFIX=${D}/usr install
    cd apaci 
    insinto /usr/lib/apache
    doins libperl.so
    cd ${S}
    dodoc Changes CREDITS MANIFEST README SUPPORT ToDo
    dodoc faq/*.txt
    docinto html
    dodoc apache-modlist.html
    dodoc htdocs/manual/mod/mod_perl.html
    

}



