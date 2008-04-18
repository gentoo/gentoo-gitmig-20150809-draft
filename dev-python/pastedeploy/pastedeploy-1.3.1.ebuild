# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pastedeploy/pastedeploy-1.3.1.ebuild,v 1.1 2008/04/18 13:09:14 hawking Exp $

NEED_PYTHON=2.4

inherit eutils distutils multilib

KEYWORDS="~amd64 ~x86"

MY_PN=PasteDeploy
MY_P=${MY_PN}-${PV}

DESCRIPTION="Load, configure, and compose WSGI applications and servers"
HOMEPAGE="http://pythonpaste.org/deploy/"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
IUSE="doc test"

RDEPEND="dev-python/paste"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/pudge dev-python/buildutils )
	test? ( dev-python/nose dev-python/py )"

S=${WORKDIR}/${MY_P}

PYTHON_MODNAME="paste/deploy"

src_compile() {
	distutils_src_compile
	if use doc ; then
		einfo "Generating docs as requested..."
		PYTHONPATH=. "${python}" setup.py pudge || die "generating docs failed"
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/html/*
}

src_test() {
	# Tests can't import paste from site-packages
	# so we copy them over.
	# The files that will be installed are already copied to build/lib
	# so this shouldn't generate any collisions.
	distutils_python_version
	cp -pPR /usr/$(get_libdir)/python${PYVER}/site-packages/paste/* paste/

	PYTHONPATH=. "${python}" setup.py nosetests || die "tests failed"
}
