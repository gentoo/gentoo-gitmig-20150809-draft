# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/epix/epix-1.0.20.ebuild,v 1.1 2006/11/09 14:43:11 markusle Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="2- and 3-D plotter for creating images (to be used in LaTeX)"
HOMEPAGE="http://mathcs.holycross.edu/~ahwang/current/ePiX.html"
SRC_URI="http://mathcs.holycross.edu/~ahwang/epix/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/tetex"

RDEPEND="app-shells/bash
		>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -e 's:doc/${PACKAGE_TARNAME}:doc/${PACKAGE_TARNAME}-${PACKAGE_VERSION}:' \
	-i configure || die "sed on configure failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
