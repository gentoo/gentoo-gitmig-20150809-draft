# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxdg/pyxdg-0.18.ebuild,v 1.1 2009/12/21 06:53:42 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A Python module to deal with freedesktop.org specifications"
SRC_URI="http://people.freedesktop.org/~lanius/${P}.tar.gz"
HOMEPAGE="http://pyxdg.freedesktop.org/ http://people.freedesktop.org/~lanius/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="xdg"
DOCS="AUTHORS"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-subprocess.patch"
}

src_install () {
	distutils_src_install

	insinto /usr/share/doc/${PF}/tests
	insopts -m 755
	doins test/*
}
