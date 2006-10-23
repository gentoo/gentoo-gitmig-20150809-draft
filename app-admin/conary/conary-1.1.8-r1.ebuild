# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/conary/conary-1.1.8-r1.ebuild,v 1.1 2006/10/23 14:14:38 smithj Exp $

DESCRIPTION="repository-based system management and package-building tool"
HOMEPAGE="http://wiki.rpath.com/wiki/Conary"
SRC_URI="ftp://download.rpath.com/conary/${P}.tar.bz2"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-lang/python-2.4*
		dev-python/kid
		dev-python/elementtree
		dev-db/sqlite
		dev-python/pycrypto
		dev-libs/elfutils"

PDEPEND="app-admin/conary-policy"

src_compile() {
	emake || die "Make failure"
}

src_install() {
	make DESTDIR=${D} install
	dodoc LICENSE NEWS conary/ScanDeps/README conary/pysqlite3/{LICENSE,README}
}
