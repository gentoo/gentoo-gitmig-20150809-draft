# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-docs/python-docs-2.2.2.ebuild,v 1.10 2004/07/14 21:58:01 agriffis Exp $

DESCRIPTION="HTML documentation for Python"
SRC_URI="http://www.python.org/ftp/python/doc/${PV}/html-${PV}.tar.bz2"
HOMEPAGE="http://www.python.org/doc/2.2/"
DEPEND=""
RDEPEND=""
SLOT="2.2"
LICENSE="PSF-2.2"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}


src_install() {
	docinto html
	cp -R ${S}/* ${D}/usr/share/doc/${PF}/html
	dodir /etc/env.d
	echo "PYTHONDOCS=/usr/share/doc/${PF}/html" > ${D}/etc/env.d/50python-docs
}
