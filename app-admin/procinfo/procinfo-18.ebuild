# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/procinfo/procinfo-18.ebuild,v 1.4 2002/07/16 02:34:51 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A utility to prettyprint /proc/*"
SRC_URI="ftp://ftp.cistron.nl/pub/people/svm/${P}.tar.gz"
HOMEPAGE="ftp://ftp.cistron.nl/pub/people/svm/"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	sys-libs/ncurses"

RDEPEND="sys-devel/perl"

KEYWORDS="x86 ppc"

src_compile() {

    # -ltermcap is default and isn't available in gentoo
    # but -lncurses works just as good
    emake LDLIBS=-lncurses || die
}

src_install () {

    dobin procinfo
    newbin lsdev.pl lsdev
    newbin socklist.pl socklist
    
    doman *.8
    dodoc README CHANGES
}
