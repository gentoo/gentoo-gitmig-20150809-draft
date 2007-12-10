# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tlslite/tlslite-0.3.8.ebuild,v 1.4 2007/12/10 01:05:12 sbriesen Exp $

inherit eutils distutils

DESCRIPTION="TLS Lite is a free python library that implements SSL 3.0 and TLS 1.0/1.1"
HOMEPAGE="http://trevp.net/tlslite/"
SRC_URI="http://trevp.net/tlslite/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gmp"

DEPEND="virtual/python"
RDEPEND="${DEPEND}
	dev-python/cryptlib_py
	|| (
		dev-python/m2crypto
		dev-python/pycrypto
	)
	gmp? ( dev-python/gmpy )"

PYTHON_MODNAME="tlslite"

src_install(){
	DOCS="readme.txt"
	distutils_src_install
	use doc && dohtml -r docs/.
}
