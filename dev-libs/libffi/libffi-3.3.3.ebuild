# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-3.3.3.ebuild,v 1.1 2004/08/27 20:21:47 fafhrd Exp $

IUSE="nls"
SLOT="0"
inherit eutils flag-o-matic libtool

# This ebuild mod'd from libstdc++ compatbility package ebuild to create
#   a similar structure for libffi, which is also included in gcc sources.
#   __Armando Di Cianno <fafhrd@gentoo.org>

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
	strip-flags

	# In general gcc does not like optimization, and add -O2 where
	# it is safe.  This is especially true for gcc 3.3 + 3.4
	replace-flags -O? -O2

#    if use amd64
#    then
#        # gcc 3.3 doesnt support -march=k8/etc on amd64, so xgcc will fail
#        setting="`get-flag march`"
#        [ ! -z "${setting}" ] && filter-flags -march="${setting}"
#    fi

	# gcc 3.3 doesnt support -mtune on numerous archs, so xgcc will fail
	mtsetting="`get-flag mtune`"
	[ ! -z "${mtsetting}" ] && filter-flags -mtune="${mtsetting}"

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

# Branch update support ...
MAIN_BRANCH="${PV}"  # Tarball, etc used ...

# This branch update includes libffi fixes, so we include it here
BRANCH_UPDATE="20040412"

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-${PV}.tar.bz2"
#	mirror://gentoo/gcc-3.3.3-branch-update-${BRANCH_UPDATE}.patch.bz2"

DESCRIPTION="libffi (from gcc) does not commonly build unless gcj is compiled, but is used by other projects, like GNUstep."
HOMEPAGE="http://gcc.gnu.org/"

# libffi itself under an "as-is" license, the rest of GCC can be.
#  and is, different
LICENSE="libffi"

KEYWORDS="-* ~x86"

DEPEND="virtual/libc
	!nptl? ( >=sys-libs/glibc-2.3.2-r3 )
	>=sys-devel/binutils-2.14.90.0.6-r1
	>=sys-devel/bison-1.875
	>=sys-devel/gcc-config-1.3.1
	=sys-devel/gcc-3.3.3*
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

	#use amd64 && epatch ${FILESDIR}/libstdc++_amd64_multilib_hack.patch

	# Branch update ...
#	if [ -n "${BRANCH_UPDATE}" ]
#	then
#		epatch ${DISTDIR}/gcc-${MAIN_BRANCH}-branch-update-${BRANCH_UPDATE}.patch.bz2
#	fi

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

	#use amd64 && myconf="${myconf} --disable-multilib"

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
		--enable-languages=java,c++,objc \
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

	einfo "Installing libfii..."
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

	# we want the headers...
	mkdir -p ${D}/${LOC}/include/${PN}
	mv ${D}/${LOC}/lib/gcc-lib/${CCHOST}/${PV}/include/* ${D}/${LOC}/include/${PN}
	# remove now useless directory...
	rm -Rf ${D}/${LOC}/lib/gcc-lib/
	# we'll move this into a directory we can put at the end of ld.so.conf
	# other than the normal versioned directory, so that it doesnt conflict
	# with gcc 3.3.3
	mkdir -p ${D}/${LOC}/lib/${PN}
	mv ${D}/${LOC}/lib/* ${D}/${LOC}/lib/${PN}

	mkdir -p ${D}/etc/env.d/
	echo "LDPATH=\"${LOC}/lib/${PN}\"" >> ${D}/etc/env.d/99libffi
	echo "CPATH=\"${LOC}/include/${PN}\"" >> ${D}/etc/env.d/99libffi
}

