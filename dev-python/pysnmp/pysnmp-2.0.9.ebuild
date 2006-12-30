# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp/pysnmp-2.0.9.ebuild,v 1.1 2006/12/30 11:32:59 dev-zero Exp $

inherit distutils

DESCRIPTION="SNMP v1/v2c/v3 engine written in Python."
HOMEPAGE="http://pysnmp.sf.net/"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

mydoc="CHANGES"

src_install() {
	distutils_src_install
	dohtml html/*
	insinto /usr/share/doc/${PF}
	doins -r examples
}
