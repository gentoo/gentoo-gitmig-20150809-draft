# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/suacomp/suacomp-0.4.ebuild,v 1.2 2010/07/13 15:13:17 mr_bones_ Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="library wrapping the interix lib-c to make it less buggy."
HOMEPAGE="http://dev.gentoo.org/~mduft/suacomp"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="BEER-WARE"
SLOT="0"
KEYWORDS="-* ~x86-interix"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	# no windows xp support for now (name of libc hardcoded!)
	[[ ${CHOST} == *-interix3* ]] && return 0;

	emake all CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	[[ ${CHOST} == *-interix3* ]] && return 0;

	# installing to EPREFIX (not EPREFIX/usr) intentionally, since this
	# falls into the category "low-level-system-library" :)
	emake install PREFIX="${EPREFIX}/usr" DESTDIR="${D}"
}
