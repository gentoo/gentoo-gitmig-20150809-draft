# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-shells/psh/psh-0.008-r1.ebuild,v 1.5 2000/11/01 04:44:12 achim Exp $

P=psh-0.008
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Combines the interactive nature of a Unix shell with the power of Perl"
SRC_URI="http://www.focusresearch.com/gregor/psh/"${A}
HOMEPAGE="http://www.focusresearch.com/gregor/psh/"

DEPEND=">=sys-devel/perl-5"

src_compile() {                           
	cd ${S}
	perl Makefile.PL $PERLINSTALL
	try make 
}

src_install() {                               
	cd ${S}
	make prefix=${D}/usr install
	dodoc COPYRIGHT HACKING MANIFEST README* RELEASE TODO
	dodoc examples/complete-examples
	prepman
}







