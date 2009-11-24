# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/mpich2/mpich2-1.0.6.ebuild,v 1.9 2009/11/24 21:37:22 jsbronder Exp $

WANT_AUTOCONF="2.5"
inherit autotools distutils eutils flag-o-matic fortran java-pkg-2

#MY_P=${P/_/}
MY_P=${P}p1
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MPICH2 - A portable MPI implementation"
HOMEPAGE="http://www.mcs.anl.gov/research/projects/mpich2/index.php"
SRC_URI="http://www.mcs.anl.gov/research/projects/mpich2/downloads/${MY_P}.tar.gz"
#SRC_URI="ftp://ftp.mcs.anl.gov/pub/mpi/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="crypt cxx debug doc fast fortran mpe mpe-sdk pvfs2 threads"

DEPEND="sys-devel/libtool
	dev-lang/perl
	>=dev-lang/python-2.3
	>=dev-libs/libaio-0.3.106
	net-fs/nfs-utils
	pvfs2? ( >=sys-cluster/pvfs2-2.7.0 )
	mpe-sdk? ( >=virtual/jdk-1.5
		x11-proto/xproto )
	doc? ( virtual/latex-base )"

RDEPEND="${DEPEND}
	mpe-sdk? ( x11-libs/libX11 )
	crypt? ( net-misc/openssh )
	!crypt? ( net-misc/netkit-rsh )
	!sys-cluster/mpich
	!sys-cluster/lam-mpi
	!sys-cluster/openmpi
	!media-sound/mpd
	!media-sound/mpd-svn"

T_M4DIR="${S}/confdb"

RESTRICT="test"
# To-do: work on tests and add SCTP support for kernel and user tools
# Initial test implementation doesn't work yet - feel free to fix it...

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
			MPI_FFLAGS="-ff2c"
			fortran_pkg_setup
		else
		ewarn "You need gcc-4 built with fortran support in order to"
		ewarn "build the f90 mpi interface, which is required for f90"
		ewarn "and mpi support in hdf5 (for example)."
		FORTRAN="g77 f2c"
		fortran_pkg_setup
		fi
	else
		ewarn "Unless you have another f90 compiler installed, we can only"
		ewarn "build the C and C++ interfaces with gcc-3.x"
	fi

	if use mpe-sdk; then
		java-pkg-2_pkg_setup
		if use x86; then
		jvmarch=i386
		else
		jvmarch="${ARCH}"
		fi
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

	# a few fixes for building the shared libs, PIC, etc
	epatch "${FILESDIR}/${P}-cxx.patch" || die "cxx patch failed"
	epatch "${FILESDIR}/${P}-fPIC.patch" || die "fPIC patch failed"
	epatch "${FILESDIR}/${P}-shlib.patch" || die "createshlib patch failed"
	epatch "${FILESDIR}/${P}-makefile.patch" || die "make patch failed"

	if use pvfs2; then
		sed -i -e "s:-laio:-laio -lpvfs2:g" Makefile.in \
		|| die "sed pvfs2 failed"
	else
		epatch "${FILESDIR}/${P}-no-pvfs2.patch" || die "no pvfs patch failed"
		elog ""
		ewarn "If you wish to build without pvfs2 support, then you will"
		ewarn "need to remove the pvfs2 package if already installed."
		ewarn "Please remove pvfs2 and then rebuild mpich2.  If pvfs2"
		ewarn "is not installed, then you can safely ignore this warning."
		elog ""
		epause 5
	fi

	use mpe-sdk && setup-jvm-opts
}

