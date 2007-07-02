# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kinterbasdb/kinterbasdb-3.2.ebuild,v 1.4 2007/07/02 02:15:43 hawking Exp $

inherit distutils eutils

DESCRIPTION="firebird/interbase interface for Python."
HOMEPAGE="http://kinterbasdb.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.tar.gz"

IUSE="doc"
KEYWORDS="~amd64 -sparc ~x86"
LICENSE="kinterbasdb"
SLOT="0"

DEPEND="virtual/python
	>=dev-db/firebird-1.0_rc1
	>=dev-python/egenix-mx-base-2.0.1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# firebird headers are in /opt/firebird/include
	# don't byte-compile .py files
	sed -i \
		-e 's:^#\(database_include_dir=\).*:\1/opt/firebird/include:' \
		-e 's:\(compile=\)1:\10:' \
		-e 's:\(optimize=\)1:\10:' \
		setup.cfg || die "sed in setup.cfg failed"

	epatch "${FILESDIR}/${P}-no_doc.patch"
}

src_install() {
	DOCS="docs/changelog.txt"
	distutils_src_install

	use doc && dohtml docs/*
}
