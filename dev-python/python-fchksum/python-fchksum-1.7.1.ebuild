# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-fchksum/python-fchksum-1.7.1.ebuild,v 1.18 2004/11/18 03:41:30 kito Exp $

# DON'T inherit distutils because it will cause a circular dependency with python
#inherit distutils

DESCRIPTION="Python module to find the checksum of files"
HOMEPAGE="http://www.dakotacom.net/~donut/programs/fchksum.html"
SRC_URI="http://www.dakotacom.net/~donut/programs/fchksum/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sh sparc x86"

IUSE=""

DEPEND="sys-libs/zlib"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} || die
}
