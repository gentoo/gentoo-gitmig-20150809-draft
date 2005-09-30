# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-lib/rox-lib-2.0.2.ebuild,v 1.1 2005/09/30 08:04:10 svyatogor Exp $

inherit python

DESCRIPTION="ROX-Lib2 - Shared code for ROX applications by Thomas Leonard"
HOMEPAGE="http://rox.sourceforge.net/phpwiki/index.php/ROX-Lib"
SRC_URI="mirror://sourceforge/rox/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=rox-base/rox-2.1.0
		>=dev-lang/python-2.2
		>=dev-python/pygtk-1.99.13"

src_install() {
	dodir /usr/lib/
	cp -r ROX-Lib2/ ${D}/usr/lib/

	# build the byte-compiled .pyc and optimized .pyo modules
	python_mod_optimize ${D}/usr/lib/ROX-Lib2
}
