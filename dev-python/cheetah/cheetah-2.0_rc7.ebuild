# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah/cheetah-2.0_rc7.ebuild,v 1.2 2007/02/05 18:16:36 dev-zero Exp $

NEED_PYTHON=2.2

inherit distutils

MY_PN=Cheetah
MY_P=${MY_PN}-${PV/_}

DESCRIPTION="Python-powered template engine and code generator."
HOMEPAGE="http://www.cheetahtemplate.org/"
SRC_URI="mirror://sourceforge/cheetahtemplate/${MY_P}.tar.gz"
LICENSE="PSF-2.2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc-macos ~sparc ~x86"
SLOT="0"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${MY_P}
PYTHON_MODNAME="Cheetah"
DOCS="README CHANGES TODO"

pkg_postinst() {
	ewarn "This release requires re-compilation of all compiled templates!"
}

src_test() {
	PYTHONPATH=$(ls -d ./build/lib.*) "${python}" src/Tests/Test.py || die "tests failed"
}
