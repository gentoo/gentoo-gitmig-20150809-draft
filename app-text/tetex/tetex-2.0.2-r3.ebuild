# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-2.0.2-r3.ebuild,v 1.19 2004/10/23 06:01:40 mr_bones_ Exp $

inherit tetex eutils flag-o-matic

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"

KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 ppc-macos"
IUSE=""

src_unpack() {
	tetex_src_unpack
	epatch ${FILESDIR}/${PN}-no-readlink-manpage.diff
}

src_compile() {
	use amd64 && replace-flags "-O3" "-O2"
	tetex_src_compile
}
