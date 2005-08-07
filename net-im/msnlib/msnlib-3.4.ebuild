# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msnlib/msnlib-3.4.ebuild,v 1.5 2005/08/07 22:22:51 josejx Exp $

inherit distutils

IUSE=""
DESCRIPTION="A Python MSN messenger protocol library and client"
HOMEPAGE="http://auriga.wearlab.de/~alb/msnlib"
SRC_URI="http://auriga.wearlab.de/~alb/msnlib/files/${P}.tar.bz2"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="ppc ~sparc x86"
DEPEND=">=dev-lang/python-2.2.2"

DOCS="README INSTALL doc/*"

src_install() {
	distutils_src_install
	cd ${S}
	dobin msn
	dobin msnsetup
	dobin utils/msntk

	insinto /usr/share/doc/${PF}
	doins msnrc.sample
}
