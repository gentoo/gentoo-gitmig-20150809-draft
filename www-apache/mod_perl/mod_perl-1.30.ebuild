# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_perl/mod_perl-1.30.ebuild,v 1.3 2007/04/02 18:07:44 corsair Exp $

inherit eutils apache-module

DESCRIPTION="A Perl Module for Apache"
SRC_URI="http://perl.apache.org/dist/${P}.tar.gz"
HOMEPAGE="http://perl.apache.org"

SLOT="0"
LICENSE="Apache-1.1 as-is"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ppc64 ~sparc x86"

DEPEND="dev-lang/perl dev-perl/libwww-perl"
RDEPEND="${DEPEND}"

APACHE1_MOD_DEFINE="PERL"
APACHE1_MOD_CONF="${PV}/75_mod_perl"
APACHE1_MOD_FILE="${S}/apaci/libperl.so"

IUSE=""

need_apache1

src_unpack() {
	unpack ${A}

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
		WITH_APXS=${APXS1} EVERYTHING=1 PERL_DEBUG=1

	cp Makefile Makefile.orig
	sed -e "s:apxs_install doc_install:doc_install:" Makefile.orig > Makefile
	emake -j1 || die
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

	apache-module_src_install

	fperms 600 ${APACHE1_MODULES_CONFDIR}/$(basename ${APACHE1_MOD_CONF})
}
