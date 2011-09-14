# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chameleon/chameleon-2.4.3.ebuild,v 1.1 2011/09/14 08:26:17 djc Exp $

EAPI=3

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.7 3"
RESTRICT_PYTHON_ABIS="2.[456]"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="Chameleon"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fast HTML/XML template compiler for Python"
HOMEPAGE="http://chameleon.repoze.org http://pypi.python.org/pypi/Chameleon"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile

	if use doc ; then
		emake html || die "make html failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc ; then
		dohtml -r _build/html/* || die "dohtml failed"
	fi
}
