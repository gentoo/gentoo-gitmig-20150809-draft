# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytables/pytables-1.4.ebuild,v 1.2 2007/05/05 08:53:44 lucass Exp $

NEED_PYTHON=2.2

inherit distutils

DESCRIPTION="Module for Python that use HDF5"
SRC_URI="mirror://sourceforge/pytables/${P}.tar.gz"
HOMEPAGE="http://pytables.sourceforge.net/"

DEPEND=">=sys-devel/gcc-3.2
	sci-libs/hdf5
	>=dev-python/numarray-1.0"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
LICENSE="as-is"
IUSE="doc examples"
DOCS="ANNOUNCE.txt RELEASE-NOTES.txt THANKS TODO.txt VERSION"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	if use doc; then
		cd doc

		dohtml -r html/*

		docinto text
		dodoc text/*

		insinto /usr/share/doc/${PF}
		doins -r usersguide.pdf scripts/
	fi
}
