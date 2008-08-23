# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/mars/mars-08.06.26.ebuild,v 1.1 2008/08/23 13:27:42 lu_zero Exp $

inherit autotools

DESCRIPTION="Multicore Application Runtime System"
HOMEPAGE="ftp://ftp.infradead.org/pub/Sony-PS3/mars/"
SRC_URI="ftp://ftp.infradead.org/pub/Sony-PS3/mars/${P}.tar.gz"

LICENSE="MARS"
SLOT="0"
KEYWORDS="~ppc64"
IUSE=""

DEPEND="sys-libs/libspe2"
RDEPEND="${DEPEND}"

src_unpack () {
	unpack ${A}
	cd "${S}"
	# repeat after me: "dummy triplet are bogus"
	sed -i -e "s:ppu-::" -e "s:spu:spu-elf:g" \
		-e "s:embedspu-elf:embedspu:" src/mpu/configure.ac || die
	sed -i -e "s:ppu:${CHOST}:" src/host/configure.ac || die
	sed -i -e "s:spu/include:spu-elf/include:" include/Makefile.am || die
	eautoreconf
}

src_compile () {
	unset CFLAGS
	unset CXXFLAGS
	unset CFLAGS_ppc64
	econf || die
	emake || die
}

src_install () {
	emake -j1 DESTDIR="${D}" install
}
