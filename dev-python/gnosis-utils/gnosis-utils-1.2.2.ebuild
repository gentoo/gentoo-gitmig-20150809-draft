# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnosis-utils/gnosis-utils-1.2.2.ebuild,v 1.3 2009/09/23 18:22:43 armin76 Exp $

EAPI="2"
NEED_PYTHON="2.1"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_P=Gnosis_Utils-${PV}

DESCRIPTION="XML pickling and objectification with Python."
SRC_URI="http://www.gnosis.cx/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.gnosis.cx/download/"
SLOT="0"
KEYWORDS="~amd64 ia64 x86"
LICENSE="PYTHON"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT_PYTHON_ABIS="3*"

PYTHON_MODNAME="gnosis"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${P}-setup.py.patch"

	# This setup.py installs files according to the MANIFEST.
	# MANIFEST shouldn't be installed to avoid collisions.
	rm -f MANIFEST || die "rm failed"
	sed -i \
		-e "/MANIFEST/d" \
		-e "/gnosis\/doc/d" \
		MANIFEST.in || die "sed failed"

	sed -e "s/with/with_/" -i gnosis/util/convert/pyfontify.py || die "sed failed"
}

src_test() {
	testing() {
		cd "${S}"/gnosis/xml/pickle/test
		PYTHONPATH="${S}/build-${PYTHON_ABI}/lib" "$(PYTHON)" test_all.py
	}
	python_execute_function testing
}

src_install() {
	dodoc README gnosis/doc/{*.txt,readme,GETTING_HELP,*ANNOUNCE}
	newdoc gnosis/anon/README README.anon
	newdoc gnosis/xml/relax/README README.relax.xml

	distutils_src_install

	rm -f "${D}"usr/lib*/python*/site-packages/README
}
