# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libffi/libffi-3.4.1.ebuild,v 1.16 2007/07/12 02:25:34 mr_bones_ Exp $

IUSE="nls nptl"
SLOT="0"
inherit eutils flag-o-matic libtool versionator multilib

# This ebuild mod'd from libstdc++ compatbility package ebuild to create
#   a similar structure for libffi, which is also included in gcc sources.
#   __Armando Di Cianno <fafhrd@gentoo.org> (not a dev any more)

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
MY_PV="$(get_version_component_range 1-2)"
MY_PV_FULL="$(get_version_component_range 1-3)"

LIBPATH="${LOC}/$(get_libdir)/gcc-lib/${CCHOST}/${MY_PV_FULL}"
BINPATH="${LOC}/${CCHOST}/gcc-bin/${MY_PV}"
DATAPATH="${LOC}/share/gcc-data/${CCHOST}/${MY_PV}"
# Dont install in /usr/include/g++-v3/, but in gcc internal directory.
# We will handle /usr/include/g++-v3/ with gcc-config ...
STDCXX_INCDIR="${LIBPATH}/include/g++-v${MY_PV/\.*/}"

# Branch update support ...
MAIN_BRANCH="${PV}"  # Tarball, etc used ...

# This branch update includes libffi fixes, so we include it here
#BRANCH_UPDATE="20040412"
BRANCH_UPDATE=

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-${PV}.tar.bz2"

DESCRIPTION="libffi (from gcc) does not commonly build unless gcj is compiled, but is used by other projects, like GNUstep."
HOMEPAGE="http://gcc.gnu.org/"

# libffi itself under an "as-is" license, the rest of GCC can be.
#  and is, different
LICENSE="libffi"

KEYWORDS="-* amd64"

DEPEND="virtual/libc
	!nptl? ( >=sys-libs/glibc-2.3.2-r3 )
	>=sys-devel/binutils-2.14.90.0.8-r1
	>=sys-devel/bison-1.875
	|| ( >=sys-devel/gcc-config-1.3.1 app-admin/eselect-compiler )
	nls? ( sys-devel/gettext )"

RDEPEND="virtual/libc
	!nptl? ( >=sys-libs/glibc-2.3.2-r3 )
	|| ( >=sys-devel/gcc-config-1.3.1 app-admin/eselect-compiler )
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4"

PDEPEND="|| ( app-admin/eselect-compiler sys-devel/gcc-config )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow

	#use amd64 && epatch ${FILESDIR}/libstdc++_amd64_multilib_hack.patch
	# not quite needed since we disable multilib in this ebuild, but it cant
	# hurt to have anyway, just in case
	sed -i -e 's/MULTILIB_OSDIRNAMES\ =.*/MULTILIB_OSDIRNAMES\ =\ ..\/lib64\ ..\/lib32/' ${S}/gcc/config/i386/t-linux64

	# Branch update ...
	if [ -n "${BRANCH_UPDATE}" ]
	then
		epatch ${DISTDIR}/gcc-${MAIN_BRANCH}-branch-update-${BRANCH_UPDATE}.patch.bz2
	fi

	cd ${S}; ./contrib/gcc_update --touch &> /dev/null
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

	# we'll move this into a directory we can put at the end of ld.so.conf
	# other than the normal versioned directory, so that it doesnt conflict
	# with gcc

	# we want the headers...
	mkdir -p ${D}/${LOC}/include/${PN}
	mv ${D}/${LOC}/$(get_libdir)/gcc-lib/${CCHOST}/${PV}/include/* ${D}/${LOC}/include/${PN}
	mv ${D}/${LOC}/lib/gcc/${CCHOST}/${PV}/include/libffi/* ${D}/${LOC}/include/${PN}
	# remove now useless directory...
	rm -Rf ${D}/${LOC}/$(get_libdir)/gcc-lib/
	rm -Rf ${D}/${LOC}/lib/gcc

	mkdir -p ${D}/${LOC}/$(get_libdir)/${PN}/
	mv ${D}/${LOC}/$(get_libdir)/* ${D}/${LOC}/$(get_libdir)/${PN}/

	mkdir -p ${D}/etc/env.d/
	echo "LDPATH=\"${LOC}/$(get_libdir)/${PN}\"" >> ${D}/etc/env.d/99libffi
	echo "CPATH=\"${LOC}/include/${PN}\"" >> ${D}/etc/env.d/99libffi
}
