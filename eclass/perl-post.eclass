# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/perl-post.eclass,v 1.1 2002/05/05 07:00:38 seemant Exp $
# The perl-post eclass is designed to allow the ${installarchdir}/perllocal.pod
# file to be updated cleanly after perl and/or perl-modules are installed
# or removed.
ECLASS=perl
EXPORT_FUNCTIONS pkg_postinst pkg_postrm

TMP_VERSION=`perl '-V:version'`
POD_DIR="/usr/share/${version}/gentoo-pods"


perl_pkg_postinst() {

	eval `perl '-V:installarchlib'`
	if [ -d "${POD_DIR}" ]
	then
		for i in `ls ${POD_DIR}`
		do
			if [ -f "${i}" ]
			then
				cat ${i} > ${installarchlib}/perllocal.pod
			fi
		done
	fi
}

perl_pkg_postrm() {

	eval `perl '-V:installarchlib'`
	if [ -d "${POD_DIR}" ]
	then
		for i in ${POD_DIR}/*.pod
		do
			if [ -f "${i}" ] 
			then
				cat ${i} > ${installarchlib}/perllocal.pod
			fi
		done
	fi
}
