# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycryptopp/pycryptopp-0.5.29.ebuild,v 1.2 2012/02/20 14:45:32 patrick Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-*"
DISTUTILS_SRC_TEST="setup.py"
DISTUTILS_GLOBAL_OPTIONS=("2.*-cpython --disable-embedded-cryptopp")

inherit distutils

DESCRIPTION="Python wrappers for a few algorithms from the Crypto++ library"
HOMEPAGE="http://tahoe-lafs.org/trac/pycryptopp http://pypi.python.org/pypi/pycryptopp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/crypto++"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="NEWS.rst"

src_prepare() {
	# Don't install license files
	sed -i -e "/data_files=data_files,/d" setup.py || die
}
