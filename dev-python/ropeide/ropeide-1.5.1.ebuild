# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ropeide/ropeide-1.5.1.ebuild,v 1.1 2008/09/02 22:17:37 pythonhead Exp $

NEED_PYTHON="2.5"

inherit distutils

DESCRIPTION="Python refactoring IDE"
HOMEPAGE="http://rope.sourceforge.net/"
SRC_URI="mirror://sourceforge/rope/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
DEPEND=">=dev-python/rope-0.8.4"

pkg_setup() {
	distutils_python_tkinter
}

src_install() {
	distutils_src_install
	use doc && dodoc docs/*.txt
}

src_test() {
	#Tests require a running X server and test module from dev-python/rope
	#which isn't installed.
	true
}
