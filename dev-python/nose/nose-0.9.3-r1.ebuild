# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose/nose-0.9.3-r1.ebuild,v 1.8 2008/12/07 19:22:45 vapier Exp $

NEED_PYTHON=2.2

inherit distutils eutils

KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 s390 ~sparc x86"

DESCRIPTION="An alternate test discovery and running process for unittest."
HOMEPAGE="http://somethingaboutorange.com/mrl/projects/nose/"
SRC_URI="http://somethingaboutorange.com/mrl/projects/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc examples twisted"

RDEPEND="dev-python/setuptools
	twisted? ( dev-python/twisted )"
DEPEND="${RDEPEND}
	doc? ( dev-python/docutils )"

src_unpack() {
	distutils_src_unpack

	# If twisted is in USE, disable twisted tests that access the network
	# else remove nose.twistedtools and related tests
	use twisted && epatch "${FILESDIR}/${P}-tests-nonetwork.patch"
	use twisted || rm nose/twistedtools.py unit_tests/test_twisted*
}

src_compile() {
	distutils_src_compile
	if use doc ; then
		PYTHONPATH=. scripts/mkindex.py
	fi
}

src_install() {
	DOCS="AUTHORS NEWS"
	distutils_src_install --install-data /usr/share

	use doc && dohtml index.html

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	PYTHONPATH=. "${python}" setup.py test || die "test failed"
}
