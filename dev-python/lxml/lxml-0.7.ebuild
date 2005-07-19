# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lxml/lxml-0.7.ebuild,v 1.1 2005/07/19 21:30:51 lucass Exp $

inherit distutils

DESCRIPTION="lxml is a Pythonic binding for the libxml2 and libxslt libraries"
HOMEPAGE="http://codespeak.net/lxml/"
SRC_URI="http://codespeak.net/lxml/${P}.tgz"

LICENSE="BSD GPL-2 as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.2.16
		>=dev-libs/libxslt-1.1.12
		>=dev-python/pyrex-0.9.3
		virtual/python"

S="${WORKDIR}/${PN}"


src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s/PYTHON=python2.3/PYTHON=${python}/" Makefile
}

src_test() {
	make test
}

src_install() {
	distutils_src_install

	# setup.py doesn't install all necessary files in tests/.
	distutils_python_version
	site_pkgs=${D}/usr/$(get_libdir)/python${PYVER}/site-packages/lxml
	rm -rf ${site_pkgs}/tests
	cp -r src/lxml/tests ${site_pkgs}/

	dodoc *.txt
	docinto doc
	dodoc doc/*.txt
	docinto doc/licenses
	dodoc doc/licenses/*

	cp -r samples ${D}/usr/share/doc/${PF}
}

