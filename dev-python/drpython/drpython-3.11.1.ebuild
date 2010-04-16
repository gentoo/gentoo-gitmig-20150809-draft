# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/drpython/drpython-3.11.1.ebuild,v 1.2 2010/04/16 02:57:16 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="A powerful cross-platform IDE for Python"
HOMEPAGE="http://drpython.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-python/wxpython-2.6"
DEPEND="app-arch/unzip"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${P/-/_}"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${PN}-165-wxversion.patch"
}

src_install() {
	distutils_src_install

	# Don't install Windows-only setup script.
	rm -f "${ED}usr/bin/postinst.py"

	make_wrapper drpython "$(PYTHON -f -a) $(python_get_sitedir -f)/${PN}/drpython.py"
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "See the DrPython homepage for 20+ available plugins:"
	elog "http://sourceforge.net/project/showfiles.php?group_id=83074"
}
