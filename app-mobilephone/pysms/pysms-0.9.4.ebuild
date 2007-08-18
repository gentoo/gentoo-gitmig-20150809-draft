# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/pysms/pysms-0.9.4.ebuild,v 1.1 2007/08/18 08:00:10 mrness Exp $

NEED_PYTHON=2.4

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

src_unpack() {
	unpack ${A}

	rm "${S}/MANIFEST.in"
}
