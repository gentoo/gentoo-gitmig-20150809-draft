# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/gcc-config-1.4.0.ebuild,v 1.3 2005/06/17 20:38:59 wolf31o2 Exp $

inherit toolchain-funcs

# Version of .c wrapper to use
W_VER="1.4.6"

DESCRIPTION="Utility to change the gcc compiler being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="-*"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
#KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}

src_compile() {
	$(tc-getCC) -O2 -Wall -o gcc-config-wrapper \
		${FILESDIR}/wrapper-${W_VER}.c || die "compile wrapper"
}

src_install() {
	newbin ${FILESDIR}/${PN}-${PV} ${PN} || die "install gcc-config"
	dosed "s:PORTAGE-VERSION:${PVR}:" /usr/bin/${PN}

	exeinto /usr/lib/misc
	doexe gcc-config-wrapper || die "install wrapper"
}

pkg_postinst() {
	[[ -f ${ROOT}/etc/env.d/05gcc ]] && mv ${ROOT}/etc/env.d/05gcc ${ROOT}/etc/env.d/05gcc-${CHOST}
	[[ -f ${ROOT}/etc/env.d/05gcc- ]] && rm ${ROOT}/etc/env.d/05gcc-
	[[ -f ${ROOT}/etc/env.d/gcc/config ]] && mv ${ROOT}/etc/env.d/gcc/config ${ROOT}/etc/env.d/gcc/config-${CHOST}
	[[ -f ${ROOT}/etc/env.d/gcc/config- ]] && rm ${ROOT}/etc/env.d/gcc/config-

	# Do we have a valid multi ver setup ?
	if gcc-config --get-current-profile &>/dev/null ; then
		# We not longer use the /usr/include/g++-v3 hacks, as
		# it is not needed ...
		[[ -L ${ROOT}/usr/include/g++ ]] && rm -f "${ROOT}"/usr/include/g++
		[[ -L ${ROOT}/usr/include/g++-v3 ]] && rm -f "${ROOT}"/usr/include/g++-v3
		[[ ${ROOT} = "/" ]] && gcc-config $(/usr/bin/gcc-config --get-current-profile)
	fi

	# Make sure old versions dont exist #79062
	rm -f "${ROOT}"/usr/sbin/gcc-config
}
