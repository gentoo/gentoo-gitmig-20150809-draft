# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/etsprojecttools/etsprojecttools-0.4.2.ebuild,v 1.1 2009/01/15 10:14:32 bicatali Exp $

EAPI=2
inherit distutils

MY_PN="ETSProjectTools"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tools for working with projects with many dependencies"
HOMEPAGE="http://code.enthought.com/projects/ets_project_tools.php"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

IUSE="test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-util/subversion"
DEPEND="dev-python/setuptools
	test? ( >=dev-python/nose-0.10.3 )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
}

src_test() {
	PYTHONPATH=build/lib ${python} setup.py test || die "tests failed"
}
