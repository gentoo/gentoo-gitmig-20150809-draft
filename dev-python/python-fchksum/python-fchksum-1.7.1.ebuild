# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-fchksum/python-fchksum-1.7.1.ebuild,v 1.5 2004/03/28 11:45:05 kloeri Exp $

# DON'T inherit distutils because it will cause a circular dependency with python
#inherit distutils

DESCRIPTION="Python module to find the checksum of files"
SRC_URI="http://www.dakotacom.net/~donut/programs/fchksum/${P}.tar.gz"
HOMEPAGE="http://www.dakotacom.net/~donut/programs/fchksum.html"

IUSE=""
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64 ppc64 s390"
LICENSE="GPL-2"
SLOT="0"

DEPEND="sys-libs/zlib"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} || die
}
