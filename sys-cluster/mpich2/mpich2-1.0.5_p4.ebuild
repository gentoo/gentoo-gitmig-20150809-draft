# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpich2/mpich2-1.0.5_p4.ebuild,v 1.1 2007/07/09 01:58:30 nerdboy Exp $

inherit eutils fortran distutils autotools kde-functions toolchain-funcs java-pkg

DESCRIPTION="MPICH2 - A portable MPI implementation"
HOMEPAGE="http://www-unix.mcs.anl.gov/mpi/mpich2"
MY_P=${P/_/}
SRC_URI="ftp://ftp.mcs.anl.gov/pub/mpi/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt cxx debug doc fast fortran mpe mpe-sdk romio threads"

DEPEND="virtual/libc
	sys-devel/libtool
	dev-lang/perl
	>=dev-lang/python-2.3
	mpe-sdk? ( >=virtual/jdk-1.5
		x11-proto/xproto )
	romio? ( >=dev-libs/libaio-0.3.106
		net-fs/nfs-utils )
	doc? ( virtual/tetex )"

RDEPEND="${DEPEND}
	mpe-sdk? ( x11-libs/libX11 )
	crypt? ( net-misc/openssh )
	!crypt? ( net-misc/netkit-rsh )
	!sys-cluster/mpich
	!sys-cluster/lam-mpi
	!sys-cluster/openmpi
	!media-sound/mpd
	!media-sound/mpd-svn"

RESTRICT="-test"

# To-do: work on tests and add SCTP support for kernel and user tools

pkg_setup() {
	if [ -n "${MPICH_CONFIGURE_OPTS}" ]; then
	    elog "User-specified configure options are ${MPICH_CONFIGURE_OPTS}."
	else
	    elog "User-specified configure options are not set."
	    elog "If needed, see the docs and set MPICH_CONFIGURE_OPTS."
	fi

	if use fortran ; then
	    if [ $(gcc-major-version) -ge 4 ] \
		&& built_with_use sys-devel/gcc fortran ; then
		    FORTRAN="gfortran"
		    # we should conform to the Fortran standard, ie, integers
		    # and reals must be the same size
		    export F90FLAGS="-i4  ${F90FLAGS}"
		    fortran_pkg_setup
	    else
		ewarn "You need gcc-4 built with fortran support in order to"
		ewarn "build the f90 mpi interface, which is required for f90"
		ewarn "and mpi support in hdf5 (for example)."
	    fi
	else
	    ewarn "Unless you have another f90 compiler installed, we can only"
	    ewarn "build the f77 and C++ interfaces with gcc-3.x"
	fi
}

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/${MY_P} ${S}
	cd ${S}

	ebegin "Reconfiguring"
	    find . -name configure -print | xargs rm
	    ./maint/updatefiles
	    use mpe-sdk && ./src/mpe2/maint/updatefiles
	eend

	epatch ${FILESDIR}/${P}-make.patch || die "make patch failed"
	epatch ${FILESDIR}/${P}-soname.patch || die "soname patch failed"

	sed -i -e "s:@LDFLAGS@:@LDFLAGS@ -Wl,-z,now:g" src/pm/mpd/Makefile.in \
	    || die "sed failed"
}

