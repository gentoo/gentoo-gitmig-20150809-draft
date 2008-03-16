# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lxml/lxml-2.0.2.ebuild,v 1.2 2008/03/16 23:09:33 jer Exp $

NEED_PYTHON="2.3"

inherit distutils eutils multilib

DESCRIPTION="A Pythonic binding for the libxml2 and libxslt libraries"
HOMEPAGE="http://codespeak.net/lxml/"
SRC_URI="http://codespeak.net/lxml/${P}.tgz"
LICENSE="BSD ElementTree GPL-2 PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~x86"
IUSE="doc examples"

# Note: This version comes with it's own bundled svn version of pyrex
RDEPEND=">=dev-libs/libxml2-2.6.20
		>=dev-libs/libxslt-1.1.15"
DEPEND="${RDEPEND}
	>=dev-python/setuptools-0.6_rc5"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml doc/html/*
		dodoc *.txt
		docinto doc
		dodoc doc/*.txt
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r samples/*
	fi
}

src_test() {
	distutils_python_version
	python setup.py build_ext -i || die "building extensions for test use failed"
	einfo "Running test"
	"${python}" test.py || die "tests failed"
	export PYTHONPATH="${PYTHONPATH}:${S}/src"
	einfo "Running selftest"
	"${python}" selftest.py || die "selftest failed"
	einfo "Running selftest2"
	"${python}" selftest2.py || die "selftest2 failed"
}
