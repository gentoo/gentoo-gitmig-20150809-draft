# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp/pysnmp-3.4.2.ebuild,v 1.1 2004/06/23 11:03:47 lucass Exp $

inherit distutils

DESCRIPTION="SNMP framework in Python. Not a wrapper."
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

src_install(){
	distutils_src_install

	dodoc CHANGES COMPATIBILITY
	dohtml -r docs/
	cp -r examples ${D}/usr/share/doc/${PF}
}

