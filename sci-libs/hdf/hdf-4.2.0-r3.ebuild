# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf/hdf-4.2.0-r3.ebuild,v 1.3 2005/01/25 22:05:47 kugelfang Exp $

inherit flag-o-matic fortran

# substitute second dot by "r"
MY_PV=${PV/./X}
TMP_PV=${MY_PV/./r}
MY_PV=${TMP_PV/X/.}

S="${WORKDIR}/${PN}${MY_PV}"

DESCRIPTION="HDF4 is a general purpose library and file format for storing scientific data."
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/pub/outgoing/hdf4/hdf${MY_PV}/hdf${MY_PV}.tar.gz"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/hdf4.html"

LICENSE="NCSA-HDF"
KEYWORDS="x86 amd64 ppc"
SLOT="0"
IUSE="szip"

DEPEND="sys-libs/zlib
		media-libs/jpeg
		sci-libs/netcdf
		>=sys-apps/sed-4
		szip? ( sci-libs/szip )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-shared-libs.patch
}

src_compile() {
	# We need shared libraries, see BUG #75415.
	# To use libtool for shared libs, we need above patch and the following lines.
	# Danny van Dyk <kugelfang@gentoo.org> 2005/01/24
	aclocal
	libtoolize --copy --force
	automake --add-missing
	autoconf

	# BUG #75415, the shipped config/linux-gnu settings are broken.
	# -Wsign-compare does not work with g77, causing lack of -fPIC for shared
	# objects.
	sed -i -e 's|-Wsign-compare||g' ${S}/config/linux-gnu

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
	if has_version sci-libs/netcdf; then
		einfo sci-libs/netcdf is already installed - not installing netcdf related header files
		rm -v usr/include/netcdf.inc
		rm -v usr/include/netcdf.h
	fi
}
