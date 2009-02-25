# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/happydoc/happydoc-3.1.ebuild,v 1.1 2009/02/25 20:59:37 neurogeek Exp $

inherit distutils versionator

MY_PN="HappyDoc"
MY_PV=$(replace_all_version_separators "_" ${PV})
MY_V=$(get_major_version ${PV})
DESCRIPTION="tool for extracting documentation from Python sourcecode"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}_r${MY_PV}.tar.gz"
HOMEPAGE="http://happydoc.sourceforge.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="virtual/python"

# the tests need extra data not present in the release tarball
RESTRICT=test

S="${WORKDIR}/${MY_PN}${MY_V}-r${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp "${FILESDIR}/${P}-setup.py" "${S}/setup.py" || die "setup.py file not found"
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r "srcdocs/${MY_PN}${MY_V}-r${MY_PV}"/*
	fi
}
