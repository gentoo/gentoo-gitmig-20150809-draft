# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/virtualenv/virtualenv-1.6.ebuild,v 1.3 2011/05/05 06:39:32 angelos Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Virtual Python Environment builder"
HOMEPAGE="http://pypi.python.org/pypi/virtualenv"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="amd64 ~ppc ppc64 ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

DOCS="docs/index.txt docs/news.txt"
PYTHON_MODNAME="virtualenv.py virtualenv_support"
