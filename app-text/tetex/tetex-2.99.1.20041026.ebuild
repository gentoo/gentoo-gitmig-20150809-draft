# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-2.99.1.20041026.ebuild,v 1.4 2004/11/11 23:19:43 vapier Exp $

inherit tetex eutils flag-o-matic

#TETEX_TEXMF_PV=2.96.5.20040711
TETEX_TEXMF_PV=${PV}
TEXMF_PATH=/var/lib/texmf
S=${WORKDIR}/tetex-src-beta-${PV}

TETEX_SRC="tetex-src-beta-${TETEX_SRC_PV:-${TETEX_PV}}.tar.gz"
TETEX_TEXMF="tetex-texmf-beta-${TETEX_TEXMF_PV:-${TETEX_PV}}.tar.gz"
TETEX_TEXMF_SRC="tetex-texmfsrc-beta-${TETEX_TEXMF_PV:-${TETEX_PV}}.tar.gz"

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"

SRC_PATH_TETEX=ftp://cam.ctan.org/tex-archive/systems/unix/teTeX-beta
SRC_URI="${SRC_PATH_TETEX}/${TETEX_SRC}
	${SRC_PATH_TETEX}/${TETEX_TEXMF}
	mirror://gentoo/${P}-gentoo.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P}-gentoo.tar.gz"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sparc ~x86"
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
