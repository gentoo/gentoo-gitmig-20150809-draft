# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simpleparse/simpleparse-2.1.0_alpha1.ebuild,v 1.5 2009/09/12 18:14:48 armin76 Exp $

inherit distutils eutils

MY_P="SimpleParse-${PV/_alpha/a}"

DESCRIPTION="A Parser Generator for mxTextTools."
HOMEPAGE="http://simpleparse.sourceforge.net"
SRC_URI="mirror://sourceforge/simpleparse/${MY_P}.zip"
LICENSE="as-is eGenixPublic-1.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE="doc examples"

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_P}

# Maintainer notes:
# * not calling distutils_src_unpack by intention (otherwise the ez_setup.py gets installed)
# * this package contains a patched copy of mxTextTools (from egenix-mx-base) but that copy
#   can't be replaced by the original one (tests fail badly).

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e '/data_files/d' \
		setup.py || die "sed failed"

	rm {examples,tests}/__init__.py

	epatch "${FILESDIR}/${P}-python-2.6.patch"
}

src_install() {
	distutils_src_install

	if use doc ; then
		dohtml -r doc/*
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	distutils_python_version
	PYTHONPATH="$(ls -d build/lib.*):." "${python}" tests/test.py || die "tests failed"
}
