# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/cc-config/cc-config-1.2.8.ebuild,v 1.5 2004/07/15 03:11:33 agriffis Exp $

DISABLE_GEN_GCC_WRAPPERS="yes"

DESCRIPTION="Utility to change the gcc compiler being used."
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

KEYWORDS="x86 ppc sparc alpha mips"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc"


src_install() {

	einfo "Compiling wrapper..."
	gcc -O2 -Wall -o ${WORKDIR}/wrapper ${FILESDIR}/wrapper.c

	exeinto /usr/lib/gcc-config
	doexe ${WORKDIR}/wrapper

	# Only setup this if we have a proper gcc version installed, else
	# we will nuke the non cc-config versions ...
	if /usr/bin/cc-config --get-current-profile &> /dev/null || \
	   /usr/sbin/gcc-config --get-current-profile &> /dev/null
	then
		einfo "Creating wrappers for compiler tools..."
		exeinto /lib
		newexe ${WORKDIR}/wrapper cpp

		exeinto /usr/bin
		for x in gcc cpp cc c++ g++ ${CHOST}-gcc ${CHOST}-c++ ${CHOST}-g++
		do
			newexe ${WORKDIR}/wrapper ${x}
		done
	fi

	einfo "Adding compat symlinks..."
	into /usr
	dodir /usr/sbin
	newbin ${FILESDIR}/${PN}-${PV} ${PN}
	dosym ../bin/${PN} /usr/sbin/${PN}
	dosym ../bin/${PN} /usr/sbin/gcc-config
}

pkg_postinst() {

	# Do we have a valid multi ver setup ?
	if ${ROOT}/usr/bin/cc-config --get-current-profile &> /dev/null
	then
		# We not longer use the /usr/include/g++-v3 hacks, as
		# it is not needed ...
		if [ -L ${ROOT}/usr/include/g++ ]
		then
			rm -f ${ROOT}/usr/include/g++
		fi
		if [ -L ${ROOT}/usr/include/g++-v3 ]
		then
			rm -f ${ROOT}/usr/include/g++-v3
		fi

		if [ ${ROOT} = "/" ]
		then
			/usr/bin/cc-config $(/usr/bin/cc-config --get-current-profile)
		fi
	fi
}
