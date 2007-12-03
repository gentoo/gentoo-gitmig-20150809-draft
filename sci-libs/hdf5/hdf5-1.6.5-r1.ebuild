# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf5/hdf5-1.6.5-r1.ebuild,v 1.4 2007/12/03 07:21:53 nerdboy Exp $

inherit fortran eutils toolchain-funcs

DESCRIPTION="General purpose library and file format for storing scientific data"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/"
SRC_URI="ftp://ftp.ncsa.uiuc.edu/HDF/HDF5/current/src/${P}.tar.gz"

LICENSE="NCSA-HDF"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
# need to update szip to get alpha, ia64, etc back in here,
IUSE="cxx f90 fortran hlapi mpi ssl szip threads zlib static debug"

DEPEND="mpi? ( virtual/mpi )
	ssl? ( dev-libs/openssl )
	szip? ( sci-libs/szip )
	zlib? ( sys-libs/zlib )
	sys-devel/gcc
	sys-apps/coreutils
	sys-apps/which
	sys-process/time"

RDEPEND="${DEPEND}
	dev-lang/perl"

pkg_setup() {
	# The above gcc dep is a hack to insure at least one Fortran 90
	# compiler is installed if the user enables fortran support.  Feel
	# free to improve it...
	if use fortran ; then
	    if [ $(gcc-major-version) -ge 4 ] \
		&& built_with_use sys-devel/gcc fortran ; then
	    	    FORTRAN="gfortran"
		    fortran_pkg_setup
		    einfo "Configuring for GNU fortran..."
	    elif
		test -d /opt/intel/fortran90 ; then
		    FORTRAN="ifc"
		    fortran_pkg_setup
		    einfo "Configuring for Intel fortran..."
	    elif use f90 ; then
		einfo "Relying on H5Detect to configure Fortran compiler..."
		FORTRAN=""
	    else
		einfo "No F90 compiler found; please install either gcc 4 with"
		einfo "fortran support or some other Fortran 90 compiler such"
		einfo "as ifc or pgf90 (or disable fortran support)."
		die "No usable Fortran 90 compiler found."
	    fi
	fi
}

src_compile() {
	local myconf="--with-pic"

	# --disable-static conflicts with --enable-cxx, so we have to do either
	# or here.  --enable-cxx also conflicts with parallel (mpi) support.
	# fortran needs f90 support and requires static and mpi (for gfortran).
	if use static ; then
	    if use cxx && ! use mpi ; then
		myconf="${myconf} --enable-cxx"
	    elif use cxx && use mpi ; then
		ewarn "C++ support is not compatible with the mpi interface."
		die "Please disable either cxx or mpi."
	    else
		myconf="${myconf} --disable-cxx"
	    fi
	    if use fortran && use mpi ; then
		ewarn "Requires Fortran 90 support in your mpi library..."
		myconf="${myconf} --enable-fortran --enable-static"
	    elif use fortran && use f90 ; then
		ewarn "Relying on configure to detect Fortran 90 compiler..."
		myconf="${myconf} --enable-fortran --enable-static"
	    elif
		use fortran && ! use mpi && ! use f90 ; then
		ewarn "Configure fortran will probably fail without mpi, if all"
		ewarn "you have is gfortran installed.  Please enable mpi or"
		ewarn "install another Fortran compiler.  Fortran support is"
		ewarn "not enabled for this build..."
		myconf="${myconf} --disable-fortran --enable-static"
	    else
		myconf="${myconf} --disable-fortran --enable-static"
	    fi
	else
	    einfo "C++ support cannot be enabled without both enabling static"
	    einfo "library support and disabling mpi.  Fortran9X support needs"
	    einfo "both static and mpi enabled to work with GNU fortran."
	    echo
	    einfo "Suggested USE flags for fortran and mpi using gfortran:"
	    einfo "USE=\"fortran mpi static -cxx\""
	    echo
	    if use fortran || use cxx ; then
		die "Please adjust your use flags."
	    else
		einfo "Disabling fortran, C++, and static library support..."
		myconf="${myconf} --disable-static --disable-fortran \
		    --disable-cxx"
	    fi
	fi
	use threads && myconf="${myconf} --with-pthread"
	use debug && myconf="${myconf} --enable-debug=all"
	use mpi && myconf="${myconf} --enable-parallel --enable-gpfs"
	use hlapi || myconf="${myconf} --disable-hl"

	# NOTE: the hdf5 configure script has its own interpretation of
	# the ARCH environment variable which conflicts with that of
	# ebuild/emerge. As a work around, we save the ARCH variable as
	# EBUILD_ARCH and restore it when we are done.
	EBUILD_ARCH=${ARCH}
	unset ARCH

	if use mpi ; then
	    export CC="/usr/bin/mpicc"
	fi
	./configure --prefix=/usr ${myconf} \
		$(use_enable zlib) \
		$(use_with ssl) \
		--enable-linux-lfs  \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--libdir=/usr/$(get_libdir) \
		--mandir=/usr/share/man || die "configure failed"

	# restore the ARCH environment variable
	ARCH=${EBUILD_ARCH}

	# emake has occasional segfaults
	make || die "make failed"
}

