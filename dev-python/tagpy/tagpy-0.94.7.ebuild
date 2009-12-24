# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tagpy/tagpy-0.94.7.ebuild,v 1.1 2009/12/24 22:05:29 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python Bindings for TagLib"
HOMEPAGE="http://mathema.tician.de//software/tagpy http://pypi.python.org/pypi/tagpy"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/taglib-1.4
	|| ( <dev-libs/boost-1.35.0-r5 >=dev-libs/boost-1.35.0-r5[python] )"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

src_configure() {
	./configure.py \
		--taglib-inc-dir="/usr/include/taglib" \
		--boost-python-libname="boost_python-mt" || die "Configuration failed"
}

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/examples
	doins test/*
}
