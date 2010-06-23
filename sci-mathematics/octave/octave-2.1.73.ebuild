# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/octave/octave-2.1.73.ebuild,v 1.13 2010/06/23 09:32:45 jlec Exp $

inherit flag-o-matic fortran

DESCRIPTION="GNU Octave is a high-level language (MatLab compatible) intended for numerical computations"
LICENSE="GPL-2"
HOMEPAGE="http://www.octave.org/"
SRC_URI="ftp://ftp.octave.org/pub/octave/bleeding-edge/${P}.tar.bz2
		ftp://ftp.math.uni-hamburg.de/pub/soft/math/octave/${P}.tar.bz2"

SLOT="0"
IUSE="emacs static readline zlib doc hdf5 mpi blas"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"

DEPEND=">=sys-libs/ncurses-5.2-r3
	>=sci-visualization/gnuplot-3.7.1-r3
	>=sci-libs/fftw-2.1.3
	>=dev-util/gperf-2.7.2
	zlib? ( sys-libs/zlib )
	hdf5? ( sci-libs/hdf5 )
	doc? ( virtual/latex-base )
	blas? ( virtual/blas )
	mpi? ( virtual/mpi )
	!=app-text/texi2html-1.70"
RDEPEND="${DEPEND}"
# NOTE: octave supports blas/lapack from intel but this is not open
# source nor is it free (as in beer OR speech) Check out...
# http://developer.intel.com/software/products/mkl/mkl52/index.htm for
# more information

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc4.1-gentoo.patch
}

src_compile() {
	filter-flags -ffast-math

	local myconf="--localstatedir=/var/state/octave --enable-rpath"
	myconf="${myconf} --enable-lite-kernel"
	use static || myconf="${myconf} --disable-static --enable-shared --enable-dl"
	# Only add -lz to LDFLAGS if we have zlib in USE !
	# BUG #52604
	# Danny van Dyk 2004/08/26
	use zlib && append-ldflags -lz

	# MPI requires the use of gcc/g++ wrappers
	# mpicc/mpic++
	# octave links agains -lmpi by default
	# mpich needs -lmpich instead
	if use mpi ; then
		CC="mpicc"
		if has_version 'sys-cluster/mpich' ; then
				CXX="mpiCC"
				myconf="${myconf} --with-mpi=mpich"
		elif has_version 'sys-cluster/mpich2' ; then
			if built_with_use sys-cluster/mpich2 cxx ; then
				elog "mpich2 must be built without C++ support!"
				die "please rebuild mpich2 with USE=-cxx..."
			fi
		    F77="mpif77"
		    myconf="${myconf} --with-mpi=mpich"
		else
		    myconf="${myconf} --with-mpi=mpi"
		fi
	else
	    CC="$(tc-getCC)"
	    CXX="$(tc-getCXX)"
	    myconf="${myconf} --without-mpi"
	fi

	CC="${CC}" CXX="${CXX}" F77="${F77}" \
	econf \
		$(use_with hdf5) \
		$(use_enable readline) \
		${myconf} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	# needed to avoid possible sandbox violations by latex
	export VARTEXFONTS="${T}/fonts"

	make install DESTDIR="${D}" || die "make install failed"
	if use doc; then
		octave-install-doc || die "Octave doc install failed"
	fi
	if use emacs; then
		cd emacs
		exeinto /usr/bin
		doexe otags || die
		doman otags.1 || die
		for emacsdir in /usr/share/emacs/site-lisp /usr/lib/xemacs/site-lisp; do
			insinto ${emacsdir}
			doins *.el || die
		done
		cd ..
	fi
	dodir /etc/env.d || die
	echo "LDPATH=/usr/lib/octave-${PV}" > "${D}"/etc/env.d/99octave || die

	# Fixes ls-R files to remove /var/tmp/portage references.
	sed -i -e "s:${D}::g" "${D}"/usr/libexec/${PN}/ls-R || die
	sed -i -e "s:${D}::g" "${D}"/usr/share/${PN}/ls-R || die
}

pkg_postinst() {
	echo
	einfo "Some users have reported failures at running simple tests if"
	einfo "octave was built with agressive optimisations. You can check if"
	einfo "your setup is affected by this bug by running the following test"
	einfo "(inside the octave interpreter):"
	einfo
	einfo "octave:1> y = [1 3 4 2 1 5 3 5 6 7 4 5 7 10 11 3];"
	einfo "octave:2> g = [1 1 1 1 1 1 1 1 2 2 2 2 2 3 3 3];"
	einfo "octave:3> anova(y, g)"
	einfo
	einfo "If these commands complete successfully with no error message,"
	einfo "your installation should be ok. Otherwise, try recompiling"
	einfo "octave using less agressive \"CFLAGS\" (combining \"-O3\" and"
	einfo "\"-march=pentium4\" is known to cause problems)."
	echo
}

octave-install-doc() {
	echo "Installing documentation..."
	insinto /usr/share/doc/${PF}
	doins doc/faq/Octave-FAQ.dvi || die
	doins doc/interpreter/octave.dvi || die
	doins doc/liboctave/liboctave.dvi || die
	doins doc/refcard/refcard-a4.dvi || die
	doins doc/refcard/refcard-legal.dvi || die
	doins doc/refcard/refcard-letter.dvi || die
}
