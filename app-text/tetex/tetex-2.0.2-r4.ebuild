# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-2.0.2-r4.ebuild,v 1.3 2004/11/07 10:22:17 usata Exp $

inherit tetex eutils flag-o-matic

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"

KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 ppc-macos"
IUSE=""

src_compile() {
	use amd64 && replace-flags "-O3" "-O2"
	tetex_src_compile
}

src_install() {
	insinto /usr/share/texmf/tex/latex/greek
	doins ${FILESDIR}/iso-8859-7.def
	tetex_src_install
}
