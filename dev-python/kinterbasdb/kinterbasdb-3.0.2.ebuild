# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kinterbasdb/kinterbasdb-3.0.2.ebuild,v 1.12 2005/01/21 16:24:13 carlo Exp $

inherit distutils eutils

DESCRIPTION="firebird/interbase interface for Python"
HOMEPAGE="http://kinterbasdb.sourceforge.net/"
SRC_URI="mirror://sourceforge/kinterbasdb/${P}-src.tar.gz"

LICENSE="kinterbasdb"
SLOT="0"
KEYWORDS="x86 -sparc"
IUSE=""

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