src_compile() {
	local RSHCOMMAND
	if use crypt ; then
	    RSHCOMMAND="ssh -x"
	else
	    RSHCOMMAND="rsh"
	fi
	export RSHCOMMAND

	local myconf="${MPICH_CONFIGURE_OPTS}"

	if ! use debug ; then
	    myconf="${myconf} --enable-g=none"
	else
	    myconf="${myconf} --enable-g=dbg --enable-debuginfo"
	fi

	if ! use mpe-sdk ; then
	    myconf="${myconf} --enable-rlog=no --enable-slog2=no"
	fi

	if use threads ; then
	    myconf="${myconf} --with-thread-package=pthreads"
	else
	    myconf="${myconf} --with-thread-package=none"
	fi

	# enable f90 support for appropriate compilers
	case ${FORTRANC} in
	    gfortran|ifc|ifort|f95)
		myconf="${myconf} --enable-f90"
	esac

	use romio && myconf="${myconf} --with-file-system=nfs"

	use mpe && MPE_SRC_DIR=${S}/src/mpe2

	if use doc; then
	    doc_conf="--docdir=/usr/share/doc/${PF} \
		--with-docdir=/usr/share/doc/${PF} \
		--with-htmldir=/usr/share/doc/${PF}/html \
		--with-pdfdir=/usr/share/doc/${PF} \
		--with-psdir=/usr/share/doc/${PF}"
	else
	    doc_conf="--with-docdir=/usr/share/doc/${PF} \
		--with-htmldir=/usr/share/doc/${PF}/html"
	fi

	./configure --enable-sharedlibs=gcc \
		${myconf} \
		${doc_conf} \
		$(use_enable fast) \
		$(use_enable cxx) \
		$(use_enable mpe) \
		$(use_enable romio) \
		$(use_enable threads) \
		--libdir=/usr/$(get_libdir) \
		--includedir=/usr/include \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/${PN} \
		--prefix=/usr --exec-prefix=/usr \
		--datadir=/usr/share/${PN} || die "configure failed"

	if use mpe-sdk; then
	    cd ${S}/src/mpe2
	    ./configure --prefix=/usr --libdir=/usr/$(get_libdir)/mpe \
		--with-mpicc=${S}/bin/mpicc --with-mpif77=${S}/bin/mpif77 \
		--enable-collchk --enable-graphics=yes --enable-wrappers \
		--with-java=${JAVA_HOME} --datadir=/usr/share/${PN} \
		--with-flib_path_leader="-Wl,-L" --enable-mpich ${doc_conf} \
		--with-trace-libdir=/usr/$(get_libdir)/mpe/trace_rlog \
		|| die "MPE configure failed"
	    cd ${S}
	fi

	# no parallel make here
	make FFLAGS="-fPIC" || die "make failed"
}

src_install() {
	dodir /etc/${PN}

	rm -rf src/mpe2/etc/*.in

	make DESTDIR=${D} LIBDIR=${D}usr/$(get_libdir) install \
	    || die "make install failed"

	dodir /usr/share/doc/${PF}
	if use doc; then
	    dodoc COPYRIGHT README README.romio README.testing CHANGES
	    dodoc README.developer RELEASE_NOTES
	    newdoc src/pm/mpd/README README.mpd

	    if use mpe-sdk; then
		dodoc src/mpe2/src/slog2sdk/README.sdk \
		    src/mpe2/src/slog2sdk/README.rte
		newdoc src/mpe2/src/slog2sdk/FAQ FAQ.sdk
	    fi
	else
	    rm -rf ${D}usr/share/doc/${PF}/html
	    dodoc README CHANGES COPYRIGHT RELEASE_NOTES
	fi

	# Tidy up a bit and create the missing links
	rm ${D}usr/sbin/mpeuninstall
	cd ${D}usr/$(get_libdir)
	dosym libmpich.so.0.0 /usr/$(get_libdir)/libmpich.so
	dosym libfmpich.so.0.0 /usr/$(get_libdir)/libfmpich.so
}

pkg_postinst() {
	python_version
	python_mod_optimize ${ROOT}usr/bin

	elog ""
	elog "Note 1: enabling the MPE2 SDK requires both a JDK and the core"
	elog "X11 library for the full set of log analysis and conversion"
	elog "utilities.  You probably don't want to enable the mpe-sdk USE"
	elog "flag on a server, cluster node, etc."
	elog ""
	elog "Note 2: this package still needs testing with other Fortran90"
	elog "compilers besides gfortran (gcc4).  The tests also need some"
	elog "magic to build properly within the portage build environment."
	elog "(currently the tests only build and run manually)"
	elog ""
	elog "The gfortran support has been tested successfully with hdf5"
	elog "(using gfortran and the mpif90 wrapper)."
	elog ""
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
