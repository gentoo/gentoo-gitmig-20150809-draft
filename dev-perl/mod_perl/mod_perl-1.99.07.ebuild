# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mod_perl/mod_perl-1.99.07.ebuild,v 1.2 2002/12/17 20:27:16 lostlogic Exp $

DESCRIPTION="An embedded Perl interpreter for Apache2"
HOMEPAGE="http://perl.apache.org/"

NEWP="${PN}-1.99_07"
S=${WORKDIR}/${NEWP}
SRC_URI="mirror://gentoo/${NEWP}.tar.bz2"
DEPEND="sys-devel/perl =net-www/apache-2*"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
SLOT="1"

src_compile() {
	perl Makefile.PL \
		PREFIX=${D}/usr \
		MP_TRACE=1 \
		MP_DEBUG=1 \
		MP_AP_PREFIX=/usr \
		MP_USE_DSO=1 \
		MP_INST_APACHE2=1 \
		MP_APXS=/usr/sbin/apxs2  \
		CCFLAGS="${CFLAGS} -fPIC" \
		INSTALLDIRS=vendor </dev/null || die

	emake || die
	#make test
}

src_install() {
	dodir /usr/lib/apache2-extramodules
	make install \
		MODPERL_AP_LIBEXECDIR=${D}/usr/lib/apache2-extramodules \
		MP_INST_APACHE2=1 \
		INSTALLDIRS=vendor || die

	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/75_mod_perl.conf \
		${FILESDIR}/apache2-mod_perl-startup.pl

	dodoc ${FILESDIR}/75_mod_perl.conf Changes \
		INSTALL LICENSE README STATUS
	cp -a docs ${D}/usr/share/doc/${PF}
	cp -a todo ${D}/usr/share/doc/${PF}
}
