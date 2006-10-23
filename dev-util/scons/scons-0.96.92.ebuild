# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scons/scons-0.96.92.ebuild,v 1.1 2006/10/23 21:44:59 twp Exp $

NEED_PYTHON="1.5.2"

inherit python distutils

DESCRIPTION="Extensible Python-based build utility"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.scons.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

DOCS="RELEASE.txt CHANGES.txt LICENSE.txt"

src_install () {
	distutils_src_install
	doman scons.1 sconsign.1
}

pkg_postinst() {
	python_mod_optimize ${ROOT}/usr/$(get_libdir)/${P}
}

pkg_postrm() {
	python_mod_cleanup ${ROOT}/usr/$(get_libdir)/${P}
}
