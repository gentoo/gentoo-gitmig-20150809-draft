# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/4suite/4suite-0.11.1.ebuild,v 1.2 2004/03/23 09:51:42 liquidx Exp $

inherit distutils

MY_P=${P/4s/4S}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="ftp://ftp.4suite.org/pub/4Suite/old/4Suite/${PV}/${MY_P}.tar.gz"
HOMEPAGE="http://www.4suite.org/"

DEPEND="virtual/python
	>=dev-python/pyxml-0.6.5"

SLOT="0"
KEYWORDS="x86 sparc alpha ~ppc"
LICENSE="Apache-1.1"

PYTHON_MODNAME="Ft _xmlplus"

src_install() {
	distutils_src_install
	rm -rf ${D}/usr/share/doc/${PF}
	mv ${D}/usr/doc/${MY_P} ${D}/usr/share/doc/${PF}
}
