# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webtest/webtest-1.2.ebuild,v 1.1 2009/09/04 15:07:03 patrick Exp $

inherit distutils

MY_PN="WebTest"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Helper to test WSGI applications"
HOMEPAGE="http://pythonpaste.org/webtest/"
SRC_URI="http://pypi.python.org/packages/source/W/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="doc examples"
S="${WORKDIR}/${MY_P}"
DEPEND="dev-python/setuptools"
RDEPEND="|| ( >=dev-python/wsgiref-0.1.2 >=dev-lang/python-2.5.2-r4 )
	>=dev-python/webob-0.9.2"

src_install() {
	distutils_src_install

	use doc && dodoc docs/index.txt
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r docs/chipy-presentation
	fi
}
