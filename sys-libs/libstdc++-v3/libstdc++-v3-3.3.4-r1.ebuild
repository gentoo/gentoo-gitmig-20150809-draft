# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libstdc++-v3/libstdc++-v3-3.3.4-r1.ebuild,v 1.2 2004/09/06 14:56:36 lv Exp $

inherit eutils flag-o-matic libtool gnuconfig toolchain

DESCRIPTION="Compatibility package for running binaries linked against a pre gcc 3.4 libstdc++"
HOMEPAGE="http://gcc.gnu.org/libstdc++/"
LICENSE="GPL-2 LGPL-2.1"
#KEYWORDS="-* ~x86 ~mips ~amd64 ~ppc64 ~ppc"
# just until i know for sure the toolchain eclass is done
KEYWORDS="-*"


PP_VER="3_3_2"
PP_FVER="${PP_VER//_/.}-2"
GCC_MANPAGE_VERSION="none"

SRC_URI="$(get_gcc_src_uri)"
S="$(gcc_get_s_dir)"
ETYPE="gcc"

if [ "${CHOST}" == "${CCHOST}" ]
then
	SLOT="3.3.3"
else
	SLOT="${CCHOST}-3.3.3"
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


do_filter_flags() {
	declare setting

	strip-flags

	# In general gcc does not like optimization, and add -O2 where
	# it is safe.  This is especially true for gcc 3.3 + 3.4
	replace-flags -O? -O2

	# we need to filter the 3.4 specific amd64 -marchs
	filter-flags -march=k8
	filter-flags -march=athlon64
	filter-flags -march=opteron

	# gcc 3.3 doesn't support -march=pentium-m
	replace-flags -march=pentium-m -march=pentium3

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

	# xgcc isnt patched with the gcc symbol visibility patch
	filter-flags -fvisibility-inlines-hidden
	filter-flags -fvisibility=hidden

	# ...sure, why not?
	strip-unsupported-flags
}


src_compile() {
	do_filter_flags
	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "CXXFLAGS=\"${CXXFLAGS}\""

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	einfo "Configuring libstdc++..."
	GCC_TARGET_NO_MULTILIB="true"
	GCC_LANG="c,c++"
	gcc_do_configure non-versioned

	touch ${S}/gcc/c-gperf.h

	einfo "Compiling libstdc++..."
	gcc_do_make all-target-libstdc++-v3
}

src_install() {
	einfo "Installing libstdc++..."
	# Do the 'make install' from the build directory
	cd ${WORKDIR}/build
	S="${WORKDIR}/build" \
	make DESTDIR="${WORKDIR}/tmpimage" install-target-libstdc++-v3 || die

	# for some reason gcc insists on installing crap that has nothing to do
	# with our target, so lets copy over what we actually want.
	mkdir -p ${D}/${LOC}/$(get_libdir)/libstdc++-v3/
	cp -R ${WORKDIR}/tmpimage/usr/*/libstdc++.so.* ${D}/${LOC}/$(get_libdir)/libstdc++-v3/
	add_version_to_shared

	mkdir -p ${D}/etc/env.d/
	echo "LDPATH=\"${LOC}/$(get_libdir)/libstdc++-v3/\"" >> ${D}/etc/env.d/99libstdc++
}
