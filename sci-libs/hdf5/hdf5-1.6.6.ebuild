# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/hdf5/hdf5-1.6.6.ebuild,v 1.5 2008/04/09 01:34:59 jer Exp $

inherit eutils fixheadtails flag-o-matic fortran toolchain-funcs

DESCRIPTION="General purpose library and file format for storing scientific data"
HOMEPAGE="http://hdf.ncsa.uiuc.edu/HDF5/"
SRC_URI="ftp://ftp.hdfgroup.org/HDF5/current/src/${P}.tar.gz"

LICENSE="NCSA-HDF"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
# need to update szip to get alpha, ia64, etc back in here,
IUSE="cxx debug fortran mpi ssl szip threads tools zlib "

DEPEND="mpi? ( >=sys-cluster/mpich2-1.0.6
		net-fs/nfs-utils )
	ssl? ( dev-libs/openssl )
	szip? ( sci-libs/szip )
	zlib? ( sys-libs/zlib )
	threads? ( virtual/libc )
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
	    fortran_pkg_setup
	    case "${FORTRANC}" in
		gfortran|ifc|ifort|f95)
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

	if use mpi; then
	    # this is required for mpich2, and should be safe otherwise
	    epatch "${FILESDIR}/${PN}-mpich2.patch" || die "mpich2 patch failed"
	fi

	ht_fix_file "${S}"/bin/release "${S}"/tools/h5dump/testh5dump.sh.in

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
	    ewarn "Requires Fortran 90 support in your mpi library..."
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
	    export NPROCS=1
	    export CC="mpicc"
	    if built_with_use sys-cluster/mpich2 fortran ; then
		export F9X="mpif90"
	    fi
	    if built_with_use sys-cluster/mpich2 pvfs2 ; then
		export LIBS="$(sh pvfs2-config --libs) -lmpich"
	    else
		export LIBS="-lmpich"
	    fi
#	    if built_with_use sys-cluster/mpich2 mpe ; then
#		myconf="${myconf} --with-mpe=/usr/include,/usr/$(get_libdir)"
#	    fi
	    append-ldflags "${LIBS}"
	fi

	econf --prefix=/usr \
		$(use_enable zlib) \
		$(use_with ssl) \
		--enable-linux-lfs  \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--libdir=/usr/$(get_libdir) \
		--mandir=/usr/share/man \
		--enable-shared --with-pic \
		"${myconf}" || die "configure failed"

	# restore the ARCH environment variable
	ARCH="${EBUILD_ARCH}"

	# emake has occasional segfaults
	make || die "make failed"
}

src_test() {
	# make test is not reliable, and the mpi tests have a weird failure
	export HDF5_Make_Ignore=yes
	if use mpi ; then
	    export HDF5_PARAPREFIX="${S}/testpar"
	    export CC="/usr/bin/mpicc"
	    install -g portage -o portage -m 0600 "${FILESDIR}"/mpd.conf "${HOME}"/.mpd.conf
	    /usr/bin/mpd --daemon
	fi
	make check || die "make test failed"
	use mpi && /usr/bin/mpdallexit
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
		|| die "dolib.so failed"
	    doins "${S}"/test/.libs/libh5test.so.0 \
		"${S}"/test/.libs/libh5test.so || die "doins failed"

	    exeinto /usr/bin
	    newexe "${S}"/bin/iostats iostats.pl || die "newexe failed"

	    exeinto /usr/share/"${PN}/test-tools"
	    cd "${S}"/test
	    doexe big bittests fillval lheap file_handle istore set_extent \
		srb_append cache flush1 srb_read cmpd_dset flush2 srb_write \
		dangle gass_append links stab dsets dtypes enum extend external \
		gass_read mount gass_write getname gheap hyperslab mtime ntypes \
		ohdr reserved stream_test testhdf5 ttsafe unlink
	    cd "${S}"
	    use mpi && doexe testpar/testphdf5 testpar/t_mpi
	fi

	dodoc README.txt MANIFEST
	dohtml doc/html/*

	if use mpi ; then
	    mv "${D}"usr/bin/h5pcc "${D}"usr/bin/h5cc
	fi
	if use fortran ; then
	    mv "${D}"usr/bin/h5pfc "${D}"usr/bin/h5fc
	fi
	# change the SHLIB default for C
	dosed "s/SHLIB:-no/SHLIB:-yes/g" "${D}"usr/bin/h5cc || die "dosed failed"
}

pkg_postinst() {
	elog
	elog "There are currently 2 non-fatal test errors in the mpi tests,"
	elog "however, all C++, Fortran, and other tests pass successfully."
	elog "The only expected failure is currently in the PHDF5 section"
	elog "under MPI functionality tests. The second section using the"
	elog "MPIPOSIX driver should work, along with all other tests."
	elog
	elog "Suggested USE flags for fortran and mpi support using gfortran:"
	elog "USE=\"fortran mpi -cxx\""
	elog
	ewarn "Note 1: currently testing pvfs2 support (with mpi).  Please"
	ewarn "report any problems in the usual way."
	elog
	ewarn "Note 2: you'll need rawio support enabled in your kernel or"
	ewarn "certain asynchronous IO operations will fail.  Either enable"
	ewarn "the RAW driver (under Character Devices) or patch your kernel"
	ewarn "with the new PAIO drivers and use libposix-aio.  See both:"
	ewarn "http://sourceforge.net/projects/paiol  and"
	ewarn "http://www.bullopensource.org/posix  for more info."
	elog
}
