# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-headers/freebsd-headers-6.0.ebuild,v 1.1 2006/04/01 16:43:50 flameeyes Exp $

inherit bsdmk freebsd toolchain-funcs

DESCRIPTION="FreeBSD system headers"
SLOT="0"
KEYWORDS="~x86-fbsd"

IUSE=""

SRC_URI="mirror://gentoo/${INCLUDE}.tar.bz2
	mirror://gentoo/${SYS}.tar.bz2
	mirror://gentoo/${ETC}.tar.bz2"

RDEPEND=""
DEPEND="=sys-freebsd/freebsd-mk-defs-${RV}*"

PROVIDE="virtual/os-headers"

RESTRICT="nostrip"

S=${WORKDIR}/include

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} && ${CATEGORY/cross-} != ${CATEGORY} ]]; then
	export CTARGET=${CATEGORY/cross-}
fi

src_compile() {
	$(freebsd_get_bmake) CC=$(tc-getCC) || die "make failed"
}

src_install() {
	[[ ${CTARGET} == ${CHOST} ]] \
		&& INCLUDEDIR="/usr/include" \
		|| INCLUDEDIR="/usr/${CTARGET}/include"

	$(freebsd_get_bmake) install DESTDIR="${D}" INCLUDEDIR="${INCLUDEDIR}" || die "Install failed"
}
