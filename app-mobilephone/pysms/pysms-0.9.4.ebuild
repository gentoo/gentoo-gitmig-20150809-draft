# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/pysms/pysms-0.9.4.ebuild,v 1.3 2010/07/06 17:14:01 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Tool for sending text messages for various Swiss providers"
HOMEPAGE="http://pysms.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygtk"
RDEPEND="${DEPEND}"

DOCS="AUTHORS"

RESTRICT="test"

src_prepare() {
	distutils_src_prepare
	rm -f MANIFEST.in
}
