# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-module.eclass,v 1.64 2004/08/02 18:45:37 rac Exp $
#
# Author: Seemant Kulleen <seemant@gentoo.org>
# Maintained by the Perl herd <perl@gentoo.org>
#
# The perl-module eclass is designed to allow easier installation of perl
# modules, and their incorporation into the Gentoo Linux system.

ECLASS=perl-module
INHERITED="${INHERITED} ${ECLASS}"

EXPORT_FUNCTIONS pkg_setup pkg_preinst pkg_postinst pkg_prerm pkg_postrm \
	src_compile src_install src_test \
	perlinfo updatepod

# 2004.05.10 rac
# block on makemaker versions earlier than that in the 5.8.2 core. in
# actuality, this should be handled in the perl ebuild, so every perl
# ebuild should block versions of MakeMaker older than the one it
# carries. in the meantime, since we have dumped support for MakeMaker
# <6.11 and the associated broken DESTDIR handling, block here to save
# people from sandbox trouble.
#
# 2004.05.25 rac
# for the same reasons, make the perl dep >=5.8.2 to get everybody
# with 5.8.0 and its 6.03 makemaker up to a version that can
# understand DESTDIR

DEPEND=">=dev-lang/perl-5.8.2 !<dev-perl/ExtUtils-MakeMaker-6.17"
SRC_PREP="no"
SRC_TEST="skip"

PERL_VERSION=""
SITE_ARCH=""
SITE_LIB=""
ARCH_LIB=""
POD_DIR=""

perl-module_src_prep() {

	perlinfo

	export PERL_MM_USE_DEFAULT=1

	SRC_PREP="yes"
	if [ "${style}" == "builder" ]; then
		perl ${S}/Build.PL installdirs=vendor destdir=${D}
	else
		perl Makefile.PL ${myconf} \
		PREFIX=/usr INSTALLDIRS=vendor DESTDIR=${D}
	fi
}

perl-module_src_compile() {

	[ "${SRC_PREP}" != "yes" ] && perl-module_src_prep
	if [ "${style}" != "builder" ]; then
		make ${mymake} || die "compilation failed"
	fi

	if [ "${SRC_TEST}" == "do" ]; then
		perl-module_src_test || die "test failed"
		SRC_TEST="done"
	fi
}

perl-module_src_test() {
	if [ "${style}" == "builder" ]; then
		perl ${S}/Build  test
	else
		make test
	fi
}

perl-module_src_install() {
	
	perlinfo
	dodir ${POD_DIR}
	
	test -z ${mytargets} && mytargets="install"
					 
	if [ "${style}" == "builder" ]; then
		perl ${S}/Build install
	else
		make ${myinst} ${mytargets} || die
	fi

	if [ -f ${D}${ARCH_LIB}/perllocal.pod ];
	then
		touch ${D}/${POD_DIR}/${P}.pod
		sed -e "s:${D}::g" \
			${D}${ARCH_LIB}/perllocal.pod >> ${D}/${POD_DIR}/${P}.pod
		touch ${D}/${POD_DIR}/${P}.pod.arch
		cat ${D}/${POD_DIR}/${P}.pod >>${D}/${POD_DIR}/${P}.pod.arch
		rm -f ${D}/${ARCH_LIB}/perllocal.pod
	fi
	
	if [ -f ${D}${SITE_LIB}/perllocal.pod ];
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

	for doc in Change* MANIFEST* README*; do
		[ -s "$doc" ] && dodoc $doc
	done
	dodoc ${mydoc}
}


perl-module_pkg_setup() {

	perlinfo
}


perl-module_pkg_preinst() {
	
	perlinfo
}

perl-module_pkg_postinst() {

	updatepod
}

perl-module_pkg_prerm() {
	
	updatepod
}

perl-module_pkg_postrm() {

	updatepod
}

perlinfo() {

	if [ -f /usr/bin/perl ]
	then 
		POD_DIR="/usr/share/perl/gentoo-pods/${version}"
	fi
	eval `perl '-V:version'`
	PERL_VERSION=${version}
	eval `perl '-V:installsitearch'`
	SITE_ARCH=${installsitearch}
	eval `perl '-V:installarchlib'`
	ARCH_LIB=${installarchlib}
	eval `perl '-V:installarchlib'`
	ARCH_LIB=${installarchlib}
	eval `perl '-V:installsitearch'`
	SITE_LIB=${installsitearch}
}

updatepod() {
	perlinfo

	if [ -d "${POD_DIR}" ]
	then
		for FILE in `find ${POD_DIR} -type f -name "*.pod.arch"`; do
		   cat ${FILE} >> ${ARCH_LIB}/perllocal.pod
		   rm -f ${FILE}
		done
		for FILE in `find ${POD_DIR} -type f -name "*.pod.site"`; do
		   cat ${FILE} >> ${SITE_LIB}/perllocal.pod
		   rm -f ${FILE}
		done
	fi
}
