# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/nco/nco-2.2.0.ebuild,v 1.5 2004/04/25 22:52:17 agriffis Exp $

IUSE=""

DESCRIPTION="Command line utilities for operating on netCDF files"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/nco/${P}.tar.gz"
HOMEPAGE="http://nco.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="app-sci/netcdf"

src_compile() {
	mkdir -p obj
	cd bld
	emake || die
}

src_install() {
	dobin bin/*
	dolib lib/*
	dodoc doc/*
}
