# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/gcc-config-1.3.7-r1.ebuild,v 1.3 2004/11/12 17:05:01 vapier Exp $

inherit toolchain-funcs

# Version of .c wrapper to use
W_VER="1.4.2"

DISABLE_GEN_GCC_WRAPPERS="yes"

DESCRIPTION="Utility to change the gcc compiler being used."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/portage-2.0.47-r10" # We need portageq ...

src_install() {
	einfo "Installing gcc-config..."
	newbin ${FILESDIR}/${PN}-${PV} ${PN}
	dosed "s:PORTAGE-VERSION:${PV}:" /usr/bin/${PN}

	# Make sure we use the new version of gcc-config
	export PATH="${D}/usr/bin:${PATH}"

	einfo "Compiling wrapper..."
	$(tc-getCC) -O2 -Wall -o ${WORKDIR}/wrapper \
		${FILESDIR}/wrapper-${W_VER}.c || die

	exeinto /usr/lib/gcc-config
	doexe ${WORKDIR}/wrapper || die

	# Only setup this if we have a proper gcc version installed, else
	# we will nuke the non gcc-config versions ...
	if gcc-config --get-current-profile &> /dev/null
	then
		einfo "Creating wrappers for compiler tools..."
		exeinto /lib
		newexe ${WORKDIR}/wrapper cpp

		local gcc_bin_path="$(gcc-config --get-bin-path)"
		exeinto /usr/bin
		for x in gcc cpp cc c++ g++ f77 g77 gcj \
		         ${CHOST}-gcc ${CHOST}-c++ ${CHOST}-g++ \
		         ${CHOST}-f77 ${CHOST}-g77 ${CHOST}-gcj
		do
			# Make sure we only install wrappers for those present ...
			[ -x "${gcc_bin_path}/${x}" -o \
			  "${x}" = "c++" -o "${x}" = "${REAL_CHOST}-c++" -o \
			  "${x}" = "cpp" -o "${x}" = "cc" ] && \
				newexe ${WORKDIR}/wrapper ${x}
		done
	fi
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
