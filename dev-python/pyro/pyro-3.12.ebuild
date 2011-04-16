# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyro/pyro-3.12.ebuild,v 1.6 2011/04/16 18:37:57 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="Pyro-${PV}"

DESCRIPTION="Advanced and powerful Distributed Object Technology system written entirely in Python"
HOMEPAGE="http://www.xs4all.nl/~irmen/pyro3/ http://pypi.python.org/pypi/Pyro"
SRC_URI="http://www.xs4all.nl/~irmen/pyro3/download/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="3"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

DEPEND="!dev-python/pyro:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="Pyro"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Installation of examples failed"
	fi
}
