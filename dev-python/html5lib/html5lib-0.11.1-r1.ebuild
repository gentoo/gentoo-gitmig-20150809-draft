# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/html5lib/html5lib-0.11.1-r1.ebuild,v 1.1 2009/12/22 23:58:12 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="HTML parser based on the WHAT-WG Web Applications 1.0 HTML5 specification"
HOMEPAGE="http://code.google.com/p/html5lib/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND="dev-lang/python[xml]"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=dev-python/setuptools-0.6_rc5
	test? ( dev-python/simplejson )"
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-python-2.6.patch"
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples ; then
		find examples -name "*.pyc" | xargs rm -fr
		insinto "/usr/share/doc/${PF}"
		doins -r examples || die "Installation of examples failed"
	fi
}
