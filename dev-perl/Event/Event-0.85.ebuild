# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Matthew Kennedy <mkennedy@gentoo.org>
# Author: phoen][x <eqc_phoenix@gmx.de>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-0.85.ebuild,v 1.1 2002/04/21 23:02:23 mkennedy Exp $

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Event Module"
SRC_URI="http://www.cpan.org/modules/by-module/Event/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Event/${P}.readme"

DEPEND=">=sys-devel/perl-5"

src_compile() {
	perl Makefile.PL
	make || die
}

src_install () {
	make PREFIX=${D}/usr \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die
	dodoc ANNOUNCE ChangeLog INSTALL README TODO Tutorial.pdf
}
