# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elixir/elixir-0.7.1.ebuild,v 1.1 2009/12/21 06:37:53 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="Elixir"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Declarative Mapper for SQLAlchemy"
HOMEPAGE="http://elixir.ematia.de/trac/wiki http://pypi.python.org/pypi/Elixir"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-python/sqlalchemy-0.4.0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( >=dev-python/docutils-0.4-r3
		>=dev-python/elementtree-1.2.6
		>=dev-python/kid-0.9
		>=dev-python/pygments-0.8.1
		>=dev-python/pudge-0.1.3
		>=dev-python/buildutils-0.3 )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile

	if use doc; then
		python_version
		einfo "Generation of documentation"
		"${python}" setup.py addcommand -p buildutils.pudge_command
		PYTHONPATH=. "${python}" setup.py pudge || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r build/doc/*
	fi
}
