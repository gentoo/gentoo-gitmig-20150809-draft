# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kinterbasdb/kinterbasdb-3.0.1_pre3.ebuild,v 1.15 2004/02/19 14:19:25 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="kinterbasdb - firebird/interbase interface for Python."
SRC_URI="mirror://sourceforge/kinterbasdb/${P}.tar.gz"
HOMEPAGE="http://kinterbasdb.sourceforge.net"
LICENSE="kinterbasdb"
SLOT="0"
KEYWORDS="x86 -sparc"

DEPEND="virtual/python
	>=dev-db/firebird-1.0_rc1
	>=dev-python/egenix-mx-base-2.0.1"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --prefix=${D}/usr || die
	rm -rf ${D}/usr/kinterbasdb
	dohtml docs/*.html docs/*.css
	dodoc docs/*.txt
}
