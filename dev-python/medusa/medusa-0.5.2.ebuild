# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/medusa/medusa-0.5.2.ebuild,v 1.5 2003/06/22 12:15:59 liquidx Exp $

inherit distutils

IUSE=""
DESCRIPTION="Medusa is a framework for writing long-running, high-performance network servers in Python, using asynchronous sockets"
HOMEPAGE="http://oedipus.sourceforge.net/medusa/"
SRC_URI="http://www.amk.ca/files/python/medusa-0.5.2.tar.gz"
LICENSE="PYTHON"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/python"
S=${WORKDIR}/${P}

src_install () {
	mydoc="CHANGES.txt LICENSE.txt README.txt docs/*.txt"
	distutils_src_install
	
	dodir /usr/share/doc/${PF}/example
	cp -r demo/* ${D}/usr/share/doc/${PF}/example
	dohtml docs/*.html docs/*.gif
}
