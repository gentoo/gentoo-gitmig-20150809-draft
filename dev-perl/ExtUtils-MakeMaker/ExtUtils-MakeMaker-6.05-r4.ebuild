# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-MakeMaker/ExtUtils-MakeMaker-6.05-r4.ebuild,v 1.8 2003/05/30 13:41:34 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="MakeMaker Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/ExtUtils/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/ExtUtils/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 sparc ppc alpha mips hppa arm"

DEPEND=">=dev-lang/perl-5.6.1-r10"

src_compile() {
	perl Makefile.PL ${myconf} PREFIX=${D}/usr || die
}

src_install () {
	perlinfo
	dodir ${POD_DIR}
		        
	test -z ${mytargets} && mytargets="install"
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
		${myinst} \
		${mytargets} || die

	if [ -f ${D}${ARCH_LIB}/perllocal.pod ];
	then
		touch ${D}/${POD_DIR}/${P}.pod
		sed -e "s:${D}::g" ${D}${ARCH_LIB}/perllocal.pod \
			>> ${D}/${POD_DIR}/${P}.pod
		touch ${D}/${POD_DIR}/${P}.pod.arch
		cat ${D}/${POD_DIR}/${P}.pod >>${D}/${POD_DIR}/${P}.pod.arch
		rm -f ${D}/${ARCH_LIB}/perllocal.pod
	fi
	if [ -f ${D}${SITE_LIB}/perllocal.pod ];
	then
		touch ${D}/${POD_DIR}/${P}.pod
		sed -e "s:${D}::g" ${D}${SITE_LIB}/perllocal.pod \
			>> ${D}/${POD_DIR}/${P}.pod
		touch ${D}/${POD_DIR}/${P}.pod.site
		cat ${D}/${POD_DIR}/${P}.pod >>${D}/${POD_DIR}/${P}.pod.site
		rm -f ${D}/${SITE_LIB}/perllocal.pod
	fi
	dodoc Change* MANIFEST* README* ${mydoc}								 
}
