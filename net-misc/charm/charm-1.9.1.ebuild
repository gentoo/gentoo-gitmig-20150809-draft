# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/charm/charm-1.9.1.ebuild,v 1.4 2010/05/24 13:57:54 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A text based livejournal client"
HOMEPAGE="http://ljcharm.sourceforge.net/"
SRC_URI="mirror://sourceforge/ljcharm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.charm sample.charmrc README.charm"
PYTHON_MODNAME="ljcharm.py"

src_prepare() {
	distutils_src_prepare
	sed -e 's/("share\/doc\/charm", .*),/\\/' -i setup.py || die "sed failed"
}

src_install() {
	distutils_src_install
	dohtml charm.html || die "dohtml failed"
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "You need to create a ~/.charmrc before running charm."
	elog "Read 'man charmrc' for more information."
	elog ""
}
