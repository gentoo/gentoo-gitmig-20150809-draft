# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf5/hdf5-1.6.7.ebuild,v 1.2 2009/01/23 06:37:52 nerdboy Exp $

inherit eutils fixheadtails flag-o-matic fortran toolchain-funcs

DESCRIPTION="General purpose library and file format for storing scientific data"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/"
SRC_URI="ftp://ftp.hdfgroup.org/HDF5/current/src/${P}.tar.gz"

LICENSE="NCSA-HDF"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~sparc"
# need to update szip to get alpha, ia64, etc back in here,
IUSE="cxx debug fortran mpi ssl szip threads tools zlib "

DEPEND="mpi? ( >=sys-cluster/mpich2-1.0.6
		net-fs/nfs-utils )
	ssl? ( dev-libs/openssl )
	szip? ( sci-libs/szip )
	zlib? ( sys-libs/zlib )
	threads? ( virtual/libc )
	sys-apps/coreutils
	sys-process/time"

RDEPEND="${DEPEND}
	dev-lang/perl"

pkg_setup() {
	if has test ${FEATURES} && use mpi ; then
	    elog ""
	    elog "Parallel tests will launch 3 mpd processes on this box,"
	    elog "so it may take some time on a slow machine (only a few"
	    elog "minutes on a reasonably fast machine).  Hit Ctl-C now"
	    elog "and emerge with FEATURES=-test if you'd rather not..."
	    elog ""
	    epause 9
	fi

	# The above gcc dep is a hack to insure at least one Fortran 90
	# compiler is installed if the user enables fortran support.  Feel
	# free to improve it...
	if use fortran ; then
	    fortran_pkg_setup
	    case "${FORTRANC}" in
		gfortran|ifc|ifort|f95|pgf90)
		    export F9X="${FORTRANC}"
		    ;;
		g77|f77|f2c)
		    export F9X=""
		    ;;
	    esac
	fi

	# if anyone knows of a better way to do this...
	if use mpi && ! built_with_use sys-cluster/mpich2 pvfs2 ; then
	    ewarn "Your MPI library needs parallel IO support for HDF5. You"
	    ewarn "must re-emerge mpich2 with USE=pvfs2."
	    die "requires parallel IO support"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.6.6-gcc4.3.patch
	if use mpi; then
	    # this is required for mpich2, and should be safe otherwise
	    epatch "${FILESDIR}/${PN}-mpich2.patch"
	fi

	# fix test script stuff
	ht_fix_file "${S}"/bin/release "${S}"/tools/h5dump/testh5dump.sh.in
	sed -i -e "s:+4l:+4:g" tools/h5dump/testh5dump.sh.in || die "oops"

	# fix sort key
	sed -i -e "s:sort +2:sort -k 2:g" bin/ltmain.sh || die "sed failed"

	# change the SHLIB default for C
	sed -i -e "s/SHLIB:-no/SHLIB:-yes/g" tools/misc/h5cc.in || die "sed h5cc failed"
}

src_compile() {
	local myconf

	# a better way to do this would also be nice, but i can't think of one
	if use cxx && ! use mpi ; then
	    myconf="${myconf} --enable-cxx"
	elif use cxx && use mpi ; then
	    ewarn "C++ support is not compatible with the mpi interface."
	    die "Please disable either cxx or mpi."
	else
	    myconf="${myconf} --disable-cxx"
	fi

	if use fortran && use mpi ; then
	    ewarn "Parallel HDF5 requires Fortran 90 support in your mpi library..."
	    myconf="${myconf} --enable-fortran --enable-parallel"
	fi

	use threads && myconf="${myconf} --with-pthread --enable-threadsafe"

	if use debug ; then
	    myconf="${myconf} --enable-debug=all"
	else
	    myconf="${myconf} --enable-production"
	fi

	# NOTE: the hdf5 configure script has its own interpretation of
	# the ARCH environment variable which conflicts with that of
	# ebuild/emerge. As a work around, we save the ARCH variable as
	# EBUILD_ARCH and restore it when we are done.
	EBUILD_ARCH="${ARCH}"

	unset ARCH

	if use mpi ; then
	    EBUILD_CC="${CC}"
	    # set NPROCS explicitly if needed
	    export NPROCS=${NPROCS:=2}
	    export CC="$(type -p mpicc)"
	    if [[ ${FORTRANC} == gfortran ]] ; then
		export F9X="$(type -p mpif90)"
	    fi
	    if built_with_use sys-cluster/mpich2 pvfs2 ; then
		export LIBS="${LIBS} $(sh pvfs2-config --libs) -lmpich"
	    else
		export LIBS="${LIBS} -lmpich"
	    fi
	    append-ldflags "${LIBS}"
	fi

	econf --prefix=/usr \
		$(use_enable zlib) \
		$(use_enable fortran) \
		$(use_enable mpi parallel) \
		$(use_with ssl) \
		--enable-linux-lfs  \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--libdir=/usr/$(get_libdir) \
		--mandir=/usr/share/man \
		--enable-shared --with-pic \
		${myconf} || die "configure failed"

	# restore the ARCH environment variable
	ARCH="${EBUILD_ARCH}"

	# emake has occasional segfaults
	make || die "make failed"
	use mpi && CC="${EBUILD_CC}"
}

