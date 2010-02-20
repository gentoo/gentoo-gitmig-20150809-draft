# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pmw/pmw-1.3.2-r2.ebuild,v 1.1 2010/02/20 12:21:38 jlec Exp $

EAPI="2"
PYTHON_MODNAME="Pmw"

inherit eutils distutils

MY_P="Pmw.${PV}"

DESCRIPTION="A toolkit for building high-level compound widgets in Python using the Tkinter module."
HOMEPAGE="http://pmw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD"
IUSE="doc examples"

DEPEND="dev-lang/python[tk]"
RDEPEND="${DEPEND}"

DOCS="${PYTHON_MODNAME}/README"
S="${WORKDIR}/${MY_P}/src"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}/${P}-install-no-docs.patch"
	epatch "${FILESDIR}/${PV}-python2.5.patch"
}

src_install() {
	distutils_src_install

	local DIR
	DIR="${S}/${PYTHON_MODNAME}/Pmw_1_3"

	if use doc; then
		dohtml -a html,gif,py "${DIR}"/doc/* \
			|| die "failed to install docs"
	fi

	if use examples; then
		insinto "${ROOT}/usr/share/doc/${PF}/examples"
		doins "${DIR}"/demos/* \
			|| die "failed to install demos"
	fi

	#Tests are not unittests and show various
	#GUIs. So we don't run them in the ebuild

}
