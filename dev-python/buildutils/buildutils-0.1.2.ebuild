# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/buildutils/buildutils-0.1.2.ebuild,v 1.3 2007/07/04 19:59:16 lucass Exp $

NEED_PYTHON=2.4

inherit distutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Extensions for developing Python libraries and applications."
HOMEPAGE="http://buildutils.lesscode.org/"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
IUSE="doc test"

DEPEND="dev-python/setuptools
	doc? ( dev-python/pudge )
	test? ( dev-python/nose )"
RDEPEND=""

src_compile() {
	distutils_src_compile
	if use doc ; then
		einfo "Generating docs as requested..."
		"${python}" setup.py pudge || die "generating docs failed"
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/html/*
}

src_test() {
	PYTHONPATH=. "${python}" setup.py nosetests || die "test failed"
}
