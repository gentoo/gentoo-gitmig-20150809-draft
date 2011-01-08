# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cloog/cloog-0.16.1.ebuild,v 1.1 2011/01/08 06:05:23 dirtyepic Exp $

EAPI="3"

inherit autotools-utils

DESCRIPTION="A loop generator for scanning polyhedra"
HOMEPAGE="http://www.bastoul.net/cloog/index.php"
#SRC_URI="http://www.bastoul.net/cloog/pages/download/${P}.tar.gz"
SRC_URI="ftp://gcc.gnu.org/pub/gcc/infrastructure/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="dev-libs/gmp
	>=dev-libs/isl-0.05.1
	!<dev-libs/cloog-ppl-0.15.10"
RDEPEND="${DEPEND}"

DOCS=( README doc/cloog.pdf )

src_configure() {
	myeconfargs=(
		--with-isl=system
		--with-polylib=no
		)
	autotools-utils_src_configure
}
