# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-MakeMaker/ExtUtils-MakeMaker-6.20.ebuild,v 1.6 2004/01/09 22:00:01 gustavoz Exp $

DESCRIPTION="MakeMaker Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/ExtUtils/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/ExtUtils/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 sparc ~ppc ~alpha mips hppa ~arm ppc64"

DEPEND=">=dev-lang/perl-5.8.0-r12 >=sys-apps/sed-4"

src_compile() {
	perl Makefile.PL INSTALLDIRS=vendor DESTDIR="${D}" ${myconf} || die
}

src_install () {
	perlinfo
	dodir ${POD_DIR}

	test -z ${mytargets} && mytargets="install"
	make \
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

	for FILE in `find ${D} -type f -name "*.html" -o -name ".packlist"`; do
		sed -ie "s:${D}:/:g" ${FILE}
	done

	dodoc Change* MANIFEST* README* ${mydoc}
}

pkg_setup() {

	perlinfo
}


pkg_preinst() {

	perlinfo
}

pkg_postinst() {

	updatepod
}

pkg_prerm() {

	updatepod
}

pkg_postrm() {

	updatepod
}

perlinfo() {

	if [ -f /usr/bin/perl ]
	then
		eval `perl '-V:installarchlib'`
		eval `perl '-V:installsitearch'`
		eval `perl '-V:installvendorarch'`
		eval `perl '-V:installvendorlib'`
		ARCH_LIB=${installarchlib}
		SITE_LIB=${installsitearch}
		VENDOR_ARCH=${installvendorarch}
		VENDOR_LIB=${installvendorlib}

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

		#cat ${POD_DIR}/*.pod.arch >> ${ARCH_LIB}/perllocal.pod
		#cat ${POD_DIR}/*.pod.site >> ${SITE_LIB}/perllocal.pod
		#rm -f ${POD_DIR}/*.pod.site
		#rm -f ${POD_DIR}/*.pod.site
	fi
}
