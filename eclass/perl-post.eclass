# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-post.eclass,v 1.12 2003/06/02 10:01:15 mcummings Exp $
#
# Author: Seemant Kulleen <seemant@gentoo.org>
#
# The perl-post eclass is designed to allow the ${installarchdir}/perllocal.pod
# file to be updated cleanly after perl and/or perl-modules are installed
# or removed.

ECLASS=perl-post
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS pkg_setup pkg_preinst pkg_postinst pkg_prerm pkg_postrm \
	perlinfo updatepod

SITE_LIB=""
ARCH_LIB=""
POD_DIR=""


perl-post_pkg_setup() {

	perlinfo
}


perl-post_pkg_preinst() {
	
	perlinfo
}

perl-post_pkg_postinst() {

	updatepod
}

perl-post_pkg_prerm() {
	
	updatepod
}

perl-post_pkg_postrm() {

	updatepod
}

perl-post_perlinfo() {

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

perl-post_updatepod() {
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
