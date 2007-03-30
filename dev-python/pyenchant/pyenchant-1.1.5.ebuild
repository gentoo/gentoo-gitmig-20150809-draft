# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyenchant/pyenchant-1.1.5.ebuild,v 1.3 2007/03/30 17:12:24 opfer Exp $

inherit distutils

DESCRIPTION="Python wrapper for the Enchant spellchecking wrapper library"
SRC_URI="mirror://sourceforge/pyenchant/${P}.tar.gz"
HOMEPAGE="http://pyenchant.sourceforge.net"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 x86"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/python-2.3
	>=app-text/enchant-1.1.6
	>=dev-python/setuptools-0.6_alpha11"

DOCS="TODO.txt"


src_test() {
	"${python}" setup.py test || die "test failed"
}
