# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/nco/nco-2.2.0.ebuild,v 1.3 2003/02/13 09:23:47 vapier Exp $

IUSE=""

DESCRIPTION="Command line utilities for operating on netCDF files"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/nco/${P}.tar.gz"
HOMEPAGE="http://nco.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

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
