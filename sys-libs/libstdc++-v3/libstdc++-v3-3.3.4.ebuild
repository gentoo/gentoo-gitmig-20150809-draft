# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libstdc++-v3/libstdc++-v3-3.3.4.ebuild,v 1.5 2004/10/27 03:44:37 morfic Exp $

inherit eutils flag-o-matic libtool gnuconfig versionator

do_filter_flags() {
	declare setting

	strip-flags

	# In general gcc does not like optimization, and add -O2 where
	# it is safe.  This is especially true for gcc 3.3 + 3.4
	replace-flags -O? -O2

	if use amd64
	then
		# gcc 3.3 doesn't support -march=k8/etc on amd64, so xgcc will fail
		setting="`get-flag march`"
		[ ! -z "${setting}" ] && filter-flags -march="${setting}"
	fi

	# and on x86, we just need to filter the 3.4 specific amd64 -marchs
	filter-flags -march=k8
	filter-flags -march=athlon64
	filter-flags -march=opteron

	# gcc 3.3 doesn't support -march=pentium-m
	replace-flags -march=pentium-m -march=pentium3

	#GCC 3.3 does not understand G3, G4, G5 on ppc
	replace-flags -mcpu=G3 -mcpu=750
	replace-flags -mcpu=G4 -mcpu=7400
	replace-flags -mtune=G3 -mtune=750
	replace-flags -mtune=G4 -mtune=7400
	filter-flags -mcpu=G5
	filter-flags -mtune=G5

	# gcc 3.3 doesn't support -mtune on numerous archs, so xgcc will fail
	if use x86 || use amd64 ; then
		setting="`get-flag mtune`"
		[ ! -z "${setting}" ] && filter-flags -mtune="${setting}"
	fi

	# xgcc wont understand gcc 3.4 flags...
	filter-flags -fno-unit-at-a-time
	filter-flags -funit-at-a-time
	filter-flags -fweb
	filter-flags -fno-web

	# xgcc isnt patched with propolice
	filter-flags -fstack-protector-all
	filter-flags -fno-stack-protector-all
	filter-flags -fstack-protector
	filter-flags -fno-stack-protector

	# xgcc isnt patched with the gcc symbol visibility patch
	filter-flags -fvisibility-inlines-hidden
	filter-flags -fvisibility=hidden

	# ...sure, why not?
	strip-unsupported-flags
}

S=${WORKDIR}/gcc-${PV}

# Theoretical cross compiler support
[ ! -n "${CCHOST}" ] && export CCHOST="${CHOST}"

LOC="/usr"
#MY_PV="`echo ${PV} | awk -F. '{ gsub(/_pre.*|_alpha.*/, ""); print $1 "." $2 }'`"
#MY_PV_FULL="`echo ${PV} | awk '{ gsub(/_pre.*|_alpha.*/, ""); print $0 }'`"
MY_PV="$(get_version_component_range 1-2)"
MY_PV_FULL="$(get_version_component_range 1-3)"

LIBPATH="${LOC}/lib/gcc-lib/${CCHOST}/${MY_PV_FULL}"
BINPATH="${LOC}/${CCHOST}/gcc-bin/${MY_PV}"
DATAPATH="${LOC}/share/gcc-data/${CCHOST}/${MY_PV}"
# Dont install in /usr/include/g++-v3/, but in gcc internal directory.
# We will handle /usr/include/g++-v3/ with gcc-config ...
STDCXX_INCDIR="${LIBPATH}/include/g++-v${MY_PV/\.*/}"

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-${PV}.tar.bz2"

DESCRIPTION="Compatibility package for running binaries linked against a pre gcc 3.4 libstdc++"
HOMEPAGE="http://gcc.gnu.org/libstdc++/"

LICENSE="GPL-2 LGPL-2.1"

KEYWORDS="-* ~x86 ~mips ~amd64 ~ppc64 ~ppc"
IUSE="nls"

# 3.2.3 -> 3.3.x install .so.5, so lets slot to 5
if [ "${CHOST}" == "${CCHOST}" ]
then
	SLOT="5"
else
	SLOT="${CCHOST}-5"
fi

DEPEND="virtual/libc
	!nptl? ( !uclibc? ( >=sys-libs/glibc-2.3.2-r3 ) )
	>=sys-devel/binutils-2.14.90.0.6-r1
	>=sys-devel/bison-1.875
	>=sys-devel/gcc-config-1.3.1
	>=sys-devel/gcc-3.3.3_pre20040130
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"

RDEPEND="virtual/libc
	!nptl? ( !uclibc? ( >=sys-libs/glibc-2.3.2-r3 ) )
	>=sys-devel/gcc-config-1.3.1
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"

PDEPEND="sys-devel/gcc-config"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow

	use amd64 && epatch ${FILESDIR}/libstdc++_amd64_multilib_hack.patch

	# Misdesign in libstdc++ (Redhat)
	cp -a ${S}/libstdc++-v3/config/cpu/i{4,3}86/atomicity.h

	cd ${S}; ./contrib/gcc_update --touch &> /dev/null
	gnuconfig_update
}

src_compile() {

	local myconf=

	if ! use nls || use build
	then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi

	use amd64 && myconf="${myconf} --disable-multilib"

	do_filter_flags
	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "CXXFLAGS=\"${CXXFLAGS}\""

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	einfo "Configuring libstdc++..."
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
		--enable-languages=c++ \
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

	# Setup -j in MAKEOPTS
	get_number_of_jobs

	einfo "Compiling libstdc++..."
	S="${WORKDIR}/build" \
	emake all-target-libstdc++-v3 \
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

	einfo "Installing libstdc++..."
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
		install-target-libstdc++-v3 || die

	# we'll move this into a directory we can put at the end of ld.so.conf
	# other than the normal versioned directory, so that it doesnt conflict
	# with gcc 3.3.3
	mkdir -p ${D}/${LOC}/lib/libstdc++-v3/
	mv ${D}/${LIBPATH}/lib* ${D}/${LOC}/lib/libstdc++-v3/
	# we dont want the headers...
	rm -rf ${D}/${LOC}/lib/gcc*
	# or locales...
	rm -rf ${D}/${LOC}/share
	# or anything other than the .so files, really.
	find ${D} | grep -e c++.la$ -e c++.a$ | xargs rm -f
	# we dont even want the un-versioned .so symlink, as it confuses some
	# apps and also causes others to link against the old libstdc++...
	rm ${D}/${LOC}/lib/libstdc++-v3/libstdc++.so

	# and it's much easier to just move around the result than it is to
	# configure libstdc++-v3 to use CONF_LIDIR
	if [ "$(get_libdir)" != "lib" ] ; then
		mv ${D}/${LOC}/lib ${D}/${LOC}/$(get_libdir)
	fi

	mkdir -p ${D}/etc/env.d/
	echo "LDPATH=\"${LOC}/lib/libstdc++-v3/\"" >> ${D}/etc/env.d/99libstdc++
}
