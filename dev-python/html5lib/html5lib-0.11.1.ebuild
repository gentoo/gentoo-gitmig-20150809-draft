# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/html5lib/html5lib-0.11.1.ebuild,v 1.1 2009/02/03 19:45:28 patrick Exp $

EAPI="2"

NEED_PYTHON="2.4"

inherit distutils

DESCRIPTION="HTML parser based on the WHAT-WG Web Applications 1.0 HTML5 specification"
HOMEPAGE="http://code.google.com/p/html5lib/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.zip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

# simplejson will be bundled with python 2.6
RDEPEND="
	test? ( dev-python/simplejson )"
DEPEND="${RDEPEND}
	>=dev-python/setuptools-0.6_rc5
	dev-lang/python[xml]"

src_install() {
	distutils_src_install

	if use examples ; then
		$(find examples -name '*.pyc' -exec rm -rf {} \;)
		insinto "/usr/share/doc/${PF}"
		doins -r examples || die "Failed to install examples"
	fi
}

src_test() {
	distutils_python_version
	"${python}" setup.py test || die "tests failed"
}
