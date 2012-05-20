# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-evolution/django-evolution-0.6.7.ebuild,v 1.1 2012/05/20 10:34:08 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy"

inherit distutils eutils

MY_P=${PN/-/_}-${PV}

DESCRIPTION="A Django application that will run cron jobs for other django apps"
HOMEPAGE="http://code.google.com/p/django-evolution/ http://pypi.python.org/pypi/django_evolution/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_P}/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="BSD"
SLOT="0"
PYTHON_MODNAME="django_evolution"
S="${WORKDIR}/${MY_P}"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	dev-python/django"

src_test() {
	testing() {
		local exit_status=0
		"$(PYTHON)" tests/runtests.py || exit_status=1
		return $exit_status
	}
	python_execute_function testing
}

src_install() {
	local msg="Remove tests to avoid file collisions"
	distutils_src_install

	rmtests() {
		rm -rf "${ED}"/$(python_get_sitedir)/tests/ || die
	}
	python_execute_function --action-message "$msg" rmtests
	dodoc docs/*
}
