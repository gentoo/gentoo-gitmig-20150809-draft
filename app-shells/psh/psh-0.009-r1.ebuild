# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/psh/psh-0.009-r1.ebuild,v 1.2 2002/07/07 12:00:29 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Combines the interactive nature of a Unix shell with the power of Perl"
SRC_URI="http://www.focusresearch.com/gregor/psh/${P}.tar.gz"
HOMEPAGE="http://www.focusresearch.com/gregor/psh/"
LICENSE="Artistic | GPL-2"

DEPEND=">=sys-devel/perl-5"

src_compile() {
	perl Makefile.PL

	make || die
}

src_install() {
	make PREFIX=${D}/usr						\
	     prefix=${D}/usr						\
	     INSTALLMAN3DIR=${D}/usr/share/man/man3			\
	     install || die

	dodoc COPYRIGHT HACKING MANIFEST README* RELEASE TODO
	dodoc examples/complete-examples
}








