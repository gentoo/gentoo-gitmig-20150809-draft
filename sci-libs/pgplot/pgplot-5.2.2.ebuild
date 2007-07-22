# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/pgplot/pgplot-5.2.2.ebuild,v 1.3 2007/07/22 07:02:25 dberkholz Exp $

inherit eutils toolchain-funcs fortran

FORTRAN="g77"
MY_P="${PN}${PV//.}"
DESCRIPTION="A Fortran- or C-callable, device-independent graphics package for making simple scientific graphs"
HOMEPAGE="http://www.astro.caltech.edu/~tjp/pgplot/"
SRC_URI="ftp://ftp.astro.caltech.edu/pub/pgplot/${MY_P}.tar.gz"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""
RDEPEND="x11-libs/libX11
	media-libs/libpng"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-drivers.patch
	epatch ${FILESDIR}/${PN}-makemake.patch
	epatch ${FILESDIR}/${PN}-compile-setup.patch

	cp sys_linux/g77_gcc.conf local.conf

	sed -i \
		-e "s:FCOMPL=.*:FCOMPL=\"${FORTRANC}\":g" \
		-e "s:FFLAGOPT=.*:FFLAGOPT=\"${FFLAGS:- -O2}\":g" \
		-e "s:CCOMPL=.*:CCOMPL=\"$(tc-getCC)\":g" \
		-e "s:CFLAGOPT=.*:CFLAGOPT=\"${CFLAGS}\":g" \
		local.conf
}

src_compile() {
	./makemake ${S} linux

	emake -j1 || die "emake failed"

	# Build C portion
	make cpg

	# this just cleans out unneeded files
	make clean
}

src_install() {
	insinto /usr/lib/pgplot
	doins grfont.dat

	dolib.a libpgplot.a
	dolib.so libpgplot.so
	dodoc pgplot.doc
	dobin pgxwin_server

	# C binding
	insinto /usr/include
	doins cpgplot.h
	dolib.a libcpgplot.a
}
