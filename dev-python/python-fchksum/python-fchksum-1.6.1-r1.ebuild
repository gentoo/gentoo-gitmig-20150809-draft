# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-fchksum/python-fchksum-1.6.1-r1.ebuild,v 1.24 2004/12/11 00:38:36 eradicator Exp $

# DON'T inherit distutils because it will cause a circular dependency with python
#inherit distutils

DESCRIPTION="Python module to find the checksum of files"
SRC_URI="http://www.dakotacom.net/~donut/programs/fchksum/${P}.tar.gz"
HOMEPAGE="http://www.dakotacom.net/~donut/programs/fchksum.html"

KEYWORDS="amd64 x86 ppc sparc alpha hppa mips ia64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="sys-libs/zlib
	virtual/python"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} || die
}
