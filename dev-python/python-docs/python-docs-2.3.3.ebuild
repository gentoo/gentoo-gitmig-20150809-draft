# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-docs/python-docs-2.3.3.ebuild,v 1.1 2004/01/03 03:47:40 liquidx Exp $

DESCRIPTION="HTML documentation for Python"
SRC_URI="http://www.python.org/ftp/python/doc/${PV}/html-${PV}.tar.bz2"
HOMEPAGE="http://www.python.org/doc/2.3/"

IUSE=""
SLOT="2.3"
KEYWORDS="~x86 ~ppc" # ~sparc ~alpha ~hppa ~ia64 ~amd64"
LICENSE="PSF-2.2"

DEPEND=""
RDEPEND=""
S=${WORKDIR}

src_install() {
	docinto html
	cp -R ${S}/* ${D}/usr/share/doc/${PF}/html
	dodir /etc/env.d
	echo "PYTHONDOCS=/usr/share/doc/${PF}/html" > ${D}/etc/env.d/50python-docs
}