src_compile() {
	if use crypt ; then
		RSHCOMMAND="ssh -x"
	else
		RSHCOMMAND="rsh"
	fi
	export RSHCOMMAND

	local myconf="${MPICH_CONFIGURE_OPTS} --enable-sharedlibs=gcc"
	local doc_conf=""
	local mpe_conf=""

	# update to using flag-o-matic
	append-ldflags -Wl,-z,now
	replace-flags -fpic -fPIC
	filter-flags -fomit-frame-pointer

	if ! use debug ; then
		myconf="${myconf} --enable-g=none"
	else
		myconf="${myconf} --enable-g=dbg,mem,log --enable-debuginfo"
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
	case "${FORTRANC}" in
		gfortran|ifc|ifort|f95)
		myconf="${myconf} --enable-f77 --enable-f90"
		;;
		g77|f77|f2c)
		myconf="${myconf} --enable-f77 --disable-f90"
		;;
	esac

	# top-level configure option is romio
	myconf="${myconf} --enable-romio"

	# several of these are romio-specific configure options
	myconf="${myconf} --enable-aio --with-mpi=mpich2_mpi"
	if use pvfs2; then
		myconf="${myconf} --with-file-system=pvfs2+nfs+ufs \
		--with-pvfs2=/usr"
	else
		# support for nfs and unix-like filesystems is the minimum
		myconf="${myconf} --with-file-system=nfs+ufs --with-pvfs2=no"
	fi
	# enable debug for romio
	use debug && myconf="${myconf} --enable-debug"

	use mpe && MPE_SRC_DIR="${S}"/src/mpe2

	# I'm sure there's a better way to do this...
	if use cxx; then
		tc-export CPP CC CXX LD
		CXXLIBPATH="/usr/$(get_libdir)/gcc/${CHOST}/$(gcc-fullversion)"
		sed -i -e "s:nerdboy:${CXXLIBPATH}:g" Makefile.in \
		|| die "sed 3 failed"
	fi

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

	if use mpe-sdk; then
		mpe_conf="--with-java=${JDK_TOPDIR} --with-java2=${JDK_TOPDIR} \
		--enable-slog2=build \
		--with-mpicc=\"${WORKDIR}\"/build/bin/mpicc \
		--with-mpif77=\"${WORKDIR}\"/build/bin/mpif77 \
		--enable-collchk --enable-graphics=yes --enable-wrappers \
		--with-trace-libdir=/usr/$(get_libdir)/mpe/trace_rlog \
		--with-flib_path_leader=-Wl,-L --enable-mpich \
		--enable-misc --enable-callstack --enable-logging"

		use debug && mpe_conf="${mpe_conf} --enable-g"

		sed -i -e "s:fpic:fPIC:g" \
		src/mpe2/src/slog2sdk/trace_sample/configure \
		|| die "sed 1 failed"
		sed -i -e "s:fpic:fPIC:g" \
		src/mpe2/src/slog2sdk/trace_rlog/configure \
		|| die "sed 2 failed"
	fi

	# trying the vpath build
	mkdir ../build
	cd ../build

	"${S}"/configure \
		--with-pm=mpd,gforker \
		--prefix=/usr \
		--exec-prefix=/usr \
		${myconf} \
		${mpe_conf} \
		${doc_conf} \
		$(use_enable fast) \
		$(use_enable cxx) \
		$(use_enable mpe) \
		$(use_enable threads) \
		--libdir=/usr/$(get_libdir) \
		--includedir=/usr/include \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/"${PN}" \
		--datadir=/usr/share/"${PN}" || die "configure failed"

	# no parallel make here
	use fortran && export FFLAGS="-fPIC"
	make dependencies || die "failed to make dependencies"
	make || die "make failed"
}

src_test() {
	ewarn "Tests can take a long time to complete, even on a fast box."
	ewarn "Expected result on amd64 with gcc 4.1.1:"
	ewarn "     6 tests failed out of 373"
	elog ""
	elog "Control-C now if you want to disable tests..."
	epause

	install -g portage -o portage -m 0600 "${FILESDIR}"/mpd.conf "${HOME}"/.mpd.conf
	TEST="${WORKDIR}/build"

	"${TEST}"/bin/mpd --daemon

	cd "${TEST}"
	mkdir t1
	export MPIO_USER_PATH="${TEST}"/t1

	sed -i -e "s:/usr/bin/mpiexec:${TEST}/bin/mpiexec:g" test/mpi/Makefile \
		|| die "sed 4 failed"
	sed -i -e "s:/usr:${TEST}:g" test/commands/cmdtests \
		|| die "sed 5 failed"

	cd test
	make clean || die "make clean in test failed"

	echo
	elog "Using ./configure --prefix=${TEST} --with-mpi=${TEST} etc..."
	echo

	export LD_LIBRARY_PATH="${TEST}/lib:$LD_LIBRARY_PATH"

	"${S}"/configure \
		--exec-prefix="${TEST}" --with-mpi="${TEST}" \
		--disable-f90 --with-mpich2="${TEST}" $(use_enable threads) \
		|| die "configure test failed"

	nice --adjustment=3 make testing || die "make testing failed"

	"${TEST}"/bin/mpdallexit
}

