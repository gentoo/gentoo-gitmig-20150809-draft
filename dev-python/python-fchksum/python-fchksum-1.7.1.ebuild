# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-fchksum/python-fchksum-1.7.1.ebuild,v 1.16 2004/10/23 08:12:50 mr_bones_ Exp $

# DON'T inherit distutils because it will cause a circular dependency with python
#inherit distutils

DESCRIPTION="Python module to find the checksum of files"
HOMEPAGE="http://www.dakotacom.net/~donut/programs/fchksum.html"
SRC_URI="http://www.dakotacom.net/~donut/programs/fchksum/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ppc64 sparc mips alpha arm hppa ~mips amd64 ~ia64 s390 ~ppc-macos"
IUSE=""

DEPEND="sys-libs/zlib"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} || die
}
