# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libstdc++-v3/libstdc++-v3-3.3.3-r1.ebuild,v 1.15 2004/07/31 19:53:40 agriffis Exp $

IUSE="nls"

inherit eutils flag-o-matic libtool

# Compile problems with these (bug #6641 among others)...
#filter-flags "-fno-exceptions -fomit-frame-pointer -fforce-addr"

# Recently there has been a lot of stability problem in Gentoo-land.  Many
# things can be the cause to this, but I believe that it is due to gcc3
# still having issues with optimizations, or with it not filtering bad
# combinations (protecting the user maybe from himeself) yet.
#
# This can clearly be seen in large builds like glibc, where too aggressive
# CFLAGS cause the tests to fail miserbly.
#
# Quote from Nick Jones <carpaski@gentoo.org>, who in my opinion
# knows what he is talking about:
#
#   People really shouldn't force code-specific options on... It's a
#   bad idea. The -march options aren't just to look pretty. They enable
#   options that are sensible (and include sse,mmx,3dnow when apropriate).
#
# The next command strips CFLAGS and CXXFLAGS from nearly all flags.  If
# you do not like it, comment it, but do not bugreport if you run into
# problems.
#
# <azarah@gentoo.org> (13 Oct 2002)
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

	# gcc 3.3 doesn't support -march=pentium-m
	replace-flags -march=pentium-m -march=pentium3

	# gcc 3.3 doesn't support -mtune on numerous archs, so xgcc will fail
	setting="`get-flag mtune`"
	[ ! -z "${setting}" ] && filter-flags -mtune="${setting}"

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
MY_PV="`echo ${PV} | awk -F. '{ gsub(/_pre.*|_alpha.*/, ""); print $1 "." $2 }'`"
MY_PV_FULL="`echo ${PV} | awk '{ gsub(/_pre.*|_alpha.*/, ""); print $0 }'`"

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

KEYWORDS="-* amd64 ~mips x86"

if [ "${CHOST}" == "${CCHOST}" ]
then
	SLOT="3.3.3"
else
	SLOT="${CCHOST}-3.3.3"
fi

DEPEND="virtual/libc
	!nptl? ( >=sys-libs/glibc-2.3.2-r3 )
	>=sys-devel/binutils-2.14.90.0.6-r1
	>=sys-devel/bison-1.875
	>=sys-devel/gcc-config-1.3.1
	>=sys-devel/gcc-3.3.3
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"

RDEPEND="virtual/libc
	!nptl? ( >=sys-libs/glibc-2.3.2-r3 )
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

	mkdir -p ${D}/etc/env.d/
	echo "LDPATH=\"${LOC}/lib/libstdc++-v3/\"" >> ${D}/etc/env.d/99libstdc++
}

