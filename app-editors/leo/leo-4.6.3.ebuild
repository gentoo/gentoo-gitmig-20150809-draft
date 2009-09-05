# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leo/leo-4.6.3.ebuild,v 1.1 2009/09/05 15:45:51 arfrever Exp $

EAPI="2"

NEED_PYTHON="2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="Leo-${PV//./-}-final"

DESCRIPTION="An outlining editor and literate programming tool."
HOMEPAGE="http://leo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="app-text/silvercity
	>=dev-lang/python-2.5[tk]
	dev-python/PyQt4[X]"
DEPEND="${RDEPEND}
	app-arch/unzip"
RESTRICT_PYTHON_ABIS="2.4 3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="leo"

src_install() {
	distutils_src_install
	dohtml -r leo/doc/html/* || die "dohtml failed"
	dodoc leo/doc/README.TXT || die "dodoc failed"
}
