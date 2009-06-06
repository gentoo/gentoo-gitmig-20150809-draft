# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyenchant/pyenchant-1.5.3.ebuild,v 1.1 2009/06/06 10:29:34 pva Exp $

inherit distutils

DESCRIPTION="Python wrapper for the Enchant spellchecking wrapper library"
SRC_URI="mirror://sourceforge/pyenchant/${P}.tar.gz"
HOMEPAGE="http://pyenchant.sourceforge.net"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/python-2.5
	>=app-text/enchant-1.4.0
	>=dev-python/setuptools-0.6_alpha11"

DOCS="README.txt TODO.txt"

src_test() {
	"${python}" setup.py test || die "test failed"
}
