# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/gcc-config-1.3.6-r3.ebuild,v 1.4 2004/10/28 15:53:08 vapier Exp $

inherit toolchain-funcs

# Version of .c wrapper to use
W_VER="1.4.2"

DISABLE_GEN_GCC_WRAPPERS="yes"

GCC_CONFIG_BIN="${ROOT}/usr/bin/gcc-config"
DESCRIPTION="Utility to change the gcc compiler being used."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/portage-2.0.47-r10" # We need portageq ...

pkg_setup() {
	if [ -x "${GCC_CONFIG_BIN}" ]
	then
		# Make sure while we have write access that everything is setup Ok ...
		${GCC_CONFIG_BIN} --get-current-profile &> /dev/null
	fi
}

src_install() {
	local gcc_bin_path="$(${GCC_CONFIG_BIN} --get-bin-path)"

	# Setup PATH just in case ...
	if ${GCC_CONFIG_BIN} --get-current-profile &> /dev/null
	then
		if [ -x "${GCC_CONFIG_BIN}" ]
		then
			export PATH="`${GCC_CONFIG_BIN} --get-bin-path`:${PATH}"
		else
			export PATH="`${GCC_CONFIG_BIN} --get-bin-path`:${PATH}"
		fi
	fi

	einfo "Compiling wrapper..."
	$(tc-getCC) -O2 -Wall -o ${WORKDIR}/wrapper \
		${FILESDIR}/wrapper-${W_VER}.c || die

	exeinto /usr/lib/gcc-config
	doexe ${WORKDIR}/wrapper || die

	# Only setup this if we have a proper gcc version installed, else
	# we will nuke the non gcc-config versions ...
	if ${GCC_CONFIG_BIN} --get-current-profile &> /dev/null
	then
		einfo "Creating wrappers for compiler tools..."
		exeinto /lib
		newexe ${WORKDIR}/wrapper cpp

		exeinto /usr/bin
		for x in gcc cpp cc c++ g++ f77 gcj \
		         ${CHOST}-gcc ${CHOST}-c++ ${CHOST}-g++ ${CHOST}-f77 ${CHOST}-gcj
		do
			# Make sure we only install wrappers for those present ...
			[ -x "${gcc_bin_path}/${x}" -o \
			  "${x}" = "c++" -o "${x}" = "${REAL_CHOST}-c++" -o \
			  "${x}" = "cpp" -o "${x}" = "cc" ] && \
				newexe ${WORKDIR}/wrapper ${x}
		done
	fi

	einfo "Installing gcc-config..."
	newbin ${FILESDIR}/${PN}-${PV} ${PN}
	dosed "s:PORTAGE-VERSION:${PV}:" /usr/bin/${PN}
}

pkg_postinst() {
	# Do we have a valid multi ver setup ?
	if ${GCC_CONFIG_BIN} --get-current-profile &> /dev/null
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
			${GCC_CONFIG_BIN} $(/usr/bin/gcc-config --get-current-profile)
		fi
	fi
}
