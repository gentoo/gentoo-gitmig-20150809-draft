# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/gcc-config-1.3.5.ebuild,v 1.4 2004/04/24 07:56:31 vapier Exp $

W_VER="1.4.2"

DISABLE_GEN_GCC_WRAPPERS="yes"

DESCRIPTION="Utility to change the gcc compiler being used."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64 ~sparc ~mips ~alpha arm ~hppa ~amd64 ~ia64 s390"
IUSE=""

DEPEND="virtual/glibc
	>=sys-apps/portage-2.0.47-r10" # We need portageq ...

src_install() {
	# Setup PATH just in case ...
	if /usr/bin/gcc-config --get-current-profile &> /dev/null
	then
		if [ -x /usr/bin/gcc-config ]
		then
			export PATH="`/usr/bin/gcc-config --get-bin-path`:${PATH}"
		else
			export PATH="`/usr/sbin/gcc-config --get-bin-path`:${PATH}"
		fi
	fi

	einfo "Compiling wrapper..."
	${CC:-gcc} -O2 -Wall -o ${WORKDIR}/wrapper \
		${FILESDIR}/wrapper-${W_VER}.c || die

	exeinto /usr/lib/gcc-config
	doexe ${WORKDIR}/wrapper || die

	# Only setup this if we have a proper gcc version installed, else
	# we will nuke the non gcc-config versions ...
	if /usr/bin/gcc-config --get-current-profile &> /dev/null
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
	if [ "${ARCH}" = "amd64" ]
	then
		newbin ${FILESDIR}/${PN}-${PV}-multi-ldpath ${PN}
	else
		newbin ${FILESDIR}/${PN}-${PV} ${PN}
	fi
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
