# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/whoosh/whoosh-2.4.0.ebuild,v 1.2 2012/05/23 05:58:48 mr_bones_ Exp $

EAPI="3"

PYTHON_DEPEND="2:2.5 3:3.1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4"
DISTUTILS_SRC_TEST="setup.py"
#PYTHON_TESTS_RESTRICTED_ABIS="3.*"
PYTHON_MODNAME="whoosh"

MY_PN="Whoosh"

inherit distutils

DESCRIPTION="Fast, pure-Python full text indexing, search and spell checking library"
HOMEPAGE="http://bitbucket.org/mchaput/whoosh/wiki/Home/ http://pypi.python.org/pypi/Whoosh/"
SRC_URI="mirror://pypi/W/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	distutils_src_install

	if use doc; then
		insinto "/usr/share/doc/${PF}/"
		doins -r docs/build/html/_sources/* || die
	fi
}
