# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpich2/mpich2-1.0.3-r1.ebuild,v 1.13 2009/11/24 21:37:22 jsbronder Exp $

WANT_AUTOCONF="2.5"
inherit fortran distutils eutils autotools toolchain-funcs

DESCRIPTION="MPICH2 - A portable MPI implementation"
HOMEPAGE="http://www.mcs.anl.gov/research/projects/mpich2/index.php"
SRC_URI="ftp://ftp.mcs.anl.gov/pub/mpi/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
# need more arches in here, like sparc...
IUSE="crypt cxx doc debug fortran mpe mpe-sdk romio threads"

RDEPEND="${DEPEND}
	mpe-sdk? ( dev-java/ibm-jdk-bin )
	romio? ( >=dev-libs/libaio-0.3.106 )
	>=dev-lang/python-2.3
	sys-apps/coreutils
	dev-lang/perl
	crypt? ( net-misc/openssh )
	!crypt? ( net-misc/netkit-rsh )
	!sys-cluster/mpich
	!sys-cluster/lam-mpi
	!sys-cluster/openmpi
	!media-sound/mpd
	!media-sound/mpd-svn"
DEPEND="${RDEPEND}"

RESTRICT="test"

pkg_setup() {
	if [ -n "${MPICH_CONFIGURE_OPTS}" ]; then
		einfo "Custom configure options are ${MPICH_CONFIGURE_OPTS}."
	fi
	if use fortran ; then
		if [ $(gcc-major-version) -ge 4 ] \
		&& built_with_use sys-devel/gcc fortran ; then
			FORTRAN="gfortran"
			fortran_pkg_setup
		else
		ewarn "You need gcc-4 built with fortran support in order to"
		ewarn "build the f90 mpi interface, which is required for f90"
		ewarn "and mpi support in hdf5 (for example)."
		fi
	else
		einfo "Unless you have another f90 compiler installed, we can only"
		einfo "build the f77 and C++ interfaces with gcc-3.x"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	ebegin "Reconfiguring"
		find . -name configure -print | xargs rm
		./maint/updatefiles
		use mpe-sdk && ./src/mpe2/maint/updatefiles
	eend
	epatch "${FILESDIR}"/${P}-make.patch || die "make patch failed"
	# damn, have to patch the createshlib script here...
	epatch "${FILESDIR}"/${P}-soname.patch || die "soname patch failed"
	#epatch "${FILESDIR}"/${P}-make-test.patch || die "make test patch failed"
}

src_compile() {
	export LDFLAGS='-Wl,-z,now'

	local RSHCOMMAND

	if use crypt ; then
		RSHCOMMAND="ssh -x"
	else
		RSHCOMMAND="rsh"
	fi
	export RSHCOMMAND

	local myconf="${MPICH_CONFIGURE_OPTS}"

	if ! use debug ; then
		myconf="${myconf} --enable-fast --enable-g=none"
	else
		myconf="${myconf} --enable-g=dbg --enable-debuginfo \
		--enable-error-messages=all"
	fi

	if ! use mpe-sdk ; then
		myconf="${myconf} --enable-graphics=no --enable-rlog=no \
		--enable-clog=no --enable-slog2=no"
	fi

	use mpe && MPE_SRC_DIR="${S}"/src/mpe2

	if use threads ; then
		myconf="${myconf} --with-thread-package=pthreads"
	else
		myconf="${myconf} --with-thread-package=none"
	fi

		./configure \
		--prefix=/usr \
		--exec-prefix=/usr \
		--enable-sharedlibs=gcc \
		--enable-nmpi-as-mpi \
		--enable-error-checking=runtime \
		--enable-timing=runtime \
		${myconf} \
		$(use_enable cxx) \
		$(use_enable mpe) \
		$(use_enable romio) \
		$(use_enable threads) \
		--includedir=/usr/include \
		--libdir=/usr/$(get_libdir) \
		--mandir=/usr/share/man \
		--with-docdir=/usr/share/doc/${PF} \
		--with-htmldir=/usr/share/doc/${PF}/html \
		--sysconfdir=/etc/${PN} \
		--datadir=/usr/share/${PN} || die "configure failed"

	if use mpe-sdk ; then
		"${MPE_SRC_DIR}"/configure --prefix=/usr --enable-mpich \
		--with-mpicc=mpicc --with-mpif77=mpif77 --enable-wrappers \
		--enable-collchk --with-flib_path_leader="-Wl,-L"
	fi

	if use mpe ; then
		 epatch "${FILESDIR}"/${P}-mpe-install.patch || die "install patch failed"
	fi

	# parallel makes are currently broken, so no emake...
	#make dependencies
	make || die "make failed"

	if has test "${FEATURES}" ; then
		# get setup for src_test
		#export LDFLAGS='-L../../lib'
		export LD_LIBRARY_PATH="${S}"/lib:$LD_LIBRARY_PATH
		cd "${S}"/test/mpi
		#make clean || die "make clean failed"
		echo
		einfo "Using ./configure --prefix="${S}" --with-mpi="${S}" --disable-f90"
		echo
		./configure --prefix="${S}" --with-mpi="${S}" $(use_enable threads) \
			--exec-prefix="${S}" --includedir="${S}"/src/include --disable-f90 \
		|| die "configure test failed"
		make dependencies
		# make doesn't work here for some reason, although it works fine
		# when run manually.  Go figure...
		#cd ${S}/test/mpi/util
		#make all || die "make util failed"
		cd "${S}"/test
		install -g portage -o portage -m 0600 "${FILESDIR}"/mpd.conf "${HOME}"/.mpd.conf
		#${S}/bin/mpd --daemon
		make all || die "make pre-test failed"
		#cd ${S}/test/mpi
		#make || die "make test failed"
		#${S}/bin/mpdallexit
	fi
}

src_test() {
	ewarn "Tests can take a long time to complete, even on a fast box."
	ewarn "Expected result on amd64 with gcc 4.1.1:"
	ewarn "     6 tests failed out of 373"
	echo
	einfo "Control-C now if you want to disable tests..."
	epause

	"${S}"/bin/mpd --daemon
	cd "${S}"/test
	nice --adjustment=3 make testing || die "run tests failed"
	"${S}"/bin/mpdallexit
}

src_install() {
	dodir /etc/${PN}
	rm -rf src/mpe2/etc/*.in
	make install DESTDIR="${D}" \
		LIBDIR="${D}"usr/$(get_libdir) || die "make install failed"

	dodir /usr/share/${PN}
	mv "${D}"usr/examples/cpi" ${D}"usr/share/${PN}/cpi
	rm -rf "${D}"usr/examples
	rm -rf "${D}"usr/sbin

	dodir /usr/share/doc/${PF}
	if use doc; then
		dodoc README README.romio README.testing CHANGES
		dodoc README.developer RELEASE_NOTES
		newdoc src/pm/mpd/README README.mpd
	else
		rm -rf "${D}"usr/share/doc/
		rm -rf "${D}"usr/share/man/
		dodoc README CHANGES RELEASE_NOTES
	fi
}

pkg_postinst() {
	python_mod_optimize /usr/bin

	elog
	elog "Note: this package still needs testing with other Fortran90"
	elog "compilers besides gfortran (gcc4).  The tests also need some"
	elog "magic to build properly within the portage build environment."
	elog "(currently the tests only build and run manually)"
	elog
	elog "The gfortran support has been tested successfully with hdf5"
	elog "(using gfortran and the mpif90 wrapper)."
	elog
}

pkg_postrm() {
	python_mod_cleanup
}
