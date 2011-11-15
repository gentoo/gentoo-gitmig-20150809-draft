# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoopm/gentoopm-0.2.3.ebuild,v 1.1 2011/11/15 19:02:59 mgorny Exp $

EAPI=4

PYTHON_DEPEND='2:2.6'
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS='2.4 2.5 3.*'
DISTUTILS_SRC_TEST=setup.py

inherit base distutils

DESCRIPTION="A common interface to Gentoo package managers"
HOMEPAGE="https://github.com/mgorny/gentoopm/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="|| ( >=sys-apps/portage-2.1.10.3
		sys-apps/pkgcore
		>=sys-apps/paludis-0.64.2[python-bindings] )"
DEPEND="doc? ( dev-python/epydoc )"
PDEPEND="app-admin/eselect-package-manager"

src_prepare() {
	base_src_prepare
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile

	if use doc; then
		"$(PYTHON -2)" setup.py doc || die
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/*
	fi
}
