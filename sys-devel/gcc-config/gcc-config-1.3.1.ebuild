# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/gcc-config-1.3.1.ebuild,v 1.9 2003/02/24 20:35:36 dragon Exp $

DISABLE_GEN_GCC_WRAPPERS="yes"

S="${WORKDIR}/${P}"
DESCRIPTION="Utility to change the gcc compiler being used."
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

KEYWORDS="x86 ppc ~sparc alpha mips hppa arm"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"


src_install() {

	# Setup PATH just in case ...
	if /usr/bin/gcc-config --get-current-profile &> /dev/null || \
	   /usr/sbin/gcc-config --get-current-profile &> /dev/null
	then
		if [ -x /usr/bin/gcc-config ]
		then
			export PATH="`/usr/bin/gcc-config --get-bin-path`:${PATH}"
		else
			export PATH="`/usr/sbin/gcc-config --get-bin-path`:${PATH}"
		fi
	fi

	einfo "Compiling wrapper..."
	gcc -O2 -Wall -o ${WORKDIR}/wrapper ${FILESDIR}/wrapper.c

	exeinto /usr/lib/gcc-config
	doexe ${WORKDIR}/wrapper

	# Only setup this if we have a proper gcc version installed, else
	# we will nuke the non gcc-config versions ...
	if /usr/bin/gcc-config --get-current-profile &> /dev/null || \
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
}

pkg_postinst() {

	# Do we have a valid multi ver setup ?
	if ${ROOT}/usr/bin/gcc-config --get-current-profile &> /dev/null
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
			/usr/bin/gcc-config $(/usr/bin/gcc-config --get-current-profile)
		fi
	fi
}

