# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-auth-ldap/django-auth-ldap-1.0.19.ebuild,v 1.1 2012/04/18 16:34:36 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils

DESCRIPTION="A flexible and capable API layer for Django utilising serialisers"
HOMEPAGE="http://pypi.python.org/pypi/django-auth-ldap
	http://bitbucket.org/psagers/django-auth-ldap/"
SRC_URI="mirror://pypi/d/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="BSD"
SLOT="0"
PYTHON_MODNAME="django_auth_ldap"
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

RDEPEND=""
DEPEND="${RDEPEND} >=dev-python/django-1.0
	dev-python/python-ldap
	doc? ( dev-python/sphinx )"

src_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	testing() {
		$(PYTHON) django_auth_ldap/tests.py
		einfo "tests completed for	python"$(python_get_version)
	}
	python_execute_function -s testing
}

src_compile() {
	distutils_src_compile
	if use doc; then
		emake -C docs html
	fi
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r docs/_build/html/*
	fi
}
