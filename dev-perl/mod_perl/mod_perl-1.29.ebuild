# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mod_perl/mod_perl-1.29.ebuild,v 1.5 2004/04/16 10:31:11 mr_bones_ Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for Apache"
SRC_URI="http://perl.apache.org/dist/${P}.tar.gz"
HOMEPAGE="http://perl.apache.org"

SLOT="0"
LICENSE="Apache-1.1 as-is"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc alpha ia64"

DEPEND="dev-lang/perl dev-perl/libwww-perl =net-www/apache-1* >=sys-apps/sed-4"

IUSE="ipv6"

src_unpack() {
	unpack ${A}

	if has_version '>=apache-1.3.27-r4' && use ipv6; then
		# This patch originally came from
		# http://pasky.ji.cz/~pasky/dev/apache/mod_perl-1.27+ipv6.patch.
		# It allows mod_perl to correctly build with an IPv6-enabled
		# Apache (bug #6986).
		# Robert Coie <rac@gentoo.org> 2002.02.19

		cd ${S}; epatch ${FILESDIR}/${P}-ipv6.patch
	fi

	cd ${S}
	for f in "apaci/mod_perl.config.sh" "apaci/libperl.module"
	do
		echo "tail -1 fix in ${f}"
		sed -i -e "s/tail -1/tail -n1/" ${f}
	done
}

src_compile() {
	perl Makefile.PL USE_APXS=1 \
		INSTALLDIRS=vendor \
		WITH_APXS=/usr/sbin/apxs EVERYTHING=1 PERL_DEBUG=1

	cp Makefile Makefile.orig
	sed -e "s:apxs_install doc_install:doc_install:" Makefile.orig > Makefile
	emake || die
}

src_install () {
	eval `perl '-V:installvendorarch'`
	eval `perl '-V:installvendorlib'`

	make \
		PREFIX=${D}/usr	\
		INSTALLVENDORARCH=${D}/${installvendorarch}	\
		INSTALLVENDORLIB=${D}/${installvendorlib}	\
		INSTALLVENDORMAN1DIR=${D}/usr/share/man/man1	\
		INSTALLVENDORMAN3DIR=${D}/usr/share/man/man3	\
		pure_vendor_install || die

	dodoc Changes CREDITS MANIFEST README SUPPORT ToDo
	dohtml -r ./
	# The following kludge is from the perl-module eclass to correct
	# the packlist file. packlist is used by other apps to determine
	# where to find parts of mod-perl
	for FILE in `find ${D} -type f -name "*.html" -o -name ".packlist"`; do
		sed -i -e "s:${D}:/:g" ${FILE}
	done


	cd apaci
	exeinto /usr/lib/apache-extramodules
	doexe libperl.so
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
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
