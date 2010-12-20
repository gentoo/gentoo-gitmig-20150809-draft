# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/virtualenv/virtualenv-1.5.1.ebuild,v 1.4 2010/12/20 20:10:53 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Virtual Python Environment builder"
HOMEPAGE="http://pypi.python.org/pypi/virtualenv"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
SLOT="0"
IUSE=""

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}"

DOCS="docs/index.txt docs/news.txt"
PYTHON_MODNAME="virtualenv.py virtualenv_support"
