# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apsw/apsw-3.3.10.1.ebuild,v 1.1 2007/02/14 20:49:24 dev-zero Exp $

inherit distutils versionator

MY_P=${PN}-$(replace_version_separator 3 -r)

DESCRIPTION="APSW - Another Python SQLite Wrapper"
HOMEPAGE="http://www.rogerbinns.com/apsw.html"
SRC_URI="mirror://sourceforge/bitpim/${MY_P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-lang/python
	>=dev-db/sqlite-3.3.10"
DEPEND="app-arch/unzip
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install
	dohtml apsw.html
}

src_test() {
	PYTHONPATH="$(ls -d build/lib.*)" "${python}" tests.py || die "tests failed"
}
