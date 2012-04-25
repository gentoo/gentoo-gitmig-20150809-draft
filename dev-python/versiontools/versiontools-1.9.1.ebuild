# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/versiontools/versiontools-1.9.1.ebuild,v 1.1 2012/04/25 12:34:45 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

DESCRIPTION="Allows to define regrouped/postcompiled content 'on the fly' inside of django template"
HOMEPAGE="http://pypi.python.org/pypi/versiontools/ https://launchpad.net/versiontools"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_test() {
	testing() {
		PYTHONPATH=. "$(PYTHON)" versiontools/tests.py
		einfo "Testing successfully completed for python"$(python_get_version)
		einfo ""
	}
	python_execute_function testing
}

src_install() {
	if use doc; then
		docompress -x usr/share/doc/${PF}/
		insinto usr/share/doc/${PF}/
		doins doc/*
	fi

	distutils_src_install
}
