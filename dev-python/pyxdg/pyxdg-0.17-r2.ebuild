# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxdg/pyxdg-0.17-r2.ebuild,v 1.4 2009/11/28 16:25:52 tcunha Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A Python module to deal with freedesktop.org specifications"
SRC_URI="http://www.freedesktop.org/~lanius/${P}.tar.gz"
HOMEPAGE="http://pyxdg.freedesktop.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="xdg"
DOCS="AUTHORS"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-subprocess.patch"
	epatch "${FILESDIR}/${P}-respect_XDG_MENU_PREFIX.patch"
}

src_install () {
	distutils_src_install

	insinto /usr/share/doc/${P}/test
	insopts -m 755
	doins test/*
}
