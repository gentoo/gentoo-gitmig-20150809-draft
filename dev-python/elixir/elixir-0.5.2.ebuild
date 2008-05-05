# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elixir/elixir-0.5.2.ebuild,v 1.2 2008/05/05 20:58:11 pythonhead Exp $

NEED_PYTHON=2.4

inherit distutils

KEYWORDS="~amd64 ~x86"

MY_PN=Elixir
MY_P=${MY_PN}-${PV}

DESCRIPTION="A declarative layer on top of SQLAlchemy."
HOMEPAGE="http://elixir.ematia.de/"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
IUSE="doc examples test"

RDEPEND=">=dev-python/sqlalchemy-0.3.0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( >=dev-python/docutils-0.4-r3
		>=dev-python/elementtree-1.2.6
		>=dev-python/kid-0.9
		>=dev-python/pygments-0.8.1
		>=dev-python/pudge-0.1.3
		>=dev-python/buildutils-0.1.2 )
	test? ( dev-python/nose )"

S=${WORKDIR}/${MY_P}

src_compile() {
	distutils_src_compile
	if use doc ; then
		einfo "Generating docs as requested..."
		${python} setup.py addcommand -p buildutils.pudge_command
		PYTHONPATH=. "${python}" setup.py pudge || die "generating docs failed"
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml -r build/doc/*
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

src_test() {
	PYTHONPATH=. "${python}" setup.py test || die "tests failed"
}
