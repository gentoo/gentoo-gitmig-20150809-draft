# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-appconf/django-appconf-0.5.ebuild,v 1.1 2012/04/25 12:25:31 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A helper class for handling configuration defaults of packaged apps gracefully"
HOMEPAGE="http://pypi.python.org/pypi/django-appconf http://django-appconf.readthedocs.org//"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="BSD"
SLOT="0"

PYTHON_MODNAME="appconf"

RDEPEND=""
DEPEND="${RDEPEND} >=dev-python/django-1.1.4
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

src_prepare() {
	sed -e 's:from .models:from models:' -i appconf/tests/tests.py || die
	sed -e 's:\[-2\]:\[-1\]:' -i appconf/base.py || die
	distutils_src_prepare
}

src_compile() {
	if use doc; then
		emake -C docs pickle htmlhelp
	fi
	distutils_src_compile
}

src_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	testing() {
		PYTHONPATH=. "$(PYTHON)" appconf/tests/tests.py
		einfo "tests completed successfully for python"$(python_get_version)
		einfo ""
	}

	python_execute_function testing
}

src_install() {
	if use doc; then
		dohtml -r docs/_build

		insinto usr/share/doc/${PF}/html/doctrees
		doins -r docs/_build/doctrees/
	fi

	distutils_src_install
}
