# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat/gnat-3.45.ebuild,v 1.7 2006/04/11 15:19:06 george Exp $

inherit gnat flag-o-matic

MY_PV="3.4.5"

DESCRIPTION="GNAT Ada Compiler"
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${MY_PV}/gcc-core-${MY_PV}.tar.bz2
	ftp://gcc.gnu.org/pub/gcc/releases/gcc-${MY_PV}/gcc-ada-${MY_PV}.tar.bz2
	x86? ( http://dev.gentoo.org/~george/src/gcc-3.4-i386-r1.tar.bz2 )
	ppc? ( mirror://gentoo/gnat-3.15p-powerpc-unknown-linux-gnu.tar.bz2 )
	amd64? ( http://dev.gentoo.org/~george/src/gcc-3.4-amd64.tar.gz )"
HOMEPAGE="http://www.gnat.com/"

DEPEND="=sys-devel/gcc-3.4*
	!dev-lang/gnat-gcc
	!dev-lang/gnat-gpl"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
LICENSE="GMGPL"
IUSE=""

S="${WORKDIR}/gcc-${MY_PV}"
GNATBUILD="${WORKDIR}/build"
case ${ARCH} in
	ppc)
		GNATBOOT="${WORKDIR}/gnat-3.15p-powerpc-unknown-linux-gnu"
		GNATBOOTINST="${GNATBOOT}"
		GCC_EXEC_BASE="${GNATBOOT}/lib/gcc-lib"
		;;
	amd64 | x86)
		GNATBOOT="${WORKDIR}/usr"
		GCC_EXEC_BASE="${GNATBOOT}/lib/gcc"
		;;
esac

src_unpack() {
	unpack ${A}

	# Install the bootstrap compiler
	if [ "${ARCH}" = "amd64" -o "${ARCH}" = "x86" ]; then
		cd ${S}/gcc/ada/
		patch Make-lang.in < ${FILESDIR}/gnat-3.44-amd64-Make-lang.in.patch
	fi

	# Prepare the gcc source directory
	cd "${S}"
	touch gcc/cstamp-h.in
	touch gcc/ada/[es]info.h
	touch gcc/ada/nmake.ad[bs]
	mkdir -p "${GNATBUILD}"

	#fixup some hardwired flags
	sed -i -e "s:CFLAGS = -O2:CFLAGS = ${CFLAGS}:"	\
		gcc/ada/Makefile.adalib || die "patching Makefile.adalib failed"
}

src_compile() {
	# Set some paths to our bootstrap compiler.
	local GCC_EXEC_PREFIX=$(echo ${GCC_EXEC_BASE}/*/*)
	local PATH="${GNATBOOT}/bin:${PATH}"

	# this should catch one that works
	local ADA_OBJECTS_PATH
	local ADA_INCLUDE_PATH
	for x in $(find "${GCC_EXEC_PREFIX}" -name adalib); do
	   ADA_OBJECTS_PATH="${x}:${ADA_OBJECTS_PATH}"
	done
	for x in $(find "${GCC_EXEC_PREFIX}" -name adainclude); do
	   ADA_INCLUDE_PATH="${x}:${ADA_INCLUDE_PATH}"
	done

	case ${ARCH} in
		ppc)
			export LDFLAGS="-L${GCC_EXEC_PREFIX} -L${GNATBOOTINST}"
			;;
		amd64 | x86)
			export LDFLAGS="-L${GCC_EXEC_PREFIX}"
			;;
	esac
	export CC="${GNATBOOT}/bin/gcc"
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
		#otherwise make tries to reuse already compiled (without -fPIC) objs..
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
	#rm -rf ${D}/usr/lib/lib*

	# These are all provided by gcc
	rm -rf ${D}/usr/share/info/{gcc*,cpp*}
	dosym /usr/share/info/gnat_ugn_unw.info /usr/share/info/gnat.info

	#on amd64 installer misdetects arch string
	# also we need to move appropriate libgcc_s to join the other libs
	if [ "${ARCH}" == "amd64" ]; then
		local myCHOST="x86_64-unknown-linux-gnu"
		mv ${D}/usr/lib/lib64/* ${D}/usr/lib/ada/gcc/${myCHOST}/${MY_PV}/
		mv ${D}/usr/lib/lib/* ${D}/usr/lib/ada/gcc/${myCHOST}/${MY_PV}/32/
	else
		local myCHOST="${CHOST}"
		mv ${D}/usr/lib/ada/libgcc_s* ${D}/usr/lib/ada/gcc/${myCHOST}/${MY_PV}/
	fi
	dodir "/usr/lib/ada/gcc/${myCHOST}/${MY_PV}/rts-native"

	# Move the native threads library
	cd "${D}/usr/lib/ada/gcc/${myCHOST}/${MY_PV}"
	mv adalib adainclude rts-native

	# Make native threads the default
	ln -s rts-native/adalib adalib
	ln -s rts-native/adainclude adainclude

	# remove uneeded stuff
	rm -rf ${D}/usr/lib/li{b,b64} ${D}/usr/lib/ada/libiberty.a ${D}/usr/include/
}

pkg_postinst() {
	# Notify the user of what changed
	einfo ""
	einfo "The compiler has been installed as gnatgcc, and the coverage testing"
	einfo "tool as gnatgcov."
	einfo ""
	einfo "If you are upgrading from GNAT-3.15p or older you will have to"
	einfo "reemerge all Ada packages as GNAT-${MY_PV} has updated to a version of"
	einfo "GCC which is not backwards compatible with 2.8.1."
	einfo ""
}
