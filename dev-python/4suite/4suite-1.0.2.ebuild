# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/4suite/4suite-1.0.2.ebuild,v 1.1 2006/12/29 00:57:30 dev-zero Exp $

inherit distutils eutils multilib

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

MY_P=4Suite-XML-${PV}

DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="mirror://sourceforge/foursuite/${MY_P}.tar.bz2"
HOMEPAGE="http://www.4suite.org/"
SLOT="0"
LICENSE="Apache-1.1"
IUSE="doc"

DEPEND=">=dev-python/pyxml-0.8.4"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="Ft"
DOCS="docs/*.txt"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-amd64_python2.5.patch"
}

src_compile() {
	if ! use doc ; then
		sed -i -e "/'build_docs'/d" \
			Ft/Lib/DistExt/Build.py || die "sed failed"
	fi
	distutils_python_version
	python setup.py config \
		--prefix=/usr \
		--docdir=/usr/share/doc/${PF} \
		--libdir=/usr/$(get_libdir)/4Suite || die "setup.py config failed"

	distutils_src_compile
}

src_install() {
	distutils_src_install $(use_with doc docs)
}
