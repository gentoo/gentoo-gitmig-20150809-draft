# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/psh/psh-0.009.ebuild,v 1.1 2001/04/13 13:21:31 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Combines the interactive nature of a Unix shell with the power of Perl"
SRC_URI="http://www.focusresearch.com/gregor/psh/${A}"
HOMEPAGE="http://www.focusresearch.com/gregor/psh/"

DEPEND=">=sys-devel/perl-5"

src_compile() {

	perl Makefile.PL
	try make
}

src_install() {
	make PREFIX=${D}/usr prefix=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
	dodoc COPYRIGHT HACKING MANIFEST README* RELEASE TODO
	dodoc examples/complete-examples
}