src_test() {
	# make test is not reliable, and the mpi tests have a weird failure
	export HDF5_Make_Ignore=yes
	install -g portage -o portage -m 0600 ${FILESDIR}/mpd.conf ${HOME}/.mpd.conf
	/usr/bin/mpd --daemon
	make check || die "make test failed"
	/usr/bin/mpdallexit
	export HDF5_Make_Ignore=no
}

src_install() {
	make \
		prefix=${D}usr \
		mandir=${D}usr/share/man \
		docdir=${D}usr/share/doc/${PF} \
		libdir=${D}usr/$(get_libdir) \
		infodir=${D}usr/share/info \
		install || die "make install failed"

	dolib.so ${S}/test/.libs/lib*so* || die "dolib.so failed"

	if use static ; then
	    dolib.a ${S}/tools/lib/.libs/libh5tools.a \
		${S}/test/.libs/libh5test.a || die "dolib.a failed"
	    insinto /usr/$(get_libdir)
	    doins ${S}/tools/lib/libh5tools.la \
		 ${S}/test/libh5test.la || die "doins failed"
	fi

	dobin ${S}/bin/iostats || die "dobin failed"
	dodoc README.txt MANIFEST
	dohtml doc/html/*

	if use mpi ; then
	    mv ${D}usr/bin/h5pcc ${D}usr/bin/h5cc
	fi
	if use fortran ; then
	    mv ${D}usr/bin/h5pfc ${D}usr/bin/h5fc
	fi
	# change the SHLIB default for C
	if ! use static ; then
	    dosed "s/SHLIB:-no/SHLIB:-yes/g" ${D}usr/bin/h5cc || die "dosed failed"
	fi
}

pkg_postinst() {
	echo
	einfo "Use the fortran flag for gfortran or ifc, and add the f90"
	einfo "flag to override the fortran flag if you have a different"
	einfo "f90 compiler installed (gfortran requires gcc 4.x). Note that"
	einfo "gfortran only works as mpif90 and is not detected properly by"
	einfo "configure without the mpi wrapper."
	echo
	einfo "There are currently 2 non-fatal test errors in the mpi tests,"
	einfo "however, all C++, Fortran, and other tests pass successfully."
	einfo "The only expected failure is currently in the PHDF5 section"
	einfo "under MPI functionality tests. The second section using the"
	einfo "MPIPOSIX driver should work, along with all other tests."
	echo
	einfo "Suggested USE flags for fortran and mpi support using gfortran:"
	einfo "USE=\"fortran mpi static -cxx\""
	echo
	ewarn "Note: currently untested on a virtual (parallel) filesystem."
	echo
}
