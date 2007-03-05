# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/pgplot/pgplot-5.2.2-r1.ebuild,v 1.1 2007/03/05 18:58:23 bicatali Exp $

inherit eutils toolchain-funcs fortran

FORTRAN="g77"
MY_P="${PN}${PV//.}"
DESCRIPTION="A C/FORTRAN device-independent graphics library for making simple scientific graphs"
HOMEPAGE="http://www.astro.caltech.edu/~tjp/pgplot/"
SRC_URI="ftp://ftp.astro.caltech.edu/pub/pgplot/${MY_P}.tar.gz"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="doc"
RDEPEND="x11-libs/libX11
	media-libs/libpng"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

src_unpack() {
	fortran_src_unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-drivers.patch
	epatch "${FILESDIR}"/${PN}-makemake.patch
	epatch "${FILESDIR}"/${PN}-compile-setup.patch

	if use amd64 -o use ia64; then
		sed -i \
			-e 's/INTEGER PIXMAP/INTEGER*8 PIXMAP/g' \
			drivers/{gi,pp,wd}driv.f || die "sed 64bits failed"
	fi

	cp sys_linux/g77_gcc.conf local.conf

	sed -i \
		-e "s:FCOMPL=.*:FCOMPL=\"${FORTRANC}\":g" \
		-e "s:FFLAGOPT=.*:FFLAGOPT=\"${FFLAGS:- -O2}\":g" \
		-e "s:CCOMPL=.*:CCOMPL=\"$(tc-getCC)\":g" \
		-e "s:CFLAGOPT=.*:CFLAGOPT=\"${CFLAGS}\":g" \
		local.conf || die "sed flags failed"

	sed -i \
		-e "s:/usr/local/pgplot:/usr/$(get_libdir)/pgplot:" \
		src/grgfil.f || die "sed path failed"
}

src_compile() {
	./makemake "${S}" linux

	emake -j1 || die "emake failed"

	# Build C portion
	make cpg || die "make cpg failed"

	# this just cleans out unneeded files
	make clean
}

src_test() {
	einfo "Testing various demo programs"
	# i can go to 16
	for i in 1 2 3; do
		make pgdemo${i}
		# j can also be LATEX CPS...
		for j in GIF PNG PS; do
			local testexe=./test_${j}_${i}
			echo "./pgdemo${i} <<EOF" > ${testexe}
			echo "/${j}" >> ${testexe}
			echo "EOF" >> ${testexe}
			sh ${testexe} || die "test ${i} failed"
		done
	done
}

src_install() {
	insinto /usr/$(get_libdir)/pgplot
	doins grfont.dat grexec.f grpckg1.inc rgb.txt

	# FORTRAN libs
	dolib.a libpgplot.a
	dolib.so libpgplot.so
	dosym libpgplot.so.5 /usr/$(get_libdir)/libpgplot.so
	dobin pgxwin_server

	# C binding
	insinto /usr/include
	doins cpgplot.h
	dolib.a libcpgplot.a
	# shared lib: todo eventually in a patch
	# dolib.so libcpgplot.so
	# dosym libcpgplot.so.5 /usr/$(get_libdir)/libcpgplot.so

	# minimal doc
	dodoc aaaread.me pgplot.doc

	if use doc; then
		dodoc cpg/cpgplot.doc applications/curvefit/curvefit.doc
		dohtml pgplot.html
		insinto /usr/share/doc/${PF}/examples
		doins examples/* cpg/cpgdemo.c
		insinto /usr/share/doc/${PF}/pgm
		doins pgmf/* drivers/xmotif/pgmdemo.c
	fi
}
