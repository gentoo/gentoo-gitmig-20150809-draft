# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/httplib2/httplib2-0.5.0.ebuild,v 1.1 2009/08/29 22:05:17 arfrever Exp $

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
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	distutils_src_prepare
	python_copy_sources

	local dir
	for dir in "${WORKDIR}/${P}-3"*; do
		if [[ -d "${dir}" ]]; then
			rm -fr "${dir}" || die
			cp -lpr "${WORKDIR}/${PN}-python3-${PV}" "${dir}" || die
		fi
	done
}

src_compile() {
	building() {
		echo "$(PYTHON)" setup.py build
		"$(PYTHON)" setup.py build
	}
	python_execute_function -s building
}

src_install() {
	installation() {
		"$(PYTHON)" setup.py install --root="${D}" --no-compile
	}
	python_execute_function -s installation

	dodoc README
	newdoc "${WORKDIR}/${PN}-python3-${PV}/README" README-python3
}
