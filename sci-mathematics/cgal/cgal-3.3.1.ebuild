# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/cgal/cgal-3.3.1.ebuild,v 1.2 2008/11/17 10:13:00 bicatali Exp $

EAPI=2

inherit eutils toolchain-funcs

MYP=CGAL-${PV}

DESCRIPTION="C++ library for geometric algorithms and data structures"
HOMEPAGE="http://www.cgal.org/"
SRC_URI="ftp://ftp.mpi-sb.mpg.de/pub/outgoing/CGAL/${MYP}.tar.gz"

LICENSE="LGPL-2.1 QPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples gmp lapack opengl qt3 taucs X zlib"

RDEPEND="dev-libs/boost
	dev-libs/mpfr
	lapack? ( virtual/lapack )
	opengl? ( virtual/opengl )
	qt3? ( x11-libs/qt:3 )
	taucs? ( sci-libs/taucs )
	X? ( x11-libs/libX11 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	lapack? ( dev-util/pkgconfig )"

S="${WORKDIR}/${MYP}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-rpath.patch
	# a patch from debian on missing qt headers
	epatch "${FILESDIR}"/${P}-qt.patch
	# sed for blas and lapack gentoo style
	sed -e 's/Intel MKL/Gentoo BLAS-LAPACK/' \
		-e "s/^LIBS.=.*/LIBS=$(pkg-config --libs-only-l lapack | sed 's/-l//g')/" \
		-e "s/^STDLIBDIRS.=*/STDLIBDIRS=$(pkg-config --libs-only-L lapack | sed 's/-L//g')/" \
		config/support/S48a-MKL64 \
		> config/support/S48e-GENTOOLAPACK || die
	sed -i -e 's/-O2//' install_cgal || die
}

src_configure() {
	CGALDIR="${S}/usr"
	MYCONF="-ni
		--prefix=${CGALDIR}
		--cxx=$(tc-getCXX)
		--without-autofind
		--with-boost
		--with-boost_program_options
		--with-mpfr
		--with-gmp
		--with-gmpxx"

	use lapack && MYCONF="${MYCONF} --with-gentoolapack"
	use opengl && MYCONF="${MYCONF} --with-opengl"
	use taucs  && MYCONF="${MYCONF} --with-gentoolapack --with-taucslapack"
	use X      && MYCONF="${MYCONF} --with-x11"
	use zlib   && MYCONF="${MYCONF} --with-zlib"
	use qt3    && MYCONF="${MYCONF} --with-qt3mt --qt_incl_dir ${QTDIR}/include --qt_lib_dir ${QTDIR}/lib"
}

src_compile() {
	./install_cgal ${MYCONF} || die "compilation failed"
	grep -q failed compile.log && die "see ${S}/compile.log for problems"
}

src_test() {
	cd "${S}"/examples
	export CGAL_MAKEFILE="${CGALDIR}/share/cgal/cgal.mk"
	emake || die "emake examples failed"
	# basic testing, does not compare with original
	for t in */*.cpp; do
		local run_testt=${t%.cpp}
		if [[ -x ${run_test} ]]; then
			${run_test} || die "Running test from ${t} failed"
		fi
	done
}

src_install(){
	mv usr/lib usr/$(get_libdir)
	sed -i \
		-e "s:${CGALDIR}:/usr:g" \
		"${CGALDIR}/share/cgal/cgal.mk" || die "sed cgal.mk failed"
	cp -pPR usr "${D}" || die "install failed"

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demo examples || die "samples install failed"
	fi
	echo "CGAL_MAKEFILE=/usr/share/cgal/cgal.mk" > 99cgal
	doenvd 99cgal || die
}
