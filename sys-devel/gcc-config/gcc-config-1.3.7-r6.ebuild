# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/gcc-config-1.3.7-r6.ebuild,v 1.1 2004/12/08 23:47:13 vapier Exp $

inherit toolchain-funcs

# Version of .c wrapper to use
W_VER="1.4.2"

DESCRIPTION="Utility to change the gcc compiler being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/portage-2.0.47-r10" # We need portageq ...

S=${WORKDIR}

src_compile() {
	$(tc-getCC) -O2 -Wall -o wrapper \
		${FILESDIR}/wrapper-${W_VER}.c || die "compile wrapper"
}

src_install() {
	newbin ${FILESDIR}/${PN}-${PV} ${PN} || die "install gcc-config"
	dosed "s:PORTAGE-VERSION:${PVR}:" /usr/bin/${PN}

	exeinto /usr/lib/gcc-config
	doexe wrapper || die "install wrapper"
}

pkg_postinst() {
	# Do we have a valid multi ver setup ?
	if gcc-config --get-current-profile &> /dev/null
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
			gcc-config $(/usr/bin/gcc-config --get-current-profile)
		fi
	fi
}
