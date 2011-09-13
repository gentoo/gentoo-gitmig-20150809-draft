# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyquery/pyquery-1.0.ebuild,v 1.2 2011/09/13 21:10:32 mr_bones_ Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
#DISTUTILS_SRC_TEST="nosetests" somewhat works, tries to test docs

inherit distutils

DESCRIPTION="A jquery-like library for python"
HOMEPAGE="http://pypi.python.org/pypi/pyquery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/lxml-2.1"
DEPEND="${RDEPEND}
		test? (
			dev-python/webob
			dev-python/nose
		)"

DOCS="CHANGES.txt"
