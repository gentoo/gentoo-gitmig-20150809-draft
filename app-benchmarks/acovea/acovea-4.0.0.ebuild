# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/acovea/acovea-4.0.0.ebuild,v 1.1 2004/05/07 17:16:37 aliz Exp $

DESCRIPTION="Analysis of Compiler Options via Evolutionary Algorithm"
HOMEPAGE="http://www.coyotegulch.com/acovea/"
SRC_URI="http://www.coyotegulch.com/acovea/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-libs/libcoyotl
	dev-libs/libevocosm
	dev-libs/expat"

src_install() {
	make DESTDIR=${D} install
	dodoc ChangeLog NEWS README
}
