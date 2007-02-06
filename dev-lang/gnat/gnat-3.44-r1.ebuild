# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat/gnat-3.44-r1.ebuild,v 1.6 2007/02/06 08:09:10 genone Exp $

MY_PV="3.4.4"

DESCRIPTION="GNAT Ada Compiler"
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${MY_PV}/gcc-core-${MY_PV}.tar.bz2
	ftp://gcc.gnu.org/pub/gcc/releases/gcc-${MY_PV}/gcc-ada-${MY_PV}.tar.bz2
	x86? ( http://gd.tuwien.ac.at/languages/ada/gnat/3.15p/gnat-3.15p-i686-pc-redhat71-gnu-bin.tar.gz )
	ppc? ( mirror://gentoo/gnat-3.15p-powerpc-unknown-linux-gnu.tar.bz2 )"
HOMEPAGE="http://www.gnat.com/"

DEPEND="=sys-devel/gcc-3*
	x86? ( >=app-shells/tcsh-6.0 )"

SLOT="0"
KEYWORDS="~x86 -amd64"
LICENSE="GMGPL"
IUSE=""

S="${WORKDIR}/gcc-${MY_PV}"
GNATBUILD="${WORKDIR}/build"
case ${ARCH} in
	x86)
		GNATBOOT="${WORKDIR}/boot"
		GNATBOOTINST="${WORKDIR}/gnat-3.15p-i686-pc-linux-gnu-bin"
		GCC_EXEC_BASE="${GNATBOOT}/lib/gcc-lib"
		;;
	ppc)
		GNATBOOT="${WORKDIR}/gnat-3.15p-powerpc-unknown-linux-gnu"
		GNATBOOTINST="${GNATBOOT}"
		GCC_EXEC_BASE="${GNATBOOT}/lib/gcc-lib"
		;;
esac

# gnat is getting bootstrapped off an older backend, set minimal flags
# use later versions for more modern gcc support
CFLAGS="-O2 -pipe"
CXXFLAGS="${CFLAGS}"

src_unpack() {
	unpack ${A}

	# Install the bootstrap compiler
	if [ "${ARCH}" = "x86" ]; then
		cd "${GNATBOOTINST}"
		patch -p1 < ${FILESDIR}/gnat-3.15p-i686-pc-linux-gnu-bin.patch
		# tcsh no longer installs symlink to csh
		sed -i -e "s:/bin/csh:/bin/tcsh:" doconfig
		echo $'\n'3$'\n'${GNATBOOT}$'\n' | ./doconfig > doconfig.log 2>&1
		./doinstall
	fi

	# Prepare the gcc source directory
	cd "${S}"
	touch gcc/cstamp-h.in
	touch gcc/ada/[es]info.h
	touch gcc/ada/nmake.ad[bs]
	mkdir -p "${GNATBUILD}"
}

src_compile() {
	# Set some paths to our bootstrap compiler.
	local GCC_EXEC_PREFIX=$(echo ${GCC_EXEC_BASE}/*/*)
	local PATH="${GNATBOOT}/bin:${PATH}"

	# hopefully this will catch one that works
	local ADA_OBJECTS_PATH
	local ADA_INCLUDE_PATH
	for x in $(find "${GCC_EXEC_PREFIX}" -name adalib); do
	   ADA_OBJECTS_PATH="${x}:${ADA_OBJECTS_PATH}"
	done
	for x in $(find "${GCC_EXEC_PREFIX}" -name adainclude); do
	   ADA_INCLUDE_PATH="${x}:${ADA_INCLUDE_PATH}"
	done

	local LDFLAGS="-L${GCC_EXEC_PREFIX} -L${GNATBOOTINST}"
	local CC="${GNATBOOT}/bin/gcc"
	export LD_LIBRARY_PATH="${GNATBOOT}/lib"

	# Configure gcc
	cd "${GNATBUILD}"
	CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" "${S}"/configure --prefix=/usr \
		--program-prefix=gnat \
		--enable-languages="c,ada" \
		--enable-libada \
		--with-gcc \
		--enable-threads=posix \
		--enable-shared \
		--with-system-zlib \
		--disable-nls \
		--libdir=/usr/lib/ada \
		--libexecdir=/usr/libexec/ada \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		|| die "configure failed"

	# Compile helper tools
	cd "${GNATBOOT}"
	cp ${S}/gcc/ada/xtreeprs.adb .
	cp ${S}/gcc/ada/xsinfo.adb .
	cp ${S}/gcc/ada/xeinfo.adb .
	cp ${S}/gcc/ada/xnmake.adb .
	gnatmake xtreeprs && \
		gnatmake xsinfo && \
		gnatmake xeinfo && \
		gnatmake xnmake || die "building helper tools"

	for i in `find ${S}/gcc/ada -name '*.ad[sb]'`; do \
		sed -i -e "s/\"gcc\"/\"gnatgcc\"/g" ${i}; \
	done

	cd "${GNATBUILD}"
	emake bootstrap || die "bootstrap failed"

	einfo "building gnatlib_and_tools"
	# make rts honor user defined CFLAGS
	MAKEOPTS=-j1 emake -C gcc gnatlib_and_tools || die "gnatlib_and_tools failed"

	einfo "building shared lib"
	rm -f gcc/ada/rts/*.{o,ali} || die
	MAKEOPTS=-j1 emake -C gcc gnatlib-shared LIBRARY_VERSION=3.4 || die "gnatlib-shared failed"
}

src_install() {
	# Do not allow symlinks in /usr/lib/gcc/${CHOST}/${MY_PV}/include as
	# this can break the build.
	for x in ${WORKDIR}/build/gcc/include/*
	do
		if [ -L ${x} ]
		then
			rm -f ${x}
		fi
	done

	# Install gnatgcc, tools and native threads library
	cd "${GNATBUILD}"
	make prefix=${D}/usr \
		libdir=${D}/usr/lib/ada \
		libexecdir=${D}/usr/libexec/ada \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "died while installing"

	#above make installs libgcc_s into weird location
	#removing it, as it is provided by gcc anyway
	rm -rf ${D}/usr/lib/lib*

	# These are all provided by gcc
	rm -rf ${D}/usr/share/info/{gcc*,cpp*}

	local myCHOST="${CHOST}"
	dodir "/usr/lib/ada/gcc/${myCHOST}/${MY_PV}/rts-native"

	# Move the native threads library
	cd "${D}/usr/lib/ada/gcc/${myCHOST}/${MY_PV}"
	mv adalib adainclude rts-native

	# Make native threads the default
	ln -s rts-native/adalib adalib
	ln -s rts-native/adainclude adainclude
}

pkg_postinst() {
	# Notify the user of what changed
	elog
	elog "The compiler has been installed as gnatgcc, and the coverage testing"
	elog "tool as gnatgcov."
	elog
	elog "If you are upgrading from GNAT-3.15p or older you will have to"
	elog "reemerge all Ada packages as GNAT-${MY_PV} has updated to a version of"
	elog "GCC which is not backwards compatible with 2.8.1."
	elog
}
