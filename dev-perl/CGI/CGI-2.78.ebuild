# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI/CGI-2.78.ebuild,v 1.2 2001/12/09 20:59:32 woodchip Exp $

S=${WORKDIR}/${PN}.pm-${PV}
DESCRIPTION="The Perl CGI Module"
SRC_URI="http://www.cpan.org/authors/id/LDS/${PN}.pm-${PV}.tar.gz"

DEPEND="virtual/glibc >=sys-devel/perl-5"

src_compile() {

	perl Makefile.PL
	make || die "possibly missing a DEPEND?"
}

src_install() {

	make \
	PREFIX=${D}/usr \
	INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	INSTALLMAN1DIR=${D}/usr/share/man/man1 \
	install || die

	dodoc ANNOUNCE Changes MANIFEST README
}
