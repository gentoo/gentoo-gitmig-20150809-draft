# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/epstool/epstool-3.02.ebuild,v 1.2 2003/08/25 09:08:49 phosphan Exp $

DESCRIPTION="Creates or extracts preview images in EPS files, fixes bounding boxes,converts to bitmaps."
HOMEPAGE="http://www.cs.wisc.edu/~ghost/gsview/epstool.htm"
SRC_URI="ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/ghostgum/${PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="app-text/ghostscript"

src_compile() {
	make epstool || die
}

src_install() {
	exeinto /usr/bin
	doexe epstool
	doman doc/epstool.1
	dohtml doc/epstool.htm doc/gsview.css
}
