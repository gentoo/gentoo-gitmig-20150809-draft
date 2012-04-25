# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-ldapdb/django-ldapdb-0.1.0_p20120424.ebuild,v 1.1 2012/04/25 18:42:04 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils

DESCRIPTION="an LDAP database backend for Django"
HOMEPAGE="http://opensource.bolloretelecom.eu/projects/django-ldapdb/"
SRC_URI="http://dev.gentoo.org/~tampakrap/tarballs/${P}.tar.bz2"

KEYWORDS="~amd64"
IUSE="examples test"
LICENSE="MIT"
SLOT="0"
PYTHON_MODNAME="ldapdb"
S="${WORKDIR}/${PN}"

REDEPEND=""
DEPEND="${REDEPEND}
	dev-python/setuptools
	dev-python/django
	test? ( dev-python/python-ldap )"

src_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	testing() {
		PYTHONPATH=. "$(PYTHON)" examples/tests.py
		if [[ $? ]];  then
			einfo "All examples tests completed successfully with python"$(python_get_version)
			einfo ""
		fi

		PYTHONPATH="build-$(python_get_version)/lib/" \
		 "$(PYTHON)" ${PYTHON_MODNAME}/tests.py
		if [[ $? ]];  then
			einfo "All tests under ldapdb completed successfully with python"$(python_get_version)
			einfo ""
		fi
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	samples() {
		insinto $(python_get_libdir)/site-packages/${PYTHON_MODNAME}/
		doins -r examples/
	}

	if use examples; then
		python_execute_function samples
	fi
}
