# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-2.99.1.20041026.ebuild,v 1.1 2004/10/28 11:58:22 usata Exp $

inherit tetex eutils flag-o-matic

#TETEX_TEXMF_PV=2.96.5.20040711
TETEX_TEXMF_PV=${PV}
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
IUSE="motif lesstif Xaw3d"

DEPEND="motif? ( lesstif? ( x11-libs/lesstif )
		!lesstif? ( x11-libs/openmotif ) )
	!motif? ( Xaw3d? ( x11-libs/Xaw3d ) )"

pkg_setup() {
	ewarn
	ewarn "teTeX-beta ebuild will remove config files stored in /usr/share/texmf."
	ewarn "Please make a backup before upgrading if you changed anything."
	ewarn

	ebeep
	epause
}

src_unpack() {
	tetex_src_unpack
	epatch ${FILESDIR}/${P}-etex.diff
}

src_compile() {
	use amd64 && replace-flags "-O3" "-O2"

	if use motif ; then
		if use lesstif ; then
			append-ldflags -L/usr/X11R6/lib/lesstif -R/usr/X11R6/lib/lesstif
			export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include/lesstif"
		fi
		toolkit="motif"
	elif use Xaw3d ; then
		toolkit="xaw3d"
	else
		toolkit="xaw"
	fi

	TETEX_ECONF="--with-x-toolkit=${toolkit}"

	tetex_src_compile
}

src_install() {
	tetex_src_install base doc fixup link
}
