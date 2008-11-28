# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/reverend/reverend-0.3.ebuild,v 1.1 2008/11/28 01:39:20 neurogeek Exp $

inherit distutils

MY_P=R${P#r}

DESCRIPTION="Reverend - Simple Bayesian classifier"
SRC_URI="mirror://sourceforge/reverend/${MY_P}.tar.gz"
HOMEPAGE="http://divmod.org/trac/wiki/DivmodReverend"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="virtual/python"

DOCS="README.txt changelog.txt"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}/${P}-email.patch"
}


src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
