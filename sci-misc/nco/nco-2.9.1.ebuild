# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/nco/nco-2.9.1.ebuild,v 1.3 2005/05/06 20:45:44 dholm Exp $

IUSE=""

DESCRIPTION="Command line utilities for operating on netCDF files"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://nco.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="sci-libs/netcdf"

src_compile() {
	econf || die "econf failed"
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
