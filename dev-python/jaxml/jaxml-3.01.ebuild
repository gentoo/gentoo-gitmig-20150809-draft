# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jaxml/jaxml-3.01.ebuild,v 1.1 2004/08/23 06:17:43 pythonhead Exp $

inherit distutils

DESCRIPTION="XML generator written in Python"
HOMEPAGE="http://www.librelogiciel.com/software/jaxml/"
SRC_URI="http://www.librelogiciel.com/software/jaxml/tarballs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/python"

src_install() {
	distutils_src_install
	dodir /usr/share/doc/${PF}/test
	cp -r test/* ${D}/usr/share/doc/${PF}/test/
}
