# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyx/pyx-0.6.1.ebuild,v 1.5 2004/09/11 22:30:56 lucass Exp $

IUSE=""

inherit distutils

MY_P=${P/pyx/PyX}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Python package for the generation of encapsulated PostScript figures"
SRC_URI="mirror://sourceforge/pyx/${MY_P}.tar.gz"
HOMEPAGE="http://pyx.sourceforge.net/"

DEPEND=">=dev-lang/python-2.2
	virtual/tetex"

SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"

src_install() {
	DOCS="manual/manual.ps"
	distutils_src_install

	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
