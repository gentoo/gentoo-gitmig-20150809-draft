# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/nco/nco-2.9.1.ebuild,v 1.1 2004/03/05 10:10:18 phosphan Exp $

IUSE=""

DESCRIPTION="Command line utilities for operating on netCDF files"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://nco.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="app-sci/netcdf"

src_compile() {
	econf
	emake

	#need to make info
	cd doc
	make
}

src_install() {
	DESTDIR=${D} make install

	cd doc
	dodoc ANNOUNCE ChangeLog LICENSE MANIFEST NEWS README TAG TODO VERSION *.txt
	dohtml *.shtml
	doinfo *.info*
}