src_install() {
	dodir /etc/"${PN}"

	rm -f src/mpe2/etc/*.in

	cd ../build
	make DESTDIR="${D}" LIBDIR="${D}"usr/$(get_libdir) install \
		|| die "make install failed"

	cd "${S}"

	rm -f "${D}"usr/$(get_libdir)/*.jar
	use mpe-sdk && java-pkg_dojar src/mpe2/src/slog2sdk/lib/*.jar

	dodir /usr/share/doc/"${PF}"
	if use doc; then
		dodoc README README.romio README.testing CHANGES
		dodoc README.developer RELEASE_NOTES
		newdoc src/pm/mpd/README README.mpd

		if use mpe-sdk; then
		dodoc src/mpe2/src/slog2sdk/README.sdk \
			src/mpe2/src/slog2sdk/README.rte
		newdoc src/mpe2/src/slog2sdk/FAQ FAQ.sdk
		fi
	else
		rm -rf "${D}"usr/share/doc/"${PF}"/{html,*.pdf}
		dodoc README CHANGES RELEASE_NOTES
	fi

	# Tidy up a bit
	use mpe-sdk && rm "${D}"usr/sbin/mpeuninstall
}

pkg_postinst() {
	python_mod_optimize /usr/bin

	elog ""
	elog "Several specific options are left set to default values; if"
	elog "you wish to specify non-default values for things like the"
	elog "timer type, timing level, devices, or communication channels,"
	elog "please read the docs and rebuild with MPICH_CONFIGURE_OPTS"
	elog "set to your desired options."
	elog ""
	elog "Note 1: enabling the MPE2 SDK requires both a JDK and the core"
	elog "X11 library for the full set of log analysis and conversion"
	elog "utilities.  You probably don't want to enable the mpe-sdk USE"
	elog "flag on a server, cluster node, etc."
	elog ""
	elog "Note 2: the shared libraries are now building correctly, at"
	elog "least with and without pvfs2 support (the romio USE flag is no"
	elog "longer availaible, at least until the configure scripts can be"
	elog "made to stop finding things when they're disabled)."
	elog ""
	elog "Note 3: this package still needs testing with other Fortran90"
	elog "compilers besides gfortran (gcc4).  The tests also need some"
	elog "magic to build properly within the portage build environment."
	elog "(currently the tests only build and run manually)"
	elog ""
	elog "The gfortran support has been tested successfully with hdf5"
	elog "(using gfortran and the mpif90 wrapper), however, the pvfs2"
	elog "support is brand-spanking new."
	elog ""
}

pkg_postrm() {
	python_mod_cleanup
}

setup-jvm-opts() {
	# Figure out correct boot classpath
	# stolen from eclipse-sdk ebuild
	local bp="$(java-config --jdk-home)/jre/lib"
	local bootclasspath="$(java-config --runtime)"
	if [[ ! -z "`java-config --java-version | grep IBM`" ]] ; then
		# IBM JDK
		JAVA_LIB_DIR="$(java-config --jdk-home)/jre/bin"
	else
		# Sun derived JDKs (Blackdown, Sun)
		JAVA_LIB_DIR="$(java-config --jdk-home)/jre/lib/${jvmarch}"
	fi

	JDK_TOPDIR="$(java-config --jdk-home)"
	JDK_INCDIR="$(java-config --jdk-home)/include"

	elog ""
	elog "Using bootclasspath ${bootclasspath}"
	elog "Using JVM library path ${JAVA_LIB_DIR}"
	elog "Using JDK Include dir ${JDK_INCDIR}"
	elog "Using JDK Top-level dir ${JDK_TOPDIR}"
	elog ""

	if [[ ! -f "${JAVA_LIB_DIR}"/libawt.so ]] ; then
		die "Could not find libawt.so native library"
	fi

	if [[ ! -f "${JDK_INCDIR}"/jni.h ]] ; then
		die "Could not find jni.h header file"
	fi

	export AWT_LIB_PATH="${JAVA_LIB_DIR}"
	export JDK_TOPDIR="${JDK_TOPDIR}"
	export JDK_INCDIR="${JDK_INCDIR}"
}
