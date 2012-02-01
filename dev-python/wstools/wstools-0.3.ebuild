# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wstools/wstools-0.3.ebuild,v 1.7 2012/02/01 20:59:08 ranger Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

DESCRIPTION="WSDL parsing services package for Web Services for Python"
HOMEPAGE="https://github.com/kiorky/wstools http://pypi.python.org/pypi/wstools"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86 ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_prepare() {
	distutils_src_prepare
	find -name .cvsignore -print0 | xargs -0 rm -f
}
