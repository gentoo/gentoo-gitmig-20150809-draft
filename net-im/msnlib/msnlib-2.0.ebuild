# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msnlib/msnlib-2.0.ebuild,v 1.3 2003/09/05 23:58:58 msterret Exp $

inherit distutils

IUSE=""
DESCRIPTION="A Python MSN messenger protocol library and client"
HOMEPAGE="http://auriga.wearlab.de/~alb/msnlib"
SRC_URI="http://auriga.wearlab.de/~alb/msnlib/files/${P}.tar.bz2"

LICENSE="OSL"
SLOT="0"
KEYWORDS="x86 ~sparc"
DEPEND="virtual/python"
S=${WORKDIR}/${P}

mydoc="README INSTALL doc/*"

src_install() {
	distutils_src_install
	cd ${S}
	dobin msn
	dobin msnsetup

	insinto /usr/share/doc/${PF}
	doins msnrc.sample
}
