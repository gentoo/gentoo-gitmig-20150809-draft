# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSLeay/Net-SSLeay-1.12-r1.ebuild,v 1.2 2002/07/25 04:13:27 seemant Exp $

S=${WORKDIR}/Net_SSLeay.pm-${PV}
DESCRIPTION="Net::SSLeay module for perl"
SRC_URI="http://www.cpan.org/authors/id/SAMPO/Net_SSLeay.pm-${PV}.tar.gz"
SLOT="0"

SLOT="0"
DEPEND="virtual/glibc >=sys-devel/perl-5 dev-libs/openssl"
LICENSE="Artistic | GPL-2"
SLOT="0"

src_compile() {
	OPTIMIZE="$CFLAGS" perl Makefile.PL /usr
	make || die
}

src_install () {
	eval `perl '-V:installarchlib'`
	mkdir -p ${D}/$installarchlib

	make \
		PREFIX=${D}/usr \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		install || die

	dodoc ChangeLog MANIFEST README ToDo
}
