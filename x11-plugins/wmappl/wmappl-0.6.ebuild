# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmappl/wmappl-0.6.ebuild,v 1.3 2003/09/06 05:56:25 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Simple application launcher for the Window Maker dock."
SRC_URI="http://www.upl.cs.wisc.edu/~charkins/wmappl/${P}.tar.gz"
HOMEPAGE="http://www.pobox.com/~charkins/wmappl.html"

DEPEND="virtual/x11"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

src_compile() {
	emake || die
}

src_install () {
	dobin wmappl
	dodoc README LICENSE CHANGELOG sample.wmapplrc
	insinto /usr/share/icons/wmappl
	doins icons/*
}
