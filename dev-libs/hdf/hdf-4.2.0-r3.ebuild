# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hdf/hdf-4.2.0-r3.ebuild,v 1.5 2004/11/04 13:32:40 phosphan Exp $

inherit flag-o-matic

# substitute second dot by "r"
MY_PV=${PV/./X}
TMP_PV=${MY_PV/./r}
MY_PV=${TMP_PV/X/.}

S="${WORKDIR}/${PN}${MY_PV}"

DESCRIPTION="HDF4 is a general purpose library and file format for storing scientific data."
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/pub/outgoing/hdf4/hdf${MY_PV}/hdf${MY_PV}.tar.gz"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/hdf4.html"

LICENSE="NCSA-HDF"
KEYWORDS="x86 ~amd64 ppc"
SLOT="0"
IUSE="szip"

DEPEND="sys-libs/zlib
		media-libs/jpeg
		app-sci/netcdf
		>=sys-apps/sed-4
		szip? ( dev-libs/szip )"

pkg_setup() {
	if ! which &>/dev/null g77; then
		die "g77 not found, please re-emerge gcc with f77 in your USE flags."
	fi
}

src_compile() {
	local myconf="--enable-production"
	use szip && myconf="${myconf} --with-szlib=/usr"
	use ppc && append-flags -DSUN
	econf ${myconf} || die "configure failed"
	make LDFLAGS="${LDFLAGS} -lm" || die "make failed"
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
