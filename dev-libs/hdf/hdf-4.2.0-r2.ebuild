# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hdf/hdf-4.2.0-r2.ebuild,v 1.1 2004/02/18 07:17:36 phosphan Exp $

# substitute second dot by "r"
MY_PV=${PV/./X}
TMP_PV=${MY_PV/./r}
MY_PV=${TMP_PV/X/.}

S="${WORKDIR}/${PN}${MY_PV}"

DESCRIPTION="HDF4 is a general purpose library and file format for storing scientific data."
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/pub/outgoing/hdf4/hdf${MY_PV}/hdf${MY_PV}.tar.gz"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/hdf4.html"

LICENSE="NCSA-HDF"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

DEPEND="sys-libs/zlib
		media-libs/jpeg
		dev-libs/szip
		app-sci/netcdf
		>=sys-apps/sed-4"

src_compile() {
	local myconf="--enable-production --with-szlib=/usr"
	econf ${myconf} || die "configure failed"
	make || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README release_notes/*.txt
	cd ${D}
	einfo Renaming included versions of ncdump and ncgen to hdfdump and hdfgen, respectively
	mv -v usr/bin/ncgen usr/bin/hdfgen
	mv -v usr/bin/ncdump usr/bin/hdfdump
	mv -v usr/share/man/man1/ncgen.1 usr/share/man/man1/hdfgen.1
	mv -v usr/share/man/man1/ncdump.1 usr/share/man/man1/hdfdump.1
	if has_version app-sci/netcdf; then
		einfo app-sci/netcdf is already installed - not installing netcdf related header files
		rm -v usr/include/netcdf.inc
		rm -v usr/include/netcdf.h
	fi
}
