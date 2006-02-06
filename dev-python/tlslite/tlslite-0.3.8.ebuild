# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tlslite/tlslite-0.3.8.ebuild,v 1.1 2006/02/06 19:47:37 sbriesen Exp $

inherit eutils distutils portability

DESCRIPTION="TLS Lite is a free python library that implements SSL 3.0 and TLS 1.0/1.1"
HOMEPAGE="http://trevp.net/tlslite/"
SRC_URI="http://trevp.net/tlslite/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc gmp"

DEPEND="virtual/python"
RDEPEND="${DEPEND}
	|| (
		dev-python/cryptlib_py
		dev-python/m2crypto
		dev-python/pycrypto
	)
	gmp? ( dev-python/gmpy )"

PYTHON_MODNAME="tlslite"

src_install(){
	DOCS="readme.txt"
	distutils_src_install
	if use doc; then
		cd docs && treecopy . "${D}/usr/share/doc/${PF}/html"
	fi
}
