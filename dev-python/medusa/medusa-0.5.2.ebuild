# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/medusa/medusa-0.5.2.ebuild,v 1.2 2003/02/13 11:35:09 vapier Exp $

DESCRIPTION="Medusa is a framework for writing long-running, high-performance network servers in Python, using asynchronous sockets"
HOMEPAGE="http://oedipus.sourceforge.net/medusa/"
SRC_URI="http://www.amk.ca/files/python/medusa-0.5.2.tar.gz"
LICENSE="PYTHON"
SLOT="0"
KEYWORDS="x86"
DEPEND="virtual/python"
S=${WORKDIR}/${P}

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --prefix=${D}/usr || die
	mkdir -p ${D}/usr/share/doc/${PF}/example
	cp -R demo/* ${D}/usr/share/doc/${PF}/example
	dodoc CHANGES.txt LICENSE.txt README.txt docs/*.txt 
	dohtml docs/*.html docs/*.gif
}
