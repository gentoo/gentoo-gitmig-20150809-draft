# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/default/linux/sparc/experimental/multilib/profile.bashrc,v 1.1 2008/12/31 16:05:15 bluebird Exp $

if [[ "${EBUILD_PHASE}" == "setup" ]]
then
	if [[ ! "${I_READ_THE_MULTILIB_MIGRATION_GUIDE}" == "yes" ]]
	then
		ewarn "When migrating to the new sparc mutlilib profile please keep in mind that it is"
		ewarn "still in an experimental state. Also note that you need to follow the migration"
		ewarn "guide [0], otherwise important packages such as gcc or glibc will fail to"
		ewarn "compile and most other packages will be installed incorrectly."
		ewarn ""
		ewarn "[0] http://sparc.gentoo.org/multilib.xml"
		echo
	fi
fi
