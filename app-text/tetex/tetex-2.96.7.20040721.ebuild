# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-2.96.7.20040721.ebuild,v 1.1 2004/10/17 12:30:14 usata Exp $

inherit tetex eutils flag-o-matic

TETEX_TEXMF_PV=2.96.5.20040711
S=${WORKDIR}/tetex-src-beta-${PV}

TETEX_SRC="tetex-src-beta-${TETEX_SRC_PV:-${TETEX_PV}}.tar.gz"
TETEX_TEXMF="tetex-texmf-beta-${TETEX_TEXMF_PV:-${TETEX_PV}}.tar.gz"
TETEX_TEXMF_SRC="tetex-texmfsrc-beta-${TETEX_TEXMF_PV:-${TETEX_PV}}.tar.gz"

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"

SRC_PATH_TETEX=ftp://cam.ctan.org/tex-archive/systems/unix/teTeX-beta
SRC_URI="${SRC_PATH_TETEX}/${TETEX_SRC}
	${SRC_PATH_TETEX}/${TETEX_TEXMF}
	${SRC_PATH_TETEX}/${TETEX_TEXMF_SRC}"

KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~ppc-macos"
IUSE=""

pkg_setup() {
	ewarn
	ewarn "teTeX-beta ebuild will remove config files stored in /usr/share/texmf."
	ewarn "Please make a backup before upgrading if you changed anything."
	ewarn

	ebeep
	epause
}

src_compile() {
	use amd64 && replace-flags "-O3" "-O2"
	tetex_src_compile
}

src_install() {
	tetex_src_install base doc fixup link
}
