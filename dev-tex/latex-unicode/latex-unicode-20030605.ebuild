# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex-unicode/latex-unicode-20030605.ebuild,v 1.1 2004/01/04 16:00:47 usata Exp $

inherit latex-package

DESCRIPTION="Unicode support for LaTeX"
HOMEPAGE="http://www.unruh.de/DniQ/latex/unicode/"
# Taken from
#SRC_URI="http://www.unruh.de/DniQ/latex/unicode/unicode.tgz"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P}.tar.gz"

LICENSE="LPPL-1.2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/tetex
	dev-tex/cjk-latex"

S=${WORKDIR}/ucs

src_install() {

	latex-package_src_doinstall
	pushd contrib
	latex-package_src_doinstall styles || die
	popd
	pushd data
	latex-package_src_doinstall styles || die
	popd

	insinto /usr/share/texmf/tex/latex/latex-unicode
	doins data/uninames.dat
	doins config/* contrib/cenccmn.tex

	dodoc FAQ README VERSION languages.ps.gz ltxmacrs.txt
}

pkg_postinst() {

	latex-package_pkg_postinst
	einfo
	einfo "Please refer to /usr/share/doc/${P}/README.gz"
	einfo "and languages.ps in that directory for language-specific examples."
	einfo
}
