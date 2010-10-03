# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py/py-1.3.1.ebuild,v 1.12 2010/10/03 14:34:03 armin76 Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A library aiming to support agile and test-driven python development on various levels."
HOMEPAGE="http://codespeak.net/py/ http://pypi.python.org/pypi/py"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_install() {
	distutils_src_install
	python_generate_wrapper_scripts -E -f -q "${D%/}${EPREFIX}/usr/bin/py.test"
}
