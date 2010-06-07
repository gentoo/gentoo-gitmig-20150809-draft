# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/supervisor/supervisor-3.0_alpha8.ebuild,v 1.2 2010/06/07 10:23:47 djc Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils versionator eutils

MY_PV="${PV/_alpha/a}"

DESCRIPTION="A system for controlling process state under UNIX"
HOMEPAGE="http://supervisord.org/ http://pypi.python.org/pypi/supervisor"
SRC_URI="http://dist.supervisord.org/${PN}-${MY_PV}.tar.gz"

LICENSE="repoze ZPL BSD as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools
		test? ( dev-python/mock )"
RDEPEND="dev-python/meld3"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${PN}-${MY_PV}"

DOCS="CHANGES.txt PKG-INFO README.txt TODO.txt"

src_prepare() {
	epatch "${FILESDIR}/${PV}-no-docs.patch"
}

src_install() {
	distutils_src_install
	newinitd "${FILESDIR}"/init.d supervisord
	newconfd "${FILESDIR}"/conf.d supervisord
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py test
	}
	python_execute_function testing
}
