# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-post.eclass,v 1.3 2002/05/05 10:38:16 seemant Exp $
# The perl-post eclass is designed to allow the ${installarchdir}/perllocal.pod
# file to be updated cleanly after perl and/or perl-modules are installed
# or removed.
ECLASS=perl
EXPORT_FUNCTIONS pkg_setup pkg_preinst pkg_postinst pkg_prerm \
	perlinfo updatepod

ARCH_LIB=""
POD_DIR=""


perl_pkg_setup() {

	perlinfo
}


perl_pkg_preinst() {
	
	perlinfo
}

perl_pkg_postinst() {

	updatepod
}

perl_pkg_prerm() {
	
	updatepod
}

perl_perlinfo() {

	if [ -f /usr/bin/perl ]
	then 
		eval `perl '-V:installarchlib'`
		ARCH_LIB=${installarchlib}

		eval `perl '-V:version'`
		POD_DIR="/usr/share/perl/gentoo-pods/${version}"
	fi

}

perl_updatepod() {
	
	( test -z ${ARCH_LIB} || test -z ${POD_DIR} ) && perlinfo
	
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
