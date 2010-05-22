# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/httplib2/httplib2-0.5.0.ebuild,v 1.6 2010/05/22 16:15:07 armin76 Exp $

EAPI="2"

NEED_PYTHON="2.3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A comprehensive HTTP client library with caching and authentication."
HOMEPAGE="http://code.google.com/p/httplib2/ http://pypi.python.org/pypi/httplib2"
SRC_URI="http://httplib2.googlecode.com/files/${P}.tar.gz
	http://httplib2.googlecode.com/files/${PN}-python3-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

src_prepare() {
	distutils_src_prepare

	local dir
	for dir in "${WORKDIR}/${P}-3"*; do
		if [[ -d "${dir}" ]]; then
			rm -fr "${dir}" || die
			cp -lpr "${WORKDIR}/${PN}-python3-${PV}" "${dir}" || die
		fi
	done
}

src_install() {
	distutils_src_install
	dodoc README
	newdoc "${WORKDIR}/${PN}-python3-${PV}/README" README-python3
}
