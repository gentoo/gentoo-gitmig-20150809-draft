# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libctl/libctl-3.0.3.ebuild,v 1.4 2011/06/21 15:13:10 jlec Exp $

inherit fortran-2

DESCRIPTION="Guile-based library for scientific simulations"
HOMEPAGE="http://ab-initio.mit.edu/libctl/"
SRC_URI="http://ab-initio.mit.edu/libctl/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE="examples"

DEPEND="
	virtual/fortran
	>=dev-scheme/guile-1.6"
RDEPEND="${DEPEND}"

src_compile() {
	econf --enable-shared
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc NEWS AUTHORS ChangeLog
	use examples && doins -r examples
}
