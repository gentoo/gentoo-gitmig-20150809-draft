# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/epstool/epstool-3.06.ebuild,v 1.6 2005/07/09 02:42:04 swegener Exp $

DESCRIPTION="Creates or extracts preview images in EPS files, fixes bounding boxes,converts to bitmaps."
HOMEPAGE="http://www.cs.wisc.edu/~ghost/gsview/epstool.htm"
SRC_URI="ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/ghostgum/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""
DEPEND="virtual/ghostscript"

src_compile() {
	make epstool || die
}

src_install() {
	dobin bin/epstool
	doman doc/epstool.1
	dohtml doc/epstool.htm doc/gsview.css
}
