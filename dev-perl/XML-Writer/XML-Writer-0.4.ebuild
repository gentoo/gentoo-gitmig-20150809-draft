# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Writer/XML-Writer-0.4.ebuild,v 1.1 2000/09/05 18:01:11 achim Exp $

P=XML-Writer-0.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="XML Writer Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"


src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    make
#    make test

}

src_install () {

    cd ${S}
    make install
    dodoc README MANIFEST Changes
}





