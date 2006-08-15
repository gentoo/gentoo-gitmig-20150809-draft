# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tpg/tpg-3.1.0.ebuild,v 1.1 2006/08/15 19:09:29 carlo Exp $

inherit distutils

MY_P="TPG-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Toy Parser Generator for Python"
HOMEPAGE="http://christophe.delord.free.fr/en/tpg/"
SRC_URI="http://christophe.delord.free.fr/soft/tpg/${MY_P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~ia64 ~ppc ~x86"
IUSE="doc examples"

DEPEND="virtual/python"

DOCS="ChangeLog THANKS"

src_install() {
	distutils_src_install
	use doc && dodoc doc/tpg.pdf
	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
