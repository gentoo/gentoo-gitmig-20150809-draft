# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp/pysnmp-3.4.2.ebuild,v 1.3 2005/11/15 20:42:41 dang Exp $

inherit distutils

DESCRIPTION="SNMP framework in Python. Not a wrapper."
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_install(){
	distutils_src_install

	dodoc CHANGES COMPATIBILITY
	dohtml -r docs/
	cp -r examples ${D}/usr/share/doc/${PF}
}

