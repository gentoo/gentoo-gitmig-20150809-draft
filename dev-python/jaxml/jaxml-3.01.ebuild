# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jaxml/jaxml-3.01.ebuild,v 1.8 2006/07/12 15:42:00 agriffis Exp $

inherit distutils

DESCRIPTION="XML generator written in Python"
HOMEPAGE="http://www.librelogiciel.com/software/jaxml/"
SRC_URI="http://www.librelogiciel.com/software/jaxml/tarballs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"

IUSE=""
DEPEND="virtual/python"

src_install() {
	distutils_src_install
	dodir /usr/share/doc/${PF}/test
	cp -r test/* ${D}/usr/share/doc/${PF}/test/
}
