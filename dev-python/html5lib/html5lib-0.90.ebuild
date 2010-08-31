# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/html5lib/html5lib-0.90.ebuild,v 1.3 2010/08/31 10:24:02 hwoarang Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="HTML parser based on the HTML5 specification"
HOMEPAGE="http://code.google.com/p/html5lib/ http://pypi.python.org/pypi/html5lib"
SRC_URI="http://${PN}.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND="dev-lang/python[xml]"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=dev-python/setuptools-0.6_rc5"
RESTRICT_PYTHON_ABIS="3.*"

src_install() {
	distutils_src_install

	if use examples ; then
		find examples -name "*.pyc" | xargs rm -fr
		insinto "/usr/share/doc/${PF}"
		doins -r examples || die "Installation of examples failed"
	fi
}
