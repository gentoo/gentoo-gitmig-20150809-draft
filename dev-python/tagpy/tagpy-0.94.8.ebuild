# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tagpy/tagpy-0.94.8.ebuild,v 1.3 2010/10/24 15:43:05 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python Bindings for TagLib"
HOMEPAGE="http://mathema.tician.de//software/tagpy http://pypi.python.org/pypi/tagpy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="examples"

RDEPEND=">=media-libs/taglib-1.4
	|| ( >=dev-libs/boost-1.35.0-r5[python] <dev-libs/boost-1.35.0-r5 )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_configure() {
	"$(PYTHON -f)" ./configure.py \
		--taglib-inc-dir="/usr/include/taglib" \
		--boost-python-libname="boost_python-mt" || die "Configuration failed"
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins test/* || die "Installation of examples failed"
	fi
}
