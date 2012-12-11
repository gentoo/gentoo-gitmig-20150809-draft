# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/isodate/isodate-0.4.9.ebuild,v 1.2 2012/12/11 19:14:35 ago Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"
RESTRICT_PYTHON_ABIS="*-pypy-*"

inherit distutils

DESCRIPTION="ISO 8601 date/time/duration parser and formater"
HOMEPAGE="http://pypi.python.org/pypi/isodate"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/setuptools"

DOCS="CHANGES.txt README.txt TODO.txt"
