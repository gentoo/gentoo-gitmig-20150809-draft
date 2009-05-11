# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf/hdf-4.2.0-r4.ebuild,v 1.5 2009/05/11 07:15:32 nerdboy Exp $

inherit autotools eutils flag-o-matic fortran toolchain-funcs

# substitute second dot by "r"
MY_PV="${PV/./X}"
TMP_PV="${MY_PV/./r}"
MY_PV="${TMP_PV/X/.}"

S="${WORKDIR}/${PN}${MY_PV}"

DESCRIPTION="HDF4 is a general purpose library and file format for storing scientific data."
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/pub/outgoing/hdf4/hdf${MY_PV}/hdf${MY_PV}.tar.gz"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/hdf4.html"

LICENSE="NCSA-HDF"
KEYWORDS="amd64 ppc x86"
SLOT="0"
IUSE="szip"

DEPEND="sys-libs/zlib
		media-libs/jpeg
		>=sys-apps/sed-4
		szip? ( sci-libs/szip )"

pkg_setup() {
	fortran_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We need shared libraries, see BUG #75415.
	# Danny van Dyk <kugelfang@gentoo.org> 2005/01/24
	epatch "${FILESDIR}"/${P}-shared-libs.patch
	eautoreconf
}

src_compile() {
	# BUG #75415, the shipped config/linux-gnu settings are broken.
	# -Wsign-compare does not work with g77, causing lack of -fPIC for shared
	# objects.
	sed -i \
	    -e 's|-Wsign-compare||g' \
	    -e "s|/some/default/compiler/named/foo|$(tc-getCXX)|" \
	    -e "s|BASENAME=foo|$(tc-getCXX)|" \
	    -e "s|CC=gcc|CC=$(tc-getCC)|" \
	    -e "s|CC_BASENAME=gcc|CC_BASENAME=$(tc-getCC)|" \
	    -e "s|F77=g77|F77=${FORTRANC}|" \
	    -e "s|F77_BASENAME=g77|F77_BASENAME=${FORTRANC}|" \
	    -e "s|-O3 -fomit-frame-pointer|${CFLAGS}|" \
	    "${S}"/config/linux-gnu || die

	local myconf="--enable-production --with-fortran"

	use szip && myconf="${myconf} --with-szlib=/usr"
	use ppc && append-flags -DSUN

	econf \
		${myconf} \
		F77="${FORTRANC} -fno-second-underscore -std=legacy -ff2c" \
		|| die "configure failed"

	make LDFLAGS="${LDFLAGS} -lm" || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README release_notes/*.txt || die
	cd "${D}"
	einfo "Renaming included versions of ncdump and ncgen to hdfdump and hdfgen, respectively."
	mv -v usr/bin/ncgen usr/bin/hdfgen || die
	mv -v usr/bin/ncdump usr/bin/hdfdump || die
	mv -v usr/share/man/man1/ncgen.1 usr/share/man/man1/hdfgen.1 || die
	mv -v usr/share/man/man1/ncdump.1 usr/share/man/man1/hdfdump.1 || die
	if has_version sci-libs/netcdf; then
		einfo '"sci-libs/netcdf" is already installed - not installing netcdf related header files.'
		rm -v usr/include/netcdf.inc || die
		rm -v usr/include/netcdf.h || die
	fi
}
