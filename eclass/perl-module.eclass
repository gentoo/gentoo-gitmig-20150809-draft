# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-module.eclass,v 1.47 2003/07/25 18:27:31 rac Exp $
#
# Author: Seemant Kulleen <seemant@gentoo.org>
#
# The perl-module eclass is designed to allow easier installation of perl
# modules, and their incorporation into the Gentoo Linux system.

ECLASS=perl-module
INHERITED="${INHERITED} ${ECLASS}"

EXPORT_FUNCTIONS pkg_setup pkg_preinst pkg_postinst pkg_prerm pkg_postrm \
	src_compile src_install src_test \
	perlinfo updatepod

eval `perl '-V:version'`
newdepend ">=dev-lang/perl-5.6.1-r12"
SRC_PREP="no"

SITE_LIB=""
ARCH_LIB=""
POD_DIR=""

perl-module_src_prep() {

	SRC_PREP="yes"
	if [ "${style}" == "builder" ]; then
		perl ${S}/Build.PL destdir=${D}
	else
		perl Makefile.PL ${myconf} \
		PREFIX=${D}/usr
	fi

}

perl-module_src_compile() {

	[ "${SRC_PREP}" != "yes" ] && perl-module_src_prep
	if [ "${style}" != "builder" ]; then
		make ${mymake} || die "compilation failed"
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
	eval `perl '-V:installsitearch'`
	SITE_ARCH=${installsitearch}
	eval `perl '-V:installarchlib'`
	ARCH_LIB=${installarchlib}
					 
	if [ "${style}" == "builder" ]; then
		perl ${S}/Build install
	else
	make \
		PREFIX=${D}/usr \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLMAN2DIR=${D}/usr/share/man/man2 \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLMAN4DIR=${D}/usr/share/man/man4 \
		INSTALLMAN5DIR=${D}/usr/share/man/man5 \
		INSTALLMAN6DIR=${D}/usr/share/man/man6 \
		INSTALLMAN7DIR=${D}/usr/share/man/man7 \
		INSTALLMAN8DIR=${D}/usr/share/man/man8 \
		INSTALLSITEMAN1DIR=${D}/usr/share/man/man1 \
		INSTALLSITEMAN2DIR=${D}/usr/share/man/man2 \
		INSTALLSITEMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLSITEMAN4DIR=${D}/usr/share/man/man4 \
		INSTALLSITEMAN5DIR=${D}/usr/share/man/man5 \
		INSTALLSITEMAN6DIR=${D}/usr/share/man/man6 \
		INSTALLSITEMAN7DIR=${D}/usr/share/man/man7 \
		INSTALLSITEMAN8DIR=${D}/usr/share/man/man8 \
		INSTALLSITEARCH=${D}/${SITE_ARCH} \
		INSTALLSCRIPT=${D}/usr/bin \
		${myinst} \
		${mytargets} || die
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

	dodoc Change* MANIFEST* README* ${mydoc}
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
		eval `perl '-V:installarchlib'`
		eval `perl '-V:installsitearch'`
		ARCH_LIB=${installarchlib}
		SITE_LIB=${installsitearch}

		eval `perl '-V:version'`
		POD_DIR="/usr/share/perl/gentoo-pods/${version}"
	fi

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
