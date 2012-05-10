# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fabric/fabric-1.4.2.ebuild,v 1.1 2012/05/10 23:31:35 neurogeek Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"
#DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

MY_PN="Fabric"
MY_P="${MY_PN}-${PV}"
GIT_HASH_TAG="3a4006e"

DESCRIPTION="Fabric is a simple, Pythonic tool for remote execution and deployment."
HOMEPAGE="http://fabfile.org http://pypi.python.org/pypi/Fabric"
SRC_URI="http://github.com/${PN}/${PN}/tarball/${PV} -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-python/ssh-1.7.14"
DEPEND="${RDEPEND}
		dev-python/setuptools"
#		test? ( dev-python/fudge )"

# Tests broken.
RESTRICT="test"

S="${WORKDIR}/${PN}-${PN}-${GIT_HASH_TAG}"

PYTHON_MODULES="fabfile fabric"

src_prepare() {
	use doc &&
		epatch "${FILESDIR}"/${P}-git_tags_docs.patch
}

src_compile() {
	distutils_src_compile

	if use doc; then
		emake -C docs html || die "Couldn't make docs"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html
	fi
}
