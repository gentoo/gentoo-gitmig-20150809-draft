# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kinterbasdb/kinterbasdb-3.0.2.ebuild,v 1.9 2004/02/19 14:19:25 agriffis Exp $

inherit distutils

DESCRIPTION="kinterbasdb - firebird/interbase interface for Python."
SRC_URI="mirror://sourceforge/kinterbasdb/${P}-src.tar.gz"
HOMEPAGE="http://kinterbasdb.sourceforge.net"

IUSE=""
LICENSE="kinterbasdb"
SLOT="0"
KEYWORDS="x86 -sparc"

DEPEND="dev-lang/python
	>=dev-db/firebird-1.0_rc1
	>=dev-python/egenix-mx-base-2.0.1"

src_unpack() {
	distutils_python_version
	unpack ${A}
	if [ ${PYVER_MINOR} -gt 2 ]; then
		EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${P}-py23.patch
	fi
}

src_install() {
	mydoc="docs/*.txt"
	distutils_src_install --install-data=/usr/share/doc/${PF}

	# we put docs in properly ourselves
	rm -rf ${D}/usr/share/doc/${PF}/kinterbasdb
	dohtml docs/*.html docs/*.css
}
