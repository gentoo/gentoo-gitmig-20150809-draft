# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leo/leo-4.7.1.ebuild,v 1.2 2010/05/24 15:14:36 nixnut Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="tk"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_P="Leo-${PV}-final"

DESCRIPTION="Leo: Literate Editor with Outlines"
HOMEPAGE="http://leo.sourceforge.net/ http://pypi.python.org/pypi/leo"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

RDEPEND="app-text/silvercity
	dev-python/PyQt4[X]"
DEPEND="${RDEPEND}
	app-arch/unzip"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-fix_syntax_errors.patch"
}

src_install() {
	distutils_src_install
	dohtml -r leo/doc/html/* || die "dohtml failed"
	dodoc leo/doc/README.TXT || die "dodoc failed"
}
