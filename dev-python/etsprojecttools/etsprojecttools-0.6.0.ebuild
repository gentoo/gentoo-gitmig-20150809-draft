# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/etsprojecttools/etsprojecttools-0.6.0.ebuild,v 1.1 2010/03/23 05:15:15 bicatali Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="ETSProjectTools"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tools for working with projects with many dependencies"
HOMEPAGE="http://code.enthought.com/projects/ets_project_tools.php"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-util/subversion"
DEPEND="dev-python/setuptools
	test? ( >=dev-python/nose-0.10.3 )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "s/self.run_command('build_docs')/pass/" setup.py || die
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}
