# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-3.4.1-r1.ebuild,v 1.14 2006/08/14 16:51:18 phreak Exp $

inherit eutils flag-o-matic libtool gnuconfig versionator

# This ebuild mod'd from libstdc++ compatbility package ebuild to create
#   a similar structure for libffi, which is also included in gcc sources.
#   __Armando Di Cianno <fafhrd@gentoo.org> (no longer a dev)

do_filter_flags() {
	declare setting

	strip-flags

	# In general gcc does not like optimization, and add -O2 where
	# it is safe.  This is especially true for gcc 3.3 + 3.4
	replace-flags -O? -O2

	# xgcc isnt patched with propolice
	filter-flags -fstack-protector-all
	filter-flags -fno-stack-protector-all
	filter-flags -fstack-protector
	filter-flags -fno-stack-protector

	# xgcc isnt patched with the gcc symbol visibility patch
	filter-flags -fvisibility-inlines-hidden
	filter-flags -fvisibility=hidden

	# strict-aliasing is known to break obj-c stuff in gcc-3.4*
	filter-flags -fstrict-aliasing

	# ...sure, why not?
	strip-unsupported-flags
}

S=${WORKDIR}/gcc-${PV}

# Theoretical cross compiler support
[ ! -n "${CCHOST}" ] && export CCHOST="${CHOST}"

LOC="/usr"
MY_PV="$(get_version_component_range 1-2)"
MY_PV_FULL="$(get_version_component_range 1-3)"

LIBPATH="${LOC}/lib/gcc-lib/${CCHOST}/${MY_PV_FULL}"
BINPATH="${LOC}/${CCHOST}/gcc-bin/${MY_PV}"
DATAPATH="${LOC}/share/gcc-data/${CCHOST}/${MY_PV}"
# Dont install in /usr/include/g++-v3/, but in gcc internal directory.
# We will handle /usr/include/g++-v3/ with gcc-config ...
STDCXX_INCDIR="${LIBPATH}/include/g++-v${MY_PV/\.*/}"

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-${PV}.tar.bz2"

DESCRIPTION="libffi (from gcc) does not commonly build unless gcj is compiled, but is used by other projects, like GNUstep."
HOMEPAGE="http://gcc.gnu.org/"

LICENSE="libffi"

KEYWORDS="-* x86 ~ppc"
IUSE="nls nptl uclibc"

SLOT="0"
## 3.2.3 -> 3.3.x install .so.5, so lets slot to 5
#if [ "${CHOST}" == "${CCHOST}" ]
#then
#	SLOT="5"
#else
#	SLOT="${CCHOST}-5"
#fi

DEPEND="virtual/libc
	!nptl? ( !uclibc? ( >=sys-libs/glibc-2.3.2-r3 ) )
	>=sys-devel/binutils-2.14.90.0.6-r1
	>=sys-devel/bison-1.875
	|| ( >=sys-devel/gcc-config-1.3.1 app-admin/eselect-compiler )
	>=sys-devel/gcc-3.4.1
	nls? ( sys-devel/gettext )"

RDEPEND="virtual/libc
	!nptl? ( !uclibc? ( >=sys-libs/glibc-2.3.2-r3 ) )
	|| ( >=sys-devel/gcc-config-1.3.1 app-admin/eselect-compiler )
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4"

PDEPEND="|| ( app-admin/eselect-compiler sys-devel/gcc-config )"

src_unpack() {
	unpack ${A}

	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/libffi-without-libgcj.dpatch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/libffi-soversion.dpatch

	# mainly for AMD64, but can't hurt to run it
	sed -i -e 's/MULTILIB_OSDIRNAMES\ =.*/MULTILIB_OSDIRNAMES\ =\ ..\/lib64\ ..\/lib32/' ${S}/gcc/config/i386/t-linux64

	cd ${S}
	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow

	cd ${S}; ./contrib/gcc_update --touch &> /dev/null
	gnuconfig_update
}

src_compile() {

	local myconf=

	if use nls
	then
		myconf="${myconf} --enable-nls --without-included-gettext"
	else
		myconf="${myconf} --disable-nls"
	fi

	use amd64 && myconf="${myconf} --disable-multilib"
	use ppc64 && myconf="${myconf} --disable-multilib"

	do_filter_flags
	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "CXXFLAGS=\"${CXXFLAGS}\""

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	einfo "Configuring libffi..."
	addwrite "/dev/zero"
	${S}/configure --prefix=${LOC} \
		--bindir=${BINPATH} \
		--includedir=${LIBPATH}/include \
		--datadir=${DATAPATH} \
		--mandir=${DATAPATH}/man \
		--infodir=${DATAPATH}/info \
		--enable-shared \
		--host=${CHOST} \
		--target=${CCHOST} \
		--with-system-zlib \
		--enable-languages=c++,objc \
		--enable-threads=posix \
		--enable-long-long \
		--disable-checking \
		--enable-cstdio=stdio \
		--enable-__cxa_atexit \
		--enable-version-specific-runtime-libs \
		--with-gxx-include-dir=${STDCXX_INCDIR} \
		--with-local-prefix=${LOC}/local \
		${myconf} || die

	touch ${S}/gcc/c-gperf.h

	einfo "Compiling libffi..."
	S="${WORKDIR}/build" \
	emake all-target-libffi \
		LIBPATH="${LIBPATH}" \
		BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O" || die
}

src_install() {
	local x=

	# Do allow symlinks in ${LOC}/lib/gcc-lib/${CHOST}/${PV}/include as
	# this can break the build.
	for x in ${WORKDIR}/build/gcc/include/*
	do
		if [ -L ${x} ]
		then
			rm -f ${x}
			continue
		fi
	done
	# Remove generated headers, as they can cause things to break
	# (ncurses, openssl, etc).
	for x in `find ${WORKDIR}/build/gcc/include/ -name '*.h'`
	do
		if grep -q 'It has been auto-edited by fixincludes from' ${x}
		then
			rm -f ${x}
		fi
	done

	einfo "Installing libffi..."
	# Do the 'make install' from the build directory
	cd ${WORKDIR}/build
	S="${WORKDIR}/build" \
	make prefix=${LOC} \
		bindir=${BINPATH} \
		includedir=${LIBPATH}/include \
		datadir=${DATAPATH} \
		mandir=${DATAPATH}/man \
		infodir=${DATAPATH}/info \
		DESTDIR="${D}" \
		LIBPATH="${LIBPATH}" \
		install-target-libffi || die

	mkdir -p ${D}/${LOC}/include/${PN}
	mv ${D}/${LOC}/lib/gcc-lib/${CCHOST}/${PV}/include/* ${D}/${LOC}/include/${PN}
	mv ${D}/${LOC}/lib/gcc/${CCHOST}/${PV}/include/libffi/* ${D}/${LOC}/include/${PN}
	# remove now useless directory...
	rm -Rf ${D}/${LOC}/lib/gcc-lib/
	rm -Rf ${D}/${LOC}/lib/gcc

	mkdir -p ${D}/${LOC}/lib/${PN}/
	mv ${D}/${LOC}/{lib,lib64}/* ${D}/${LOC}/lib/${PN}/

	mkdir -p ${D}/etc/env.d/
	echo "LDPATH=\"${LOC}/lib/${PN}\"" >> ${D}/etc/env.d/99libffi
	echo "CPATH=\"${LOC}/include/${PN}\"" >> ${D}/etc/env.d/99libffi
}

