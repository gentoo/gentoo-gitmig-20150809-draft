# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-module.eclass,v 1.34 2003/03/11 21:26:32 seemant Exp $
#
# Author: Seemant Kulleen <seemant@gentoo.org>
#
# The perl-module eclass is designed to allow easier installation of perl
# modules, and their incorporation into the Gentoo Linux system.

#first inherit the pkg_postinst() and pkg_postrm() functions
inherit perl-post

ECLASS=perl-module
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_compile src_install src_test

eval `perl '-V:version'`
DEPEND="dev-lang/perl
	>=dev-perl/ExtUtils-MakeMaker-6.05-r1
	${DEPEND}"
SRC_PREP="no"

perl-module_src_prep() {

	SRC_PREP="yes"
	perl Makefile.PL ${myconf} \
	PREFIX=${D}/usr 
}

perl-module_src_compile() {

	[ "${SRC_PREP}" != "yes" ] && perl-module_src_prep
	make ${mymake} || die "compilation failed"
}

perl-module_src_test() {
	make test
}

perl-module_src_install() {
	
	perl-post_perlinfo
	dodir ${POD_DIR}
	
	test -z ${mytargets} && mytargets="install"
	eval `perl '-V:installsitearch'`
	SITE_ARCH=${installsitearch}
	eval `perl '-V:installarchlib'`
	ARCH_LIB=${installarchlib}
					 
	
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

	dodoc Change* MANIFEST* README* ${mydoc}
}
