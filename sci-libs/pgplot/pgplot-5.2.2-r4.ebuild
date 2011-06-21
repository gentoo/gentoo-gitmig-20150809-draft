# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/pgplot/pgplot-5.2.2-r4.ebuild,v 1.3 2011/06/21 09:51:45 jlec Exp $

EAPI=2
inherit eutils fortran-2 toolchain-funcs

MY_P="${PN}${PV//.}"
DESCRIPTION="FORTRAN/C device-independent scientific graphic library"
HOMEPAGE="http://www.astro.caltech.edu/~tjp/pgplot/"
SRC_URI="ftp://ftp.astro.caltech.edu/pub/pgplot/${MY_P}.tar.gz"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="doc motif tk"
RDEPEND="x11-libs/libX11
	x11-libs/libXt
	media-libs/libpng
	motif? ( >=x11-libs/openmotif-2.3:0 )
	tk? ( dev-lang/tk )"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base )"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-drivers.patch
	epatch "${FILESDIR}"/${PN}-makemake.patch
	epatch "${FILESDIR}"/${PN}-compile-setup.patch
	epatch "${FILESDIR}"/${PN}-headers.patch
	epatch "${FILESDIR}"/${PN}-ldflags.patch

	# gfortran < 4.3 does not compile gif, pp and wd drivers
	if [[ "$(tc-getFC)" == gfortran ]] &&
		[[ $(gcc-major-version)$(gcc-minor-version) -lt 43 ]] ; then
		ewarn
		ewarn "Warning!"
		ewarn "gfortran < 4.3 selected: does not compile all drivers"
		ewarn "disabling gif, wd, and ppd drivers"
		ewarn "if you want more drivers, use gfortran >= 4.3, g77 or ifort"
		ewarn
		epause 4
		sed -i \
			-e 's/GIDRIV/! GIDRIV/g' \
			-e 's/PPDRIV/! GIDRIV/g' \
			-e 's/WDDRIV/! GIDRIV/g' \
			drivers.list || die "sed drivers failed"
	fi

	# fix pointers for 64 bits
	if use amd64 || use ia64; then
		sed -i \
			-e 's/INTEGER PIXMAP/INTEGER*8 PIXMAP/g' \
			drivers/{gi,pp,wd}driv.f || die "sed 64bits failed"
	fi

	cp sys_linux/g77_gcc.conf local.conf

	sed -i \
		-e "s:FCOMPL=.*:FCOMPL=\"$(tc-getFC)\":g" \
		-e "s:CCOMPL=.*:CCOMPL=\"$(tc-getCC)\":g" \
		local.conf || die "sed flags failed"

	if [[ "$(tc-getFC)" = if* ]]; then
		sed -i \
			-e 's/-Wall//g' \
			-e 's/TK_LIBS="/TK_LIBS="-nofor-main /' \
			local.conf || die "sed drivers failed"
	fi

	sed -i \
		-e "s:/usr/local/pgplot:/usr/$(get_libdir)/pgplot:g" \
		-e "s:/usr/local/bin:/usr/bin:g" \
		src/grgfil.f makehtml maketex || die "sed path failed"

	use motif && sed -i -e '/XMDRIV/s/!//' drivers.list
	use tk && sed -i -e '/TKDRIV/s/!//' drivers.list
}

src_compile() {
	./makemake . linux
	einfo "Doing static libs and execs"
	emake all cpg || die "emake static failed"
	emake -j1 clean
	einfo "Doing shared libs"
	emake \
		CFLAGS="${CFLAGS} -fPIC" \
		FFLAGS="${FFLAGS} -fPIC" \
		shared cpg-shared \
		|| die "emake shared failed"

	if use doc; then
		export VARTEXFONTS="${T}/fonts"
		emake pgplot.html || die "make pgplot.html failed"
		emake pgplot-routines.tex  || die "make pgplot-routines failed"
		pdflatex pgplot-routines.tex
		pdflatex pgplot-routines.tex
	fi

	# this just cleans out not needed files
	emake -j1 clean
}

src_test() {
	einfo "Testing various demo programs"
	# i can go to 16
	for i in 1 2 3; do
		emake pgdemo${i}
		# j can also be LATEX CPS...
		for j in NULL PNG PS CPS LATEX; do
			local testexe=./test_${j}_${i}
			echo "LD_LIBRARY_PATH=. ./pgdemo${i} <<EOF" > ${testexe}
			echo "/${j}" >> ${testexe}
			echo "EOF" >> ${testexe}
			sh ${testexe} || die "test ${i} failed"
		done
	done
}

src_install() {
	insinto /usr/$(get_libdir)/pgplot
	doins grfont.dat grexec.f *.inc rgb.txt || die

	# FORTRAN libs
	dolib.a libpgplot.a || die "dolib.a failed"
	dolib.so libpgplot.so* || die "dolib.so failed"
	dobin pgxwin_server pgdisp || die "dobin failed"

	# C binding
	insinto /usr/include
	doins cpgplot.h || die "doins C binding failed"
	dolib.a libcpgplot.a || die "dolib.a failed"
	dolib.so libcpgplot.so* || die "dolib C failed"

	if use motif; then
		doins XmPgplot.h || die "doins motif failed"
		dolib.a libXmPgplot.a || die "dolib.a motif failed"
	fi

	if use tk; then
		doins tkpgplot.h || die "doins tk failed"
		dolib.a libtkpgplot.a || die "dolib.a tk failed"
	fi

	# minimal doc
	dodoc aaaread.me pgplot.doc || die "dodoc minimal doc failed"
	newdoc pgdispd/aaaread.me pgdispd.txt || die "install pgdispd doc failed"

	if use doc; then
		dodoc cpg/cpgplot.doc applications/curvefit/curvefit.doc
		dohtml pgplot.html
		insinto /usr/share/doc/${PF}
		doins pgplot-routines.pdf pgplot-routines.tex
		insinto /usr/share/doc/${PF}/examples
		doins examples/* cpg/cpgdemo.c
		insinto /usr/share/doc/${PF}/applications
		doins -r applications/*
		if use motif; then
			insinto /usr/share/doc/${PF}/pgm
			doins pgmf/* drivers/xmotif/pgmdemo.c
		fi
		if use tk; then
			insinto /usr/share/doc/${PF}/pgtk
			doins drivers/xtk/pgtkdemo.*
		fi
	fi
}
