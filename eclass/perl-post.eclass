# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-post.eclass,v 1.2 2002/05/05 08:05:32 seemant Exp $
# The perl-post eclass is designed to allow the ${installarchdir}/perllocal.pod
# file to be updated cleanly after perl and/or perl-modules are installed
# or removed.
ECLASS=perl
EXPORT_FUNCTIONS pkg_preinst pkg_postinst pkg_prerm pkg_postrm perlinfo


perl_pkg_preinst() {
	
	perlinfo
}

perl_pkg_postinst() {

	perlinfo

	if [ -d "${POD_DIR}" ]
	then
		for i in `ls ${POD_DIR}`
		do
			if [ -f "${i}" ]
			then
				cat ${i} > ${ARCH_LIB}/perllocal.pod
			fi
		done
	fi
}

perl_pkg_prerm() {
	
	perlinfo
}

perl_pkg_postrm() {
	
	perlinfo
	
	einfo ${POD_DIR}
	
	if [ -d "${POD_DIR}" ]
	then
		for i in ${POD_DIR}/*.pod
		do
			if [ -f "${i}" ] 
			then
				cat ${i} > ${ARCH_LIB}/perllocal.pod
			fi
		done
	fi
}


perl_perlinfo() {

	TMP_VERSION="`if [ -f /usr/bin/perl ] ; then perl '-V:version' ; fi`"
	ARCH_LIB="`if [ -f /usr/bin/perl ] ; then perl '-V:installarchlib' ; fi`"
	POD_DIR="/usr/share/perl/gentoo-pods/${version}"

}
