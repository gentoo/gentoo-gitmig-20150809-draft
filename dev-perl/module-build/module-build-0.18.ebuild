# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/module-build/module-build-0.18.ebuild,v 1.1 2003/06/26 17:25:49 mcummings Exp $

inherit perl-module

MY_P="Module-Build-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Build and install Perl modules"
SRC_URI="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~arm ~hppa ~mips ~ppc ~sparc"

DEPEND="dev-perl/module-info"


src_compile() {
	SRC_PREP="no"
	perl ${S}/Build.PL destdir=${D}
}
src_test() {
	perl ${S}/Build  test
}

src_install() {
    perlinfo
    dodir ${POD_DIR}

    test -z ${mytargets} && mytargets="install"
    eval `perl '-V:installsitearch'`
    SITE_ARCH=${installsitearch}
    eval `perl '-V:installarchlib'`
	ARCH_LIB=${installarchlib}
	perl ${S}/Build install


	if [ -f ${D}${ARCH_LIB}/perllocal.pod ];
	then
		touch ${D}/${POD_DIR}/${P}.pod
		sed -e "s:${D}::g" \ 
		${D}${ARCH_LIB}/perllocal.pod >>${D}/${POD_DIR}/${P}.pod
		touch ${D}/${POD_DIR}/${P}.pod.arch
		cat ${D}/${POD_DIR}/${P}.pod >>${D}/${POD_DIR}/${P}.pod.arch
	rm -f ${D}/${ARCH_LIB}/perllocal.pod
	fi
	if [ -f ${D}${SITE_LIB}/perllocal.pod ]
	then
		touch ${D}/${POD_DIR}/${P}.pod
		sed -e "s:${D}::g" \
			${D}${SITE_LIB}/perllocal.pod >> ${D}/${POD_DIR}/${P}.pod
		touch ${D}/${POD_DIR}/${P}.pod.site
		cat ${D}/${POD_DIR}/${P}.pod >>${D}/${POD_DIR}/${P}.pod.site
		rm -f ${D}/${SITE_LIB}/perllocal.pod
	fi

	for FILE in `find ${D} -type f -name "*.html" -o -name ".packlist"`; do
		sed -i -e "s:${D}:/:g" ${FILE}
	done
	dodoc Change* MANIFEST* README* ${mydoc}
}
