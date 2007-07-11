# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose/nose-0.10.0_alpha1.ebuild,v 1.2 2007/07/11 06:19:47 mr_bones_ Exp $

NEED_PYTHON=2.2

inherit distutils

MY_PV="${PV/_alpha/a}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A unittest extension offering automatic test suite discovery and easy test authoring"
HOMEPAGE="http://somethingaboutorange.com/mrl/projects/nose/"
SRC_URI="http://somethingaboutorange.com/mrl/projects/nose/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"
IUSE="doc examples"
RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	doc? ( dev-python/docutils )"

src_compile() {
	distutils_src_compile
	if use doc ; then
		PYTHONPATH=. scripts/mkindex.py
	fi
}

src_install() {
	DOCS="AUTHORS NEWS"
	distutils_src_install

	use doc && dohtml index.html

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	PYTHONPATH=. "${python}" setup.py test || die "test failed"
}
