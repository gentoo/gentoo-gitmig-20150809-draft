# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mod_perl/mod_perl-1.27.ebuild,v 1.4 2002/07/25 05:23:36 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for Apache"
SRC_URI="http://perl.apache.org/dist/${P}.tar.gz"
HOMEPAGE="http://perl.apache.org"

SLOT="0"
LICENSE="Apache-1.1 as-is"
KEYWORDS="x86"

DEPEND="sys-devel/perl
	>=net-www/apache-1.3.24-r1"

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

	dodoc Changes CREDITS MANIFEST README SUPPORT ToDo
	dohtml -r ./

	cd apaci
	exeinto /usr/lib/apache-extramodules
	doexe libperl.so
}

pkg_postinst() {
	einfo
	einfo "Execute ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to have your apache.conf auto-updated for use with this module."
	einfo "You should then edit your /etc/conf.d/apache file to suit."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/libperl.so mod_perl.c perl_module \
		define=PERL

	:;
}
