# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-headers/freebsd-headers-6.0.ebuild,v 1.3 2006/04/19 00:30:45 flameeyes Exp $

inherit bsdmk freebsd toolchain-funcs

DESCRIPTION="FreeBSD system headers"
SLOT="0"
KEYWORDS="~x86-fbsd"

IUSE=""

SRC_URI="mirror://gentoo/${INCLUDE}.tar.bz2
	mirror://gentoo/${SYS}.tar.bz2
	mirror://gentoo/${ETC}.tar.bz2"

RDEPEND=""
DEPEND="=sys-freebsd/freebsd-mk-defs-${RV}*
	|| ( sys-apps/mtree sys-freebsd/freebsd-ubin )"

PROVIDE="virtual/os-headers"

RESTRICT="nostrip"

S=${WORKDIR}/include

src_unpack() {
	freebsd_src_unpack

	[[ -n $(install --version 2> /dev/null | grep GNU) ]] && sed -i -e 's:${INSTALL} -C:${INSTALL}:' ${S}/Makefile
}

src_compile() {
	$(freebsd_get_bmake) CC=$(tc-getCC) || die "make failed"
}

src_install() {
	CTARGET=${CTARGET:-${CHOST}}
	if [[ ${CTARGET} == ${CHOST} && ${CATEGORY/cross-} != ${CATEGORY} ]]; then
		CTARGET=${CATEGORY/cross-}
	fi

	[[ ${CTARGET} == ${CHOST} ]] \
		&& INCLUDEDIR="/usr/include" \
		|| INCLUDEDIR="/usr/${CTARGET}/include"

	einfo "Installing for ${CTARGET} in ${CHOST}.."

	dodir "${INCLUDEDIR}"
	$(freebsd_get_bmake) installincludes \
		MACHINE=$(tc-arch-kernel) \
		DESTDIR="${D}" INCLUDEDIR="${INCLUDEDIR}" || die "Install failed"
}
