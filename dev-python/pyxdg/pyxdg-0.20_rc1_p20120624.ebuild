# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxdg/pyxdg-0.20_rc1_p20120624.ebuild,v 1.1 2012/06/24 16:01:53 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.6 3:3.2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 3.1 *-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="A Python module to deal with freedesktop.org specifications"
HOMEPAGE="http://freedesktop.org/wiki/Software/pyxdg http://cgit.freedesktop.org/xdg/pyxdg/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

PYTHON_MODNAME=xdg

DOCS="AUTHORS ChangeLog README TODO"

src_install() {
	distutils_src_install

	if use examples; then
		docinto examples
		dodoc test/*.py
	fi
}
