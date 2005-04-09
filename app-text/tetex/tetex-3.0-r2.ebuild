# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-3.0-r2.ebuild,v 1.1 2005/04/09 03:18:46 usata Exp $

inherit tetex-3 flag-o-matic

#TETEX_TEXMF_PV=2.96.5.20040711
TETEX_TEXMF_PV=${PV}
S=${WORKDIR}/tetex-src-${PV}

TETEX_SRC="tetex-src-${TETEX_SRC_PV:-${TETEX_PV}}.tar.gz"
TETEX_TEXMF="tetex-texmf-${TETEX_TEXMF_PV:-${TETEX_PV}}.tar.gz"
#TETEX_TEXMF_SRC="tetex-texmfsrc-${TETEX_TEXMF_PV:-${TETEX_PV}}.tar.gz"
TETEX_TEXMF_SRC=""

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"

SRC_PATH_TETEX=ftp://cam.ctan.org/tex-archive/systems/unix/teTeX/current/distrib
SRC_URI="${SRC_PATH_TETEX}/${TETEX_SRC}
	${SRC_PATH_TETEX}/${TETEX_TEXMF}
	mirror://gentoo/${P}-gentoo.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P}-gentoo.tar.gz"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~ppc-macos ~s390 ~sparc ~x86"

# these are defined in tetex.eclass and tetex-3.eclass
IUSE=""
DEPEND=""

src_install() {
	tetex-3_src_install

	# virtex was removed from tetex-3
	dosym /usr/bin/tex /usr/bin/virtex
	dosym /usr/bin/pdftex /usr/bin/pdfvirtex
}
