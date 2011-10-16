# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/bleachbit/bleachbit-0.9.0.ebuild,v 1.1 2011/10/16 13:54:55 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Clean junk to free disk space and to maintain privacy"
HOMEPAGE="http://bleachbit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2"
DEPEND="${DEPEND}"

DOCS="README"

src_prepare() {
	python_convert_shebangs 2 ${PN}.py

	# warning: key "Encoding" in group "Desktop Entry" is deprecated
	sed -i -e '/Encoding/d' ${PN}.desktop || die

	distutils_src_prepare
}

src_install() {
	distutils_src_install

	newbin ${PN}.py ${PN}

	doicon ${PN}.png
	domenu ${PN}.desktop
}
