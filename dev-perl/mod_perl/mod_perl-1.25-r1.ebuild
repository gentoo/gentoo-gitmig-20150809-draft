# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mod_perl/mod_perl-1.25-r1.ebuild,v 1.1 2002/03/27 10:27:42 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for Apache"
SRC_URI="http://perl.apache.org/dist/${P}.tar.gz"
HOMEPAGE="http://perl.apache.org"

DEPEND="virtual/glibc
	>=dev-perl/libwww-perl-5.48
	>=net-www/apache-1.3"

src_compile() {

	perl Makefile.PL USE_APXS=1 \
	WITH_APXS=/usr/sbin/apxs EVERYTHING=1
	cp Makefile Makefile.orig
	sed -e "s:apxs_install doc_install:doc_install:" Makefile.orig > Makefile
	emake || die
}

src_install () {

	make \
		PREFIX=${D}/usr	\
		INSTALLMAN3DIR=${D}/usr/share/man/man3	\
		install || die

	cd apaci 
	insinto /usr/lib/apache
	doins libperl.so
	cd ${S}
	dodoc Changes CREDITS MANIFEST README SUPPORT ToDo
	dohtml -r ./
}
