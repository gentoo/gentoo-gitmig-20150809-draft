# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-tk/perl-tk800-022.ebuild,v 1.3 2000/11/01 06:27:12 achim Exp $

P=Tk800.022
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for Tk"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Tk/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Tk/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.1"

src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    try make
#    try make test

}

src_install () {

    cd ${S}
    try make install
    prepman
    dodoc Change.log Changes COPYING README* MANIFEST*
    dodoc ToDo VERSIONS
}





