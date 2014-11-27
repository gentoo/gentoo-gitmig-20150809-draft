# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pyhoca-cli/pyhoca-cli-0.5.0.1.ebuild,v 1.1 2014/11/27 14:16:53 voyageur Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="X2Go command line client"
HOMEPAGE="http://www.x2go.org"
SRC_URI="http://code.x2go.org/releases/source/${PN}/${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setproctitle[${PYTHON_USEDEP}]
	net-misc/python-x2go[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_install() {
	distutils-r1_python_install
	python_doexe pyhoca-cli
}

python_install_all() {
	distutils-r1_python_install_all
	doman man/man1/*
}
