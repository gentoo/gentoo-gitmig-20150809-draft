# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyx/pyx-0.6.3.ebuild,v 1.1 2004/09/11 22:21:27 lucass Exp $

inherit distutils

MY_P=${P/pyx/PyX}
DESCRIPTION="Python package for the generation of encapsulated PostScript figures"
SRC_URI="mirror://sourceforge/pyx/${MY_P}.tar.gz"
HOMEPAGE="http://pyx.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/python
	virtual/tetex"

S=${WORKDIR}/${MY_P}
DOCS="AUTHORS CHANGES INSTALL"

src_install() {
	distutils_src_install
	cp -r manual/manual.pdf faq/pyxfaq.pdf examples ${D}/usr/share/doc/${PF}/
}
