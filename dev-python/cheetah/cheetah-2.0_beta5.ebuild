# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cheetah/cheetah-2.0_beta5.ebuild,v 1.1 2006/01/09 21:41:36 pythonhead Exp $

inherit distutils

MY_P=${P/ch/Ch}
MY_P=${MY_P/_beta/b}

DESCRIPTION="Python-powered template engine and code generator."
HOMEPAGE="http://www.cheetahtemplate.org/"
SRC_URI="mirror://sourceforge/cheetahtemplate/${MY_P}.tar.gz"
LICENSE="PSF-2.2"
IUSE=""
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc-macos ~sparc ~x86"
SLOT="0"
DEPEND=">=dev-lang/python-2.2"
S=${WORKDIR}/${MY_P}

PYTHON_MODNAME="Cheetah"
DOCS="README CHANGES TODO"

pkg_postinst() {
	ewarn "This release requires re-compilation of all compiled templates!"
}
