# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmappl/wmappl-0.6.ebuild,v 1.7 2004/04/30 22:12:45 pvdabeel Exp $

IUSE=""
DESCRIPTION="Simple application launcher for the Window Maker dock."
SRC_URI="http://www.upl.cs.wisc.edu/~charkins/wmappl/${P}.tar.gz"
HOMEPAGE="http://www.pobox.com/~charkins/wmappl.html"

DEPEND="virtual/x11"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"

src_compile() {
	emake || die
}

src_install () {
	dobin wmappl
	dodoc README LICENSE CHANGELOG sample.wmapplrc
	insinto /usr/share/icons/wmappl
	doins icons/*
}