src_test() {
	# all tests pass; a few are skipped, and MPI skips parts if it sees
	# only one process on the build host.
	export HDF5_Make_Ignore=yes
	if use mpi ; then
	    EBUILD_CC="${CC}"
	    export HDF5_PARAPREFIX="${S}/testpar"
	    export CC="$(type -p mpicc)"
	    export MPI_UNIVERSE="localhost 4"
	    export NPROCS=3
	    install -g portage -o portage -m 0600 "${FILESDIR}"/mpd.conf "${HOME}"/.mpd.conf
	    mpd --daemon --listenport=4268
	    mpd --daemon -h localhost -p 4268 -n
	    mpd --daemon -h localhost -p 4268 -n
	    elog "NPROCS = ${NPROCS}"
	    elog "mpdtrace output:"
	    mpdtrace
	fi
	make check || die "make test failed"
	use mpi && mpdallexit
	use mpi && CC="${EBUILD_CC}"
	export HDF5_Make_Ignore=no
}

src_install() {
	# emake install and einstall cause sandbox violations here
	make \
		prefix="${D}"usr \
		mandir="${D}"usr/share/man \
		docdir="${D}"usr/share/doc/"${PF}" \
		libdir="${D}"usr/$(get_libdir) \
		infodir="${D}usr"/share/info \
		install || die "make install failed"

	if use tools ; then
	    dolib.a "${S}"/tools/lib/.libs/libh5tools.a \
		"${S}"/test/.libs/libh5test.a || die "dolib.a failed"
	    insinto /usr/$(get_libdir)
	    doins "${S}"/tools/lib/libh5tools.la \
		"${S}"/test/libh5test.la || die "doins failed"
	    dolib.so "${S}"/test/.libs/libh5test.so.0.0.0 \
			"${S}"/test/.libs/libh5test.so.0 \
			"${S}"/test/.libs/libh5test.so \
		|| die "dolib.so failed"

	    exeinto /usr/bin
	    newexe "${S}"/bin/iostats iostats.pl || die "newexe failed"

	    exeinto /usr/share/"${PN}/test-tools"
	    cd "${S}"/test
	    doexe big bittests fillval lheap file_handle istore set_extent \
		srb_append cache flush1 srb_read cmpd_dset flush2 srb_write \
		dangle gass_append links stab dsets dtypes enum extend external \
		gass_read mount gass_write getname gheap hyperslab mtime ntypes \
		ohdr reserved testhdf5 ttsafe unlink
	    cd "${S}"
	    use mpi && doexe testpar/testphdf5 testpar/t_mpi
	fi

	dodoc README.txt
	dohtml doc/html/*

	if use mpi ; then
	    mv "${D}"usr/bin/h5pcc "${D}"usr/bin/h5cc
	fi
	if use fortran ; then
	    mv "${D}"usr/bin/h5pfc "${D}"usr/bin/h5fc
	fi
}

pkg_postinst() {
	echo
	elog "Use the fortran flag for gfortran or ifc, and add the f90"
	elog "flag to override the fortran flag if you have a different"
	elog "f90 compiler installed (gfortran requires gcc 4.x). Note that"
	elog "gfortran only works as mpif90 and is not detected properly by"
	elog "configure without the mpi wrapper."
	echo
	elog "There should not be any more test errors in the mpi tests,"
	elog "and all C++, Fortran, and other tests pass successfully."
	elog "Suggested USE flags for fortran and mpi support using"
	elog "gfortran:  USE=\"fortran mpi -cxx\""
	echo
	ewarn "Note 1: Needs more SMP and cluster testing, as well as"
	ewarn "more testing on a virtual (parallel) filesystem."
	echo
	ewarn "Note 2: currently testing pvfs2 support (with mpi).  Please"
	ewarn "report any problems in the usual way."
	elog
	ewarn "Note 3: you'll need rawio support enabled in your kernel or"
	ewarn "certain asynchronous IO operations may fail.  Either enable"
	ewarn "the RAW driver (under Character Devices) or patch your kernel"
	ewarn "with the new PAIO drivers and use libposix-aio.  See both:"
	ewarn "http://sourceforge.net/projects/paiol  and"
	ewarn "http://www.bullopensource.org/posix  for more info."
	elog
}
