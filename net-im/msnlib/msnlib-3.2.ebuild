# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msnlib/msnlib-3.2.ebuild,v 1.3 2003/11/24 03:52:38 mr_bones_ Exp $

inherit distutils

IUSE=""
DESCRIPTION="A Python MSN messenger protocol library and client"
HOMEPAGE="http://auriga.wearlab.de/~alb/msnlib"
SRC_URI="http://auriga.wearlab.de/~alb/msnlib/files/${P}.tar.bz2"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="x86 ~sparc"
DEPEND=">=dev-lang/python-2.2.2"

DOCS="README INSTALL doc/*"

src_install() {
	distutils_src_install
	cd ${S}
	dobin msn
	dobin msnsetup

	insinto /usr/share/doc/${PF}
	doins msnrc.sample
}
