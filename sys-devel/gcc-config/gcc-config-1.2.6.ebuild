# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/gcc-config-1.2.6.ebuild,v 1.1 2002/12/24 18:26:45 azarah Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Utility to change the gcc compiler being used."
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

KEYWORDS="x86 ppc sparc alpha"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"


src_install() {

	newsbin ${FILESDIR}/${PN}-${PV} ${PN}
}

pkg_postinst() {

	# Do we have a valid multi ver setup ?
	if ${ROOT}/usr/sbin/gcc-config --get-current-profile > /dev/null
	then
		# /usr/bin/cpp borks things if present ...
		if [ -L ${ROOT}/usr/bin/cpp -o -f ${ROOT}/usr/bin/cpp ]
		then
			rm -f ${ROOT}/usr/bin/cpp
		fi

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
			/usr/sbin/gcc-config $(/usr/sbin/gcc-config --get-current-profile)
		fi
	fi
}

