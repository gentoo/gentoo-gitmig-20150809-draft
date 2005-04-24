# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/boost-jam/boost-jam-3.1.4.ebuild,v 1.8 2005/04/24 12:42:24 hansmi Exp $

DESCRIPTION="Boost.Jam - an alternative to make based on Jam."
HOMEPAGE="http://www.boost.org/tools/build/jam_src/index.html"
SRC_URI="mirror://sourceforge/boost/boost-jam-${PV}.tgz"
RESTRICT="nomirror"

LICENSE="as-is"
SLOT="0"

KEYWORDS="x86 ppc"
IUSE=""

DEPEND="dev-libs/boost
	!dev-util/jam"

src_compile() {
	./build.sh
}

src_install() {
	cd ${S}/bin.linux${ARCH}

	dobin bjam jam mkjambase yyacc
}
