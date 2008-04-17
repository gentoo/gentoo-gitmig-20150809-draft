# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/4suite/4suite-1.0.2-r1.ebuild,v 1.1 2008/04/17 20:52:20 pythonhead Exp $

inherit distutils eutils multilib

MY_P=4Suite-XML-${PV}

DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="mirror://sourceforge/foursuite/${MY_P}.tar.bz2"
HOMEPAGE="http://www.4suite.org/"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
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
	epatch "${FILESDIR}/${P}-config.patch"
}

src_compile() {
	if ! use doc ; then
		sed -i -e "/'build_docs'/d" \
			Ft/Lib/DistExt/Build.py || die "sed failed"
	fi
	distutils_python_version
	"${python}" setup.py config \
		--prefix=/usr \
		--docdir=/usr/share/doc/${PF} \
		--datadir=/usr/share/${PN} \
		--libdir=/usr/$(get_libdir)/python${PYVER}/site-packages || die "setup.py config failed"

	distutils_src_compile
}

src_install() {
	rm -r test profile
	distutils_src_install \
		$(use_with doc docs) \
		--install-lib="/usr/$(get_libdir)/python${PYVER}/site-packages"
}
