# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyelemental/pyelemental-1.2.0.ebuild,v 1.5 2012/05/04 15:12:15 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="Python bindings for libelemental (sci-chemistry/gelemental)"
HOMEPAGE="http://www.kdau.com/projects/gelemental"
SRC_URI="http://www.kdau.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=sci-chemistry/gelemental-1.2.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS"

src_install() {
	distutils_src_install
	dohtml docs/html/*.html || die "dohtml failed"
}
