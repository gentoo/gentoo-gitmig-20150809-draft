# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webtest/webtest-1.2.ebuild,v 1.4 2009/11/30 16:48:43 volkmar Exp $

EAPI="2"

NEED_PYTHON="2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="WebTest"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Helper to test WSGI applications"
HOMEPAGE="http://pythonpaste.org/webtest/ http://pypi.python.org/pypi/WebTest"
SRC_URI="http://pypi.python.org/packages/source/W/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="doc examples"

DEPEND="dev-python/setuptools"
RDEPEND=">=dev-python/webob-0.9.2"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install

	use doc && dodoc docs/index.txt
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r docs/chipy-presentation
	fi
}
