# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-2.1004.ebuild,v 1.1 2001/12/09 20:32:54 woodchip Exp

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBD:mysql Module"
SRC_URI="http://www.cs.kuleuven.ac.be/~pelov/pam/download/${P}.tar.gz"

DEPEND="virtual/glibc >=sys-devel/perl-5 sys-libs/pam"

src_compile() {

	OPTIMIZE="$CFLAGS" perl Makefile.PL
	make || die
}

src_install () {

	eval `perl '-V:installarchlib'`
	mkdir -p ${D}/$installarchlib

	perl Makefile.PL
	make \
		PREFIX=${D}/usr \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		install || die

	dodoc ChangeLog MANIFEST README ToDo
}
