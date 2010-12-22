# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gunicorn/gunicorn-0.12.0.ebuild,v 1.1 2010/12/22 22:22:10 rafaelmartins Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A WSGI HTTP Server for UNIX, fast clients and nothing else"
HOMEPAGE="http://gunicorn.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="doc examples test"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/setproctitle"
DEPEND="dev-python/setuptools
	test? ( dev-python/nose )"

RESTRICT_PYTHON_ABIS="3.*"
DOCS="README.rst"

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/htdocs/*
	insinto "/usr/share/doc/${PF}"
	use examples && doins -r examples
}

src_test() {
	# distutils_src_test doesn't works if gunicorn isn't installed yet
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" \
			setup.py test || die 'test failed.'
	}
	python_execute_function testing
}
