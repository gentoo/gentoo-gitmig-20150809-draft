# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp/pysnmp-2.0.9.ebuild,v 1.3 2008/06/23 07:10:41 opfer Exp $

inherit distutils

DESCRIPTION="SNMP v1/v2c/v3 engine written in Python."
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~sparc x86"
IUSE=""

src_install() {
	distutils_src_install

	dodoc CHANGES
	dohtml html/*
	insinto /usr/share/doc/${PF}
	doins -r examples
}
