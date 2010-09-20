# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/4suite/4suite-1.0.2-r1.ebuild,v 1.11 2010/09/20 19:32:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

MY_P="4Suite-XML-${PV}"

DESCRIPTION="Python tools for XML processing and object-databases."
HOMEPAGE="http://www.4suite.org/ http://pypi.python.org/pypi/4Suite"
SRC_URI="mirror://sourceforge/foursuite/${MY_P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="doc"

DEPEND=">=dev-python/pyxml-0.8.4"
RDEPEND="${DEPEND}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="docs/*.txt"
PYTHON_MODNAME="Ft"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${P}-amd64_python2.5.patch"
	epatch "${FILESDIR}/${P}-config.patch"
	epatch "${FILESDIR}/${P}-version_parsing.patch"

	if ! use doc; then
		sed -e "/'build_docs'/d" -i Ft/Lib/DistExt/Build.py || die "sed failed"
	fi
	distutils_src_prepare
}

src_configure() {
	configuration() {
		"$(PYTHON)" setup.py config \
			--prefix=/usr \
			--docdir=/usr/share/doc/${PF} \
			--datadir=/usr/share/${PN} \
			--libdir="$(python_get_sitedir)" || die "setup.py config failed with Python ${PYTHON_ABI}"
	}
	python_execute_function configuration
}

src_install() {
	distutils_src_install $(use_with doc docs)

	delete_profiles_and_tests() {
		rm -fr "${ED}$(python_get_sitedir)/"{profiles,tests}
	}
	python_execute_function -q delete_profiles_and_tests
}
