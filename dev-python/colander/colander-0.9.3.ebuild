# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/colander/colander-0.9.3.ebuild,v 1.1 2011/07/30 01:43:51 rafaelmartins Exp $

EAPI=3

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="A simple schema-based serialization and deserialization library"
HOMEPAGE="http://docs.repoze.org/colander http://pypi.python.org/pypi/colander"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="dev-python/translationstring
	dev-python/iso8601"

DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

src_prepare() {
	distutils_src_prepare

	# fix sphinx theme. pylons theme not include in source
	sed -i -e 's/pylons/default/' docs/conf.py || die 'sed failed.'
}

src_compile() {
	distutils_src_compile

	if use doc; then
		cd docs
		mkdir _themes
		emake html || die "make html failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/* || die "dohtml failed"
	fi
}
