# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-docs/python-docs-2.2.1.ebuild,v 1.11 2003/06/22 12:16:00 liquidx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HTML documentation for Python"
SRC_URI="http://www.python.org/ftp/python/doc/${PV}/html-${PV}.tar.bz2"
HOMEPAGE="http://www.python.org/doc/2.2/"
DEPEND=""
RDEPEND=""
SLOT="2.2"
LICENSE="PSF-2.2"
KEYWORDS="x86 ppc sparc alpha"

src_unpack() {
	mkdir ${S}
	cd ${S} 
	unpack ${A} 
}


src_install() {
	docinto html
	cp -R ${S}/* ${D}/usr/share/doc/${P}/html
	chown -R root.root ${D}/usr/share/doc/${P}/html
	find ${D}/usr/share/doc/${P}/html -type d -exec chmod 0755 \{\} \;
	find ${D}/usr/share/doc/${P}/html -type f -exec chmod 0644 \{\} \;
}
