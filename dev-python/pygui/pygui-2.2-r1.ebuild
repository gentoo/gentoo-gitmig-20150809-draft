# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygui/pygui-2.2-r1.ebuild,v 1.1 2010/02/20 19:01:38 grozin Exp $
EAPI=3
PYTHON_DEPEND=2
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils eutils

DESCRIPTION="A cross-platform pythonic GUI API"
HOMEPAGE="http://www.cosc.canterbury.ac.nz/greg.ewing/python_gui/"

MY_P=PyGUI-${PV}
PYTHON_MODNAME=GUI
SRC_URI="http://www.cosc.canterbury.ac.nz/greg.ewing/python_gui/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT=0
KEYWORDS="~x86"
IUSE="doc examples"

RDEPEND="dev-python/pygtk"
DEPEND=""

S="${WORKDIR}"/${MY_P}

src_prepare() {
	distutils_src_prepare

	# "as" is a keyword
	epatch "${FILESDIR}"/${P}-python-2.6.patch

	# Fixing a typo in setup.py
	epatch "${FILESDIR}"/${P}-resources.patch
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml Doc/* || die "Installing html documentation failed"
	fi

	if use examples; then
		pushd Tests
		insinto /usr/share/doc/${PF}/examples
		doins *.py *.tiff *.jpg || die "Installing examples failed"
		doins -r ../Demos/* || die "Installing demos failed"
		popd
	fi
}
