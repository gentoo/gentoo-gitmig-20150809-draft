# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygments/pygments-0.8.ebuild,v 1.2 2007/06/18 12:29:51 corsair Exp $

inherit eutils distutils

MY_PN="Pygments"
MY_P="${MY_PN}-${PV}"
NEED_PYTHON=2.3

DESCRIPTION="Pygments is a syntax highlighting package written in Python."
HOMEPAGE="http://pygments.org/"
SRC_URI="http://cheeseshop.python.org/packages/source/P/${MY_PN}/${MY_P}.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc64 ~x86"
SLOT="0"
IUSE="doc"
S=${WORKDIR}/${MY_P}
PYTHON_MODNAME="pygments"
DOCS="CHANGES"

src_unpack() {
	unpack ${A}
	cd ${S}
	#Gentoo patches to make lexer recognize ebuilds as bash input
	epatch ${FILESDIR}/${P}-other.py-ebuild.patch || die "Patch failed"
	epatch ${FILESDIR}/${P}-_mapping.py-ebuild.patch || die "Patch failed"
}

src_install(){
	distutils_src_install
	use doc && dohtml -r docs/build/.
}

src_test() {
	PYTHONPATH=. "${python}" tests/run.py || die "tests failed"
}
