# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tetex/tetex-2.0.2-r6.ebuild,v 1.2 2005/04/05 17:09:57 usata Exp $

inherit tetex-2 flag-o-matic

DESCRIPTION="a complete TeX distribution"
HOMEPAGE="http://tug.org/teTeX/"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~ppc-macos ~s390 ~sparc ~x86"
IUSE=""

src_unpack() {
	tetex-2_src_unpack

	# bug 75801
	EPATCH_OPTS="-d ${S}/libs/xpdf/xpdf -p0" epatch ${FILESDIR}/xpdf-CESA-2004-007-xpdf2-newer.diff
	EPATCH_OPTS="-d ${S}/libs/xpdf -p1" epatch ${FILESDIR}/xpdf-goo-sizet.patch
	EPATCH_OPTS="-d ${S}/libs/xpdf -p1" epatch ${FILESDIR}/xpdf2-underflow.patch
	EPATCH_OPTS="-d ${S}/libs/xpdf/xpdf -p0" epatch ${FILESDIR}/xpdf-3.00pl2-CAN-2004-1125.patch
	EPATCH_OPTS="-d ${S}/libs/xpdf/xpdf -p0" epatch ${FILESDIR}/xpdf-3.00pl3-CAN-2005-0064.patch
	EPATCH_OPTS="-d ${S} -p1" epatch ${FILESDIR}/xdvizilla.patch
}

src_compile() {
	use amd64 && replace-flags "-O3" "-O2"
	tetex_src_compile
}

src_install() {
	insinto /usr/share/texmf/tex/latex/greek
	doins ${FILESDIR}/iso-8859-7.def
	tetex-2_src_install
}
