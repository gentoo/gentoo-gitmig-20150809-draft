# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.3.4.20050125-r1.ebuild,v 1.57 2005/08/04 19:36:30 azarah Exp $

# Here's how the cross-compile logic breaks down ...
#  CTARGET - machine that will target the binaries
#  CHOST   - machine that will host the binaries
#  CBUILD  - machine that will build the binaries
# If CTARGET != CHOST, it means you want a libc for cross-compiling.
# If CHOST != CBUILD, it means you want to cross-compile the libc.
#  CBUILD = CHOST = CTARGET    - native build/install
#  CBUILD != (CHOST = CTARGET) - cross-compile a native build
#  (CBUILD = CHOST) != CTARGET - libc for cross-compiler
#  CBUILD != CHOST != CTARGET  - cross-compile a libc for a cross-compiler
# For install paths:
#  CHOST = CTARGET  - install into /
#  CHOST != CTARGET - install into /usr/CTARGET/

KEYWORDS="~amd64 ~ia64 mips -ppc ~sparc ~x86"

BRANCH_UPDATE=""

# From linuxthreads/man
GLIBC_MANPAGE_VERSION="2.3.4-r1"

# From manual
GLIBC_INFOPAGE_VERSION="2.3.4-r1"

# Gentoo patchset
PATCH_VER="1.7"

# C Stubbs addon (contained in fedora, so ignoring)
#CSTUBS_VER="2.1.2"
#CSTUBS_TARBALL="c_stubs-${CSTUBS_VER}.tar.bz2"
#CSTUBS_URI="http://dev.gentoo.org/~eradicator/glibc/${CSTUBS_TARBALL}"

# Fedora addons (from RHEL's glibc-2.3.4-2.src.rpm)
FEDORA_VER="20041219T2331"
FEDORA_TARBALL="glibc-fedora-${FEDORA_VER}.tar.bz2"
FEDORA_URI="http://dev.gentoo.org/~eradicator/glibc/${FEDORA_TARBALL}"

GENTOO_TOOLCHAIN_BASE_URI="http://dev.gentoo.org/~eradicator/glibc"

### PUNT OUT TO ECLASS?? ###
inherit eutils versionator libtool toolchain-funcs flag-o-matic gnuconfig multilib

DESCRIPTION="GNU libc6 (also called glibc2) C library"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"
LICENSE="LGPL-2"

IUSE="build erandom hardened multilib nls nomalloccheck nptl nptlonly pic userlocales selinux"

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi
if [[ ${CTARGET} == ${CHOST} ]] ; then
	PROVIDE="virtual/libc"
fi

is_crosscompile() {
	[[ ${CHOST} != ${CTARGET} ]]
}

GLIBC_RELEASE_VER=$(get_version_component_range 1-3)

# Don't set this to :-, - allows BRANCH_UPDATE=""
BRANCH_UPDATE=${BRANCH_UPDATE-$(get_version_component_range 4)}

# (Recent snapshots fails with 2.6.5 and earlier with NPTL)
NPTL_KERNEL_VERSION=${NPTL_KERNEL_VERSION:-"2.6.6"}
LT_KERNEL_VERSION=${LT_KERNEL_VERSION:-"2.4.1"}

### SRC_URI ###

# This function handles the basics of setting the SRC_URI for a glibc ebuild.
# To use, set SRC_URI with:
#
#	SRC_URI="$(get_glibc_src_uri)"
#
# Other than the variables normally set by portage, this function's behavior
# can be altered by setting the following:
#
#	GENTOO_TOOLCHAIN_BASE_URI
#			This sets the base URI for all gentoo-specific patch files. Note
#			that this variable is only important for a brief period of time,
#			before your source files get picked up by mirrors. However, it is
#			still highly suggested that you keep files in this location
#			available.
#
#	BRANCH_UPDATE
#			If set, this variable signals that we should be using the main
#			release tarball (determined by ebuild version) and applying a
#			CVS branch update patch against it. The location of this branch
#			update patch is assumed to be in ${GENTOO_TOOLCHAIN_BASE_URI}.
#			Just like with SNAPSHOT, this variable is ignored if the ebuild
#			has a _pre suffix.
#
#	PATCH_VER
#	PATCH_GLIBC_VER
#			This should be set to the version of the gentoo patch tarball.
#			The resulting filename of this tarball will be:
#			${PN}-${PATCH_GLIBC_VER:-${GLIBC_RELEASE_VER}}-patches-${PATCH_VER}.tar.bz2
#
#	GLIBC_MANPAGE_VERSION
#	GLIBC_INFOPAGE_VERSION
#			The version of glibc for which we will download pages. This will
#			default to ${GLIBC_RELEASE_VER}, but we may not want to pre-generate man pages
#			for prerelease test ebuilds for example. This allows you to
#			continue using pre-generated manpages from the last stable release.
#			If set to "none", this will prevent the downloading of manpages,
#			which is useful for individual library targets.
#
get_glibc_src_uri() {
	# This variable should be set to the devspace of whoever is currently
	# maintaining GLIBC. Please dont set this to mirror, that would just
	# make the files unavailable until they get mirrored.
	local devspace_uri="http://dev.gentoo.org/~eradicator/glibc/"
	GENTOO_TOOLCHAIN_BASE_URI=${GENTOO_TOOLCHAIN_BASE_URI:-${devspace_uri}}

#	GLIBC_SRC_URI="http://ftp.gnu.org/gnu/glibc/${PN}-${GLIBC_RELEASE_VER}.tar.bz2
#	               http://ftp.gnu.org/gnu/glibc/${PN}-linuxthreads-${GLIBC_RELEASE_VER}.tar.bz2
#	               http://ftp.gnu.org/gnu/glibc/${PN}-libidn-${GLIBC_RELEASE_VER}.tar.bz2
	GLIBC_SRC_URI="mirror://gnu/glibc/${PN}-${GLIBC_RELEASE_VER}.tar.bz2
	               mirror://gnu/glibc/${PN}-linuxthreads-${GLIBC_RELEASE_VER}.tar.bz2
	               mirror://gnu/glibc/${PN}-libidn-${GLIBC_RELEASE_VER}.tar.bz2"

	if [[ -n ${BRANCH_UPDATE} ]] ; then
		GLIBC_SRC_URI="${GLIBC_SRC_URI}
			${GENTOO_TOOLCHAIN_BASE_URI}/${PN}-${GLIBC_RELEASE_VER}-branch-update-${BRANCH_UPDATE}.patch.bz2"
	fi

	if [[ -n ${PATCH_VER} ]] ; then
		GLIBC_SRC_URI="${GLIBC_SRC_URI}
			${GENTOO_TOOLCHAIN_BASE_URI}/${PN}-${PATCH_GLIBC_VER:-${GLIBC_RELEASE_VER}}-patches-${PATCH_VER}.tar.bz2"
	fi

	if [[ ${GLIBC_MANPAGE_VERSION} != "none" ]] ; then
		GLIBC_SRC_URI="${GLIBC_SRC_URI}
			${GENTOO_TOOLCHAIN_BASE_URI}/${PN}-manpages-${GLIBC_MANPAGE_VERSION:-${GLIBC_RELEASE_VER}}.tar.bz2"
	fi

	if [[ ${GLIBC_INFOPAGE_VERSION} != "none" ]] ; then
		GLIBC_SRC_URI="${GLIBC_SRC_URI}
			${GENTOO_TOOLCHAIN_BASE_URI}/${PN}-infopages-${GLIBC_INFOPAGE_VERSION:-${GLIBC_RELEASE_VER}}.tar.bz2"
	fi

	if [[ -n ${CSTUBS_URI} ]] ; then
		GLIBC_SRC_URI="${GLIBC_SRC_URI} ${CSTUBS_URI}"
	fi

	if [[ -n ${FEDORA_URI} ]] ; then
		GLIBC_SRC_URI="${GLIBC_SRC_URI} ${FEDORA_URI}"
	fi

	echo "${GLIBC_SRC_URI}"
}

SRC_URI=$(get_glibc_src_uri)
S="${WORKDIR}/${PN}-${GLIBC_RELEASE_VER}"

### EXPORTED FUNCTIONS ###
toolchain-glibc_src_unpack() {
	# Check NPTL support _before_ we unpack things to save some time
	want_nptl && check_nptl_support

	unpack ${PN}-${GLIBC_RELEASE_VER}.tar.bz2

	cd ${S}
	unpack ${PN}-linuxthreads-${GLIBC_RELEASE_VER}.tar.bz2
	unpack ${PN}-libidn-${GLIBC_RELEASE_VER}.tar.bz2

	if [[ -n ${CSTUBS_TARBALL} ]] ; then
		unpack ${CSTUBS_TARBALL}
	fi

	if [[ -n ${FEDORA_TARBALL} ]] ; then
		unpack ${FEDORA_TARBALL}
	fi

	if [[ -n ${PATCH_VER} ]] ; then
		cd ${WORKDIR}
		unpack ${PN}-${PATCH_GLIBC_VER:-${GLIBC_RELEASE_VER}}-patches-${PATCH_VER}.tar.bz2
	fi

	if [[ ${GLIBC_MANPAGE_VERSION} != "none" ]] ; then
		cd ${WORKDIR}
		unpack ${PN}-manpages-${GLIBC_MANPAGE_VERSION:-${GLIBC_RELEASE_VER}}.tar.bz2
	fi

	if [[ ${GLIBC_INFOPAGE_VERSION} != "none" ]] ; then
		cd ${S}
		unpack ${PN}-infopages-${GLIBC_INFOPAGE_VERSION:-${GLIBC_RELEASE_VER}}.tar.bz2
	fi

	if [[ -n ${BRANCH_UPDATE} ]] ; then
		cd ${WORKDIR}
		unpack ${PN}-${GLIBC_RELEASE_VER}-branch-update-${BRANCH_UPDATE}.patch.bz2
	fi

	cd ${S}

	if [[ -n ${BRANCH_UPDATE} ]] ; then
		epatch ${WORKDIR}/${PN}-${GLIBC_RELEASE_VER}-branch-update-${BRANCH_UPDATE}.patch

		# Snapshot date patch
		einfo "Patching version to display snapshot date ..."
		sed -i -e "s:\(#define RELEASE\).*:\1 \"${BRANCH_UPDATE}\":" version.h
	fi

	if [[ -n ${PATCH_VER} ]] ; then
		EPATCH_EXCLUDE="${GLIBC_PATCH_EXCLUDE}"
		EPATCH_SUFFIX="patch"
		OLD_ARCH="${ARCH}"
		ARCH="$(tc-arch)"

		einfo "Applying Gentoo Glibc Patches: ${PATCH_GLIBC_VER:-${GLIBC_RELEASE_VER}}-${PATCH_VER}"
		epatch ${WORKDIR}/patches

		ARCH="${OLD_ARCH}"
		unset EPATCH_EXCLUDE
		unset EPATCH_SUFFIX
		unset OLD_ARCH
	fi
}

toolchain-glibc_src_compile() {
	# Set gconvdir to /usr/$(get_libdir)/gconv on archs with multiple ABIs
	has_multilib_profile && MAKEFLAGS="gconvdir=$(alt_usrlibdir)/gconv"

	if want_linuxthreads ; then
		glibc_do_configure linuxthreads
		einfo "Building GLIBC with linuxthreads..."
		make PARALLELMFLAGS="${MAKEOPTS}" ${MAKEFLAGS} || die
	fi
	if want_nptl ; then
		# ... and then do the optional nptl build
		unset LD_ASSUME_KERNEL || :
		glibc_do_configure nptl
		einfo "Building GLIBC with NPTL..."
		make PARALLELMFLAGS="${MAKEOPTS}" ${MAKEFLAGS} || die
	fi
}

toolchain-glibc_src_test() {
	# This is wrong, but glibc's tests fail bad when screwing
	# around with sandbox, so lets just punt it
	unset LD_PRELOAD

	# do the linuxthreads build unless we're using nptlonly
	if want_linuxthreads ; then
		cd ${WORKDIR}/build-${ABI}-${CTARGET}-linuxthreads
		einfo "Checking GLIBC with linuxthreads..."
		make check || die "linuxthreads glibc did not pass make check"
	fi
	if want_nptl ; then
		cd ${WORKDIR}/build-${ABI}-${CTARGET}-nptl
		unset LD_ASSUME_KERNEL || :
		einfo "Checking GLIBC with NPTL..."
		make check || die "nptl glibc did not pass make check"
	fi
}

toolchain-glibc_pkg_preinst() {
	# PPC64+others may want to eventually be added to this logic if they
	# decide to be multilib compatible and FHS compliant. note that this
	# chunk of FHS compliance only applies to 64bit archs where 32bit
	# compatibility is a major concern (not IA64, for example).

	# amd64's 2005.0 is the first amd64 profile to not need this code.
	# 2005.0 is setup properly, and this is executed as part of the
	# 2004.3 -> 2005.0 upgrade script.
	# It can be removed after 2004.3 has been purged from portage.
	use amd64 && [ "$(get_libdir)" == "lib64" ] && ! has_multilib_profile && fix_lib64_symlinks

	# it appears that /lib/tls is sometimes not removed. See bug
	# 69258 for more info.
	if [[ -d ${ROOT}$(alt_libdir)/tls ]] && ! { want_nptl && want_linuxthreads; }; then
		addwrite "${ROOT}"/$(alt_libdir)/
		ewarn "nptlonly or -nptl in USE, removing /${ROOT}$(alt_libdir)/tls..."
		rm -r "${ROOT}"/$(alt_libdir)/tls || die
	fi

	# Shouldnt need to keep this updated
	[[ -e ${ROOT}/etc/locales.build ]] && rm -f "${D}"/etc/locales.build
}

toolchain-glibc_src_install() {
	setup_flags

	# Need to dodir first because it might not exist (bad amd64 profiles)
	dodir $(alt_usrlibdir)

	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL

	if want_linuxthreads ; then
		cd ${WORKDIR}/build-${ABI}-${CTARGET}-linuxthreads
		einfo "Installing GLIBC with linuxthreads..."
		make PARALLELMFLAGS="${MAKEOPTS} -j1" \
			install_root=${D} \
			install || die
	else # nptlonly
		cd ${WORKDIR}/build-${ABI}-${CTARGET}-nptl
		einfo "Installing GLIBC with NPTL..."
		make PARALLELMFLAGS="${MAKEOPTS} -j1" \
			install_root=${D} \
			install || die
	fi

	if is_crosscompile ; then
		# Glibc doesn't setup multilib crosscompiled dirs right, but it
		# sets up native multilib dirs right, so just do this when we
		# crosscompile.
		if [[ $(get_libdir) != "lib" && -d ${D}$(alt_prefix)/lib ]] ; then
			dodir $(alt_libdir)
			mv ${D}$(alt_prefix)/lib/* ${D}$(alt_libdir)
		fi

		# punt all the junk not needed by a cross-compiler
		rm -rf "${D}"$(alt_prefix)/{bin,etc,$(get_libdir)/gconv,sbin,share}
	fi

	if want_linuxthreads && want_nptl ; then
		einfo "Installing NPTL to $(alt_libdir)/tls/..."
		cd ${WORKDIR}/build-${ABI}-${CTARGET}-nptl
		mkdir -p ${D}$(alt_libdir)/tls/

		libcsofile=$(basename ${D}$(alt_libdir)/libc-*.so)
		cp -a libc.so ${D}$(alt_libdir)/tls/${libcsofile} || die
		dosym ${libcsofile} $(alt_libdir)/tls/$(ls libc.so.*)

		libmsofile=$(basename ${D}$(alt_libdir)/libm-*.so)
		pushd math > /dev/null
		cp -a libm.so ${D}$(alt_libdir)/tls/${libmsofile} || die
		dosym ${libmsofile} $(alt_libdir)/tls/$(ls libm.so.*)
		popd > /dev/null

		librtsofile=$(basename ${D}$(alt_libdir)/librt-*.so)
		pushd rt > /dev/null
		cp -a librt.so ${D}$(alt_libdir)/tls/${librtsofile} || die
		dosym ${librtsofile} $(alt_libdir)/tls/$(ls librt.so.*)
		popd > /dev/null

		libthreaddbsofile=$(basename ${D}$(alt_libdir)/libthread_db-*.so)
		pushd nptl_db > /dev/null
		cp -a libthread_db.so ${D}$(alt_libdir)/tls/${libthreaddbsofile} || die
		dosym ${libthreaddbsofile} $(alt_libdir)/tls/$(ls libthread_db.so.*)
		popd > /dev/null

		libpthreadsofile=libpthread-${GLIBC_RELEASE_VER}.so
		cp -a nptl/libpthread.so ${D}$(alt_libdir)/tls/${libpthreadsofile} || die
		dosym ${libpthreadsofile} $(alt_libdir)/tls/libpthread.so.0

		# and now for the static libs
		mkdir -p ${D}$(alt_usrlibdir)/nptl
		cp -a libc.a nptl/libpthread.a nptl/libpthread_nonshared.a rt/librt.a \
			${D}$(alt_usrlibdir)/nptl

		# linker script crap
		for lib in libc libpthread; do
			sed -e "s:$(alt_libdir)/${lib}.so:$(alt_libdir)/tls/${lib}.so:g" \
			    -e "s:$(alt_usrlibdir)/${lib}_nonshared.a:$(alt_usrlibdir)/nptl/${lib}_nonshared.a:g" \
			          ${D}$(alt_usrlibdir)/${lib}.so \
				> ${D}$(alt_usrlibdir)/nptl/${lib}.so

			chmod 755 ${D}$(alt_usrlibdir)/nptl/${lib}.so
		done

		dosym ../librt.so $(alt_usrlibdir)/nptl/librt.so

		# last but not least... headers.
		mkdir -p ${D}/nptl ${D}$(alt_headers)/nptl
		make install_root=${D}/nptl install-headers PARALLELMFLAGS="${MAKEOPTS} -j1"
		pushd ${D}/nptl/$(alt_headers) > /dev/null
		for i in `find . -type f`; do
			if ! [ -f ${D}$(alt_headers)/$i ] \
			   || ! cmp -s $i ${D}$(alt_headers)/$i; then
				mkdir -p ${D}$(alt_headers)/nptl/`dirname $i`
				cp -a $i ${D}$(alt_headers)/nptl/$i
			fi
		done
		popd > /dev/null
		rm -rf ${D}/nptl
	fi

	# Now, strip everything but the thread libs #46186, as well as the dynamic
	# linker, else we cannot set breakpoints in shared libraries.
	# Fix for ld-* by Lonnie Princehouse.
	mkdir -p ${T}/thread-backup
	for x in ${D}$(alt_libdir)/lib{pthread,thread_db}* \
	         ${D}$(alt_libdir)/ld-* ; do
		[[ -f ${x} ]] && mv -f ${x} ${T}/thread-backup/
	done
	if want_linuxthreads && want_nptl ; then
		mkdir -p ${T}/thread-backup/tls
		for x in ${D}$(alt_libdir)/tls/lib{pthread,thread_db}* ; do
			[[ -f ${x} ]] && mv -f ${x} ${T}/thread-backup/tls
		done
	fi
	env -uRESTRICT CHOST=${CTARGET} prepallstrip
	cp -a -- ${T}/thread-backup/* ${D}$(alt_libdir)/ || die

	if use pic && [[ $(tc-arch) != "amd64" ]] ; then
		find ${S}/${buildtarget}/ -name "soinit.os" -exec cp {} ${D}$(alt_libdir)/soinit.o \;
		find ${S}/${buildtarget}/ -name "sofini.os" -exec cp {} ${D}$(alt_libdir)/sofini.o \;
		find ${S}/${buildtarget}/ -name "*_pic.a" -exec cp {} ${D}$(alt_libdir) \;
		find ${S}/${buildtarget}/ -name "*.map" -exec cp {} ${D}$(alt_libdir) \;

		for i in ${D}$(alt_libdir)/*.map; do
			mv ${i} ${i%.map}_pic.map
		done
	fi

	# We'll take care of the cache ourselves
	rm -f ${D}/etc/ld.so.cache

	# Some things want this, notably ash.
	dosym libbsd-compat.a $(alt_usrlibdir)/libbsd.a

	# Handle includes for different ABIs
	prep_ml_includes $(alt_headers)

	#################################################################
	# EVERYTHING AFTER THIS POINT IS FOR NATIVE GLIBC INSTALLS ONLY #
	# Make sure we install the sys-include symlink so that when 
	# we build a 2nd stage cross-compiler, gcc finds the target 
	# system headers correctly.  See gcc/doc/gccinstall.info
	if is_crosscompile ; then
		dosym include $(alt_prefix)/sys-include
		return 0
	fi

	# Everything past this point just needs to be done once... don't waste time building locale files twice...
	is_final_abi || return 0

	if want_linuxthreads ; then
		MYMAINBUILDDIR=build-${ABI}-${CTARGET}-linuxthreads
	else
		MYMAINBUILDDIR=build-${ABI}-${CTARGET}-nptl
	fi
	cd ${WORKDIR}/${MYMAINBUILDDIR}
	if ! use build ; then
		if ! has noinfo ${FEATURES} && [[ ${GLIBC_INFOPAGE_VERSION} != "none" ]] ; then
			einfo "Installing info pages..."

			make PARALLELMFLAGS="${MAKEOPTS} -j1" \
				install_root=${D} \
				info -i
		fi

		setup_locales

		if [[ ${GLIBC_MANPAGE_VERSION} != "none" ]] ; then
			einfo "Installing man pages..."

			# Install linuxthreads man pages even if nptl is enabled
			cd ${WORKDIR}/man
			doman *.3thr
		fi

		# Install nscd config file
		insinto /etc
		doins ${FILESDIR}/nscd.conf
		doins "${FILESDIR}"/nsswitch.conf

		exeinto /etc/init.d
		doexe ${FILESDIR}/nscd

		cd ${S}
		dodoc BUGS ChangeLog* CONFORMANCE FAQ INTERFACE NEWS NOTES PROJECTS README*
	else
		rm -rf ${D}/usr/share
		for dir in $(get_all_libdirs); do
			rm -rf ${D}/usr/${dir}/gconv &> /dev/null
		done

		einfo "Installing Timezone data..."
		make PARALLELMFLAGS="${MAKEOPTS} -j1" \
			install_root=${D} \
			timezone/install-others || die
	fi

	# Is this next line actually needed or does the makefile get it right?
	# It previously has 0755 perms which was killing things.
	fperms 4711 $(alt_prefix)/lib/misc/glibc/pt_chown

	# Prevent overwriting of the /etc/localtime symlink.  We'll handle the
	# creation of the "factory" symlink in pkg_postinst().
	rm -f ${D}/etc/localtime

	insinto /etc
	# This is our new config file for building locales
	doins ${FILESDIR}/locales.build
	# example host.conf with multicast dns disabled by default
	doins ${FILESDIR}/2.3.4/host.conf

	# simple test to make sure our new glibc isnt completely broken.
	# for now, skip the multilib scenario.  also make sure we don't
	# test with statically built binaries since they will fail.
	[[ ${CBUILD} != ${CHOST} ]] && return 0
	[[ $(get_libdir) != "lib" ]] && return 0
	for x in date env ls true uname ; do
		x=$(type -p ${x})
		[[ -z ${x} ]] && continue
		striptest=$(file -L ${x} 2>/dev/null)
		[[ -z ${striptest} ]] && continue
		[[ ${striptest/statically linked} != "${striptest}" ]] && continue
		"${D}"/$(get_libdir)/ld-*.so \
			--library-path "${D}"/$(get_libdir) \
			${x} > /dev/null \
			|| die "simple run test (${x}) failed"
	done
}

toolchain-glibc_pkg_postinst() {
	# Mixing nptlonly and -nptlonly glibc can prove dangerous if libpthread
	# isn't removed in unmerge which happens sometimes.  See bug #87671
	if ! is_crosscompile && want_linuxthreads ; then
		for libdir in $(get_all_libdirs) ; do
			for f in ${ROOT}/${libdir}/libpthread-2.* ${ROOT}/${libdir}/libpthread-0.6* ; do
				if [[ -f ${f} ]] ; then
					rm -f ${f}
					ldconfig
				fi
			done
		done
	fi

	# Correct me if I am wrong here, but my /etc/localtime is a file
	# created by zic ....
	# I am thinking that it should only be recreated if no /etc/localtime
	# exists, or if it is an invalid symlink.
	#
	# For invalid symlink:
	#   -f && -e  will fail
	#   -L will succeed
	#
	if [ ! -e "${ROOT}/etc/localtime" ] ; then
		echo "Please remember to set your timezone using the zic command."
		rm -f ${ROOT}/etc/localtime
		ln -s ../usr/share/zoneinfo/Factory ${ROOT}/etc/localtime
	fi

	if ! is_crosscompile && [ -x "${ROOT}/usr/sbin/iconvconfig" ] ; then
		# Generate fastloading iconv module configuration file.
		${ROOT}/usr/sbin/iconvconfig --prefix=${ROOT}
	fi

	if [ ! -e "${ROOT}/lib/ld.so.1" ] && use ppc64 && ! has_multilib_profile ; then
		## SHOULDN'T THIS BE lib64??
		ln -s ld64.so.1 ${ROOT}/lib/ld.so.1
	fi

	# Reload init ...
	if ! is_crosscompile && [ "${ROOT}" = "/" ] ; then
		/sbin/init U &> /dev/null
	fi

	# warn the few multicast-dns-by-default users we've had about the change
	# in behavior...
	echo
	einfo "Gentoo's glibc now disables multicast dns by default in our"
	einfo "example host.conf. To re-enable this functionality, simply"
	einfo "remove the line that disables it (mdns off)."
	echo

	if want_nptl && want_linuxthreads ; then
		einfo "The default behavior of glibc on your system is to use NPTL.  If"
		einfo "you want to use linuxthreads for a particular program, start it"
		einfo "by executing 'LD_ASSUME_KERNEL=${LT_KERNEL_VERSION} <program> [<options>]'"
		echo
	fi
}

### SUPPORT FUNCTIONS ###
# We need to be able to set alternative headers for
# compiling for non-native platform
# Will also become useful for testing kernel-headers without screwing up
# the whole system.
# note: intentionally undocumented.
alt_headers() {
	if [[ -z ${ALT_HEADERS} ]] ; then
		if is_crosscompile ; then
			ALT_HEADERS="/usr/${CTARGET}/include"
		else
			ALT_HEADERS="/usr/include"
		fi
	fi
	echo "${ALT_HEADERS}"
}

alt_prefix() {
	if is_crosscompile ; then
		echo /usr/${CTARGET}
	else
		echo /usr
	fi
}

alt_libdir() {
	if is_crosscompile ; then
		echo /usr/${CTARGET}/lib
	else
		echo /$(get_libdir)
	fi
}

alt_usrlibdir() {
	if is_crosscompile ; then
		echo /usr/${CTARGET}/lib
	else
		echo /usr/$(get_libdir)
	fi
}

setup_flags() {
	# If the user wants to use -fomit-frame-pointer, let the build system
	# determine when it's safe
	is-flag -fomit-frame-pointer && EXTRA_ECONF="--enable-omitfp ${EXTRA_ECONF}"

	# Over-zealous CFLAGS can often cause problems.  What may work for one
	# person may not work for another.  To avoid a large influx of bugs
	# relating to failed builds, we strip most CFLAGS out to ensure as few
	# problems as possible.
	strip-flags
	strip-unsupported-flags
	filter-flags -m32 -m64 -mabi=*

	has_multilib_profile && CTARGET_OPT="$(get_abi_CHOST)"

	case $(tc-arch) in
		ppc)
			append-flags "-freorder-blocks"
		;;
		sparc)
			# Both sparc and sparc64 can use -fcall-used-g6.  -g7 is bad, though.
			filter-flags "-fcall-used-g7"
			append-flags "-fcall-used-g6"
			filter-flags "-mvis"

			if is_crosscompile || [[ ${PROFILE_ARCH} == "sparc64" ]] || { has_multilib_profile && ! tc-is-cross-compiler; } ; then
				case ${ABI} in
					default|sparc32)
						if is-flag "-mcpu=ultrasparc3"; then
							CTARGET_OPT="sparcv9b-unknown-linux-gnu"
						else
							CTARGET_OPT="sparcv9-unknown-linux-gnu"
						fi
					;;
					sparc64)
						if is-flag "-mcpu=ultrasparc3"; then
							CTARGET_OPT="sparc64b-unknown-linux-gnu"
							CFLAGS_sparc64="$(get_abi_CFLAGS) -Wa,-xarch=v9b"
						else
							CTARGET_OPT="sparc64-unknown-linux-gnu"
							CFLAGS_sparc64="$(get_abi_CFLAGS) -Wa,-xarch=v9a"
						fi

						filter-flags -Wa,-xarch -Wa,-A
					;;
				esac
			else
				if is-flag "-mcpu=ultrasparc3"; then
					CTARGET_OPT="sparcv9b-unknown-linux-gnu"
				elif { is_crosscompile && want_nptl; } || is-flag "-mcpu=ultrasparc2" || is-flag "-mcpu=ultrasparc"; then
					CTARGET_OPT="sparcv9-unknown-linux-gnu"
				fi
			fi
		;;
	esac

	if [[ -n ${CTARGET_OPT} && ${CBUILD} == ${CHOST} ]] && ! is_crosscompile; then
		CBUILD_OPT=${CTARGET_OPT}
	fi

	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ] ; then
		# broken in 3.4.x
		replace-flags -march=pentium-m -mtune=pentium3
	fi

	if $(tc-getCC ${CTARGET}) -v 2>&1 | grep -q 'gcc version 3.[0123]'; then
		append-flags -finline-limit=2000
	fi

	# We don't want these flags for glibc
	filter-ldflags -pie

	# Lock glibc at -O2 -- linuxthreads needs it and we want to be
	# conservative here
	append-flags -O2
}

check_kheader_version() {
	local header="${ROOT}$(alt_headers)/linux/version.h"

	[[ -z $1 ]] && return 1

	if [ -f "${header}" ] ; then
		local version="`grep 'LINUX_VERSION_CODE' ${header} | \
			sed -e 's:^.*LINUX_VERSION_CODE[[:space:]]*::'`"

		if [ "${version}" -ge "$1" ] ; then
			return 0
		fi
	fi

	return 1
}

check_nptl_support() {
	local min_kernel_version="$(KV_to_int "${NPTL_KERNEL_VERSION}")"

	echo

	einfon "Checking gcc for __thread support ... "
	if ! $(tc-getCC ${CTARGET}) -c ${FILESDIR}/test-__thread.c -o ${T}/test2.o &> /dev/null; then
		echo "no"
		echo
		eerror "Could not find a gcc that supports the __thread directive!"
		eerror "please update to gcc-3.2.2-r1 or later, and try again."
		die "No __thread support in gcc!"
	else
		echo "yes"
	fi

	# Building fails on an non-supporting kernel
	einfon "Checking kernel version (>=${NPTL_KERNEL_VERSION}) ... "
	if [ "`get_KV`" -lt "${min_kernel_version}" ] ; then
		echo "no"
		echo
		eerror "You need a kernel of at least version ${NPTL_KERNEL_VERSION}"
		eerror "for NPTL support!"
		die "Kernel version too low!"
	else
		echo "yes"
	fi

	# Building fails with too low linux-headers
	einfon "Checking linux-headers version (>=${NPTL_KERNEL_VERSION}) ... "
	if ! check_kheader_version "${min_kernel_version}"; then
		echo "no"
		echo
		eerror "You need linux-headers of at least version ${NPTL_KERNEL_VERSION}"
		eerror "for NPTL support!"
		die "linux-headers version too low!"
	else
		echo "yes"
	fi

	echo
}

want_nptl() {
	want_tls || return 1
	use nptl || return 1

	# Archs that can use NPTL
	case $(tc-arch) in
		amd64|ia64|ppc|ppc64|s390|x86)
			return 0;
		;;
		sparc)
			# >= v9 is needed for nptl.
			[[ "${PROFILE_ARCH}" == "sparc" ]] && return 1
			return 0;
		;;
	esac

	return 1
}

want_linuxthreads() {
	! use nptlonly && return 0
	want_nptl || return 0
	return 1
}

want_tls() {
	# Archs that can use TLS (Thread Local Storage)
	case $(tc-arch) in
		alpha|amd64|ia64|ppc|ppc64|s390)
			return 0;
		;;
		sparc)
			case ${CTARGET/-*} in
				sparc64*)
					[[ ${ABI} == "sparc32" ]] && return 0
					return 1
				;;
				*)
					return 0
				;;
			esac
		;;
		x86)
			case ${CTARGET/-*} in
				i486|i586|i686)	return 0 ;;
			esac
		;;
	esac

	return 1
}

install_locales() {
	unset LANGUAGE LANG LC_ALL
	cd ${WORKDIR}/${MYMAINBUILDDIR} || die "${WORKDIR}/${MYMAINBUILDDIR}"
	make PARALLELMFLAGS="${MAKEOPTS} -j1" \
		install_root=${D} localedata/install-locales || die
}

setup_locales() {
	if use !userlocales ; then
		einfo "userlocales not enabled, installing -ALL- locales..."
		install_locales || die
	elif [ -e /etc/locales.build ] ; then
		einfo "Installing locales in /etc/locales.build..."
		echo 'SUPPORTED-LOCALES=\' > SUPPORTED.locales
		cat /etc/locales.build | grep -v -e ^$ -e ^\# | sed 's/$/\ \\/g' \
			>> SUPPORTED.locales
		cat SUPPORTED.locales > ${S}/localedata/SUPPORTED || die
		install_locales || die
	elif [ -e ${FILESDIR}/locales.build ] ; then
		einfo "Installing locales in ${FILESDIR}/locales.build..."
		echo 'SUPPORTED-LOCALES=\' > SUPPORTED.locales
		cat ${FILESDIR}/locales.build | grep -v -e ^$ -e ^\# | sed 's/$/\ \\/g' \
			>> SUPPORTED.locales
		cat SUPPORTED.locales > ${S}/localedata/SUPPORTED || die
		install_locales || die
	else
		einfo "Installing -ALL- locales..."
		install_locales || die
	fi
}

glibc_do_configure() {
	local myconf

	setup_flags

	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL
	# silly users
	unset LD_RUN_PATH

	# set addons
	pushd ${S} > /dev/null
	ADDONS=$(echo */configure | sed -e 's!/configure!!g;s!\(linuxthreads\|nptl\|rtkaio\|glibc-compat\)\( \|$\)!!g;s! \+$!!;s! !,!g;s!^!,!;/^,\*$/d')
	popd > /dev/null

	use nls || myconf="${myconf} --disable-nls"
	use erandom || myconf="${myconf} --disable-dev-erandom"

	if [ "$1" == "linuxthreads" ] ; then
		want_tls && myconf="${myconf} --with-tls --without-__thread"
		want_tls || myconf="${myconf} --without-tls --without-__thread"
		myconf="${myconf} --enable-add-ons=linuxthreads${ADDONS}"
		myconf="${myconf} --enable-kernel=${LT_KERNEL_VERSION}"
	elif [ "$1" == "nptl" ] ; then
		want_nptl && myconf="${myconf} --with-tls --with-__thread"
		myconf="${myconf} --enable-add-ons=nptl${ADDONS}"
		myconf="${myconf} --enable-kernel=${NPTL_KERNEL_VERSION}"
	else
		die "invalid pthread option"
	fi

	if ! use build && use selinux ; then
		myconf="${myconf} --with-selinux"
	else
		myconf="${myconf} --without-selinux"
	fi

	myconf="${myconf}
		--without-cvs
		--enable-bind-now
		--build=${CBUILD_OPT:-${CBUILD}}
		--host=${CTARGET_OPT:-${CTARGET}}
		--disable-profile
		--without-gd
		--with-headers=$(alt_headers)
		--prefix=$(alt_prefix)
		--mandir=$(alt_prefix)/share/man
		--infodir=$(alt_prefix)/share/info
		--libexecdir=$(alt_prefix)/lib/misc/glibc
		${EXTRA_ECONF}"

	export CC="$(tc-getCC ${CTARGET})"

	GBUILDDIR="${WORKDIR}/build-${ABI}-${CTARGET}-$1"
	mkdir -p ${GBUILDDIR}
	cd ${GBUILDDIR}
	einfo "Configuring GLIBC for $1 with: ${myconf}"
	${S}/configure ${myconf} || die "failed to configure glibc"
}

fix_lib64_symlinks() {
	# the original Gentoo/AMD64 devs decided that since 64bit is the native
	# bitdepth for AMD64, lib should be used for 64bit libraries. however,
	# this ignores the FHS and breaks multilib horribly... especially
	# since it wont even work without a lib64 symlink anyways. *rolls eyes*
	# see bug 59710 for more information.
	# Travis Tilley <lv@gentoo.org> (08 Aug 2004)
	if [ -L ${ROOT}/lib64 ] ; then
		ewarn "removing /lib64 symlink and moving lib to lib64..."
		ewarn "dont hit ctrl-c until this is done"
		addwrite ${ROOT}/
		rm ${ROOT}/lib64
		# now that lib64 is gone, nothing will run without calling ld.so
		# directly. luckily the window of brokenness is almost non-existant
		/lib/ld-linux-x86-64.so.2 /bin/mv ${ROOT}/lib ${ROOT}/lib64
		# all better :)
		ldconfig
		ln -s lib64 ${ROOT}/lib
		einfo "done! :-)"
		einfo "fixed broken lib64/lib symlink in ${ROOT}"
	fi
	if [ -L ${ROOT}/usr/lib64 ] ; then
		addwrite ${ROOT}/usr
		rm ${ROOT}/usr/lib64
		mv ${ROOT}/usr/lib ${ROOT}/usr/lib64
		ln -s lib64 ${ROOT}/usr/lib
		einfo "fixed broken lib64/lib symlink in ${ROOT}/usr"
	fi
	if [ -L ${ROOT}/usr/X11R6/lib64 ] ; then
		addwrite ${ROOT}/usr/X11R6
		rm ${ROOT}/usr/X11R6/lib64
		mv ${ROOT}/usr/X11R6/lib ${ROOT}/usr/X11R6/lib64
		ln -s lib64 ${ROOT}/usr/X11R6/lib
		einfo "fixed broken lib64/lib symlink in ${ROOT}/usr/X11R6"
	fi
}

use_multilib() {
	case $(tc-arch) in
		sparc)
			case ${CHOST} in
				sparc64*)
					is_crosscompile || has_multilib_profile || use multilib
					;;
				*)
					false
					;;
			esac
		;;
		mips)
			case ${CHOST} in
				mips64*)
					is_crosscompile || has_multilib_profile || use multilib
					;;
				*)
					false
					;;
			esac
		;;
		amd64|ppc64)
			is_crosscompile || has_multilib_profile || use multilib
		;;
		*)
			false
		;;
	esac
}

# Setup toolchain variables that would be defined in the profiles for these archs.
crosscompile_setup() {
	if is_crosscompile || tc-is-cross-compiler; then
		# CFLAGS are used by ${CTARGET}-gcc
		local VAR="CFLAGS_"${CTARGET//-/_}
		CFLAGS=${!VAR-"-O2"}

		case ${CTARGET} in
			x86_64*)
				export CFLAGS_x86="${CFLAGS_x86--m32}"
				export CHOST_x86="i686-pc-linux-gnu"
				export CDEFINE_x86="__i386__"
				export LIBDIR_x86="lib"

				export CFLAGS_amd64="${CFLAGS_amd64--m64}"
				export CHOST_amd64="x86_64-pc-linux-gnu"
				export CDEFINE_amd64="__x86_64__"
				export LIBDIR_amd64="lib64"

				export MULTILIB_ABIS="amd64"
				export DEFAULT_ABI="amd64"
			;;
			mips64*)
				export CFLAGS_o32="${CFLAGS_o32--mabi=32}"
				export CHOST_o32="mips-unknown-linux-gnu"
				export CDEFINE_o32="_ABIO32"
				export LIBDIR_o32="lib"

				export CFLAGS_n32="${CFLAGS_n32--mabi=n32}"
				export CHOST_n32="mips64-unknown-linux-gnu"
				export CDEFINE_n32="_ABIN32"
				export LIBDIR_n32="lib32"

				export CFLAGS_n64="${CFLAGS_n64--mabi=64}"
				export CHOST_n64="mips64-unknown-linux-gnu"
				export CDEFINE_n64="_ABI64"
				export LIBDIR_n64="lib64"

				export MULTILIB_ABIS="n64 n32"
				export DEFAULT_ABI="n32"
			;;
			powerpc64*)
				export CFLAGS_ppc="${CFLAGS_ppc--m32}"
				export CHOST_ppc="powerpc-unknown-linux-gnu"
				export CDEFINE_ppc="__powerpc__"
				export LIBDIR_ppc="lib"

				export CFLAGS_ppc64="${CFLAGS_ppc64--m64}"
				export CHOST_ppc64="powerpc64-unknown-linux-gnu"
				export CDEFINE_ppc64="__powerpc64__"
				export LIBDIR_ppc64="lib64"

				export MULTILIB_ABIS="ppc64"
				export DEFAULT_ABI="ppc64"
			;;
			sparc64*)
				export CFLAGS_sparc32="${CFLAGS_sparc--m32}"
				export CHOST_sparc32="sparc-unknown-linux-gnu"
				export CDEFINE_sparc32="!__arch64__"
				export LIBDIR_sparc32="lib"

				export CFLAGS_sparc64="${CFLAGS_sparc64--m64}"
				export CHOST_sparc64="sparc64-unknown-linux-gnu"
				export CDEFINE_sparc64="__arch64__"
				export LIBDIR_sparc64="lib64"

				export MULTILIB_ABIS="sparc64"
				export DEFAULT_ABI="sparc64"
			;;
			*)
				export MULTILIB_ABIS="default"
				export DEFAULT_ABI="default"
		esac

		ABI=${DEFAULT_ABI}
	fi
}

### /ECLASS PUNTAGE ###

if is_crosscompile ; then
	SLOT="${CTARGET}-2.2"
else
	SLOT="2.2"
fi

# we'll handle stripping ourself #46186
RESTRICT="nostrip multilib-pkg-force"

# We need new cleanup attribute support from gcc for NPTL among things ...
# We also need linux26-headers if using NPTL. Including kernel headers is
# incredibly unreliable, and this new linux-headers release from plasmaroo
# should work with userspace apps, at least on amd64 and ppc64.
#
# The gcc-config dep is for the cross-compile multilib stuff
DEPEND=">=sys-devel/gcc-3.2.3-r1
	nptl? ( >=sys-devel/gcc-3.3.1-r1 >=sys-kernel/linux-headers-2.6.5 )
	>=sys-devel/binutils-2.14.90.0.6-r1
	>=sys-devel/gcc-config-1.3.9
	virtual/os-headers
	nls? ( sys-devel/gettext )
	selinux? ( !build? ( sys-libs/libselinux ) )"
RDEPEND="virtual/os-headers
	nls? ( sys-devel/gettext )
	selinux? ( !build? ( sys-libs/libselinux ) )"

if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
	DEPEND="${DEPEND} ${CATEGORY}/gcc"

	if [[ ${CATEGORY} == *-linux* ]] ; then
		if [[ ${CATEGORY/mips} != ${CATEGORY} ]] ; then
			DEPEND="${DEPEND} >=${CATEGORY}/mips-headers-2.6.10"
		else
			DEPEND="${DEPEND} ${CATEGORY}/linux-headers"
		fi
	fi

	case ${CTARGET} in
		x86_64-pc-linux-gnu)
			[[ ${CHOST/-*/} == "i686" ]] || RDEPEND="${RDEPEND} cross-i686-pc-linux-gnu/${PN}"
		;;
		sparc64-unknown-linux-gnu)
			[[ ${CHOST/-*/} == "sparc" ]] || RDEPEND="${RDEPEND} cross-sparc-unknown-linux-gnu/${PN}"
		;;
		powerpc64-unknown-linux-gnu)
			[[ ${CHOST/-*/} == "powerpc" ]] || RDEPEND="${RDEPEND} cross-powerpc-unknown-linux-gnu/${PN}"
		;;
		mips64-unknown-linux-gnu)
			[[ ${CHOST/-*/} == "mips" ]] || RDEPEND="${RDEPEND} cross-mips-unknown-linux-gnu/${PN}"
		;;
	esac
fi

# until amd64's 2004.3 is purged out of existence
PDEPEND="amd64? ( multilib? ( ~app-emulation/emul-linux-x86-glibc-2.3.4.20041102 ) )"

pkg_setup() {
	if use nptlonly && ! use nptl ; then
		eerror "If you want nptlonly, add nptl to your USE too ;p"
		die "nptlonly without nptl"
	fi

	# give some sort of warning about the nptl logic changes...
	if want_nptl && want_linuxthreads ; then
		ewarn "Warning! Gentoo's GLIBC with NPTL enabled now behaves like the"
		ewarn "glibc from almost every other distribution out there. This means"
		ewarn "that glibc is compiled -twice-, once with linuxthreads and once"
		ewarn "with nptl. The NPTL version is installed to lib/tls and is still"
		ewarn "used by default. If you do not need nor want the linuxthreads"
		ewarn "fallback, you can disable this behavior by adding nptlonly to"
		ewarn "USE to save yourself some compile time."

		ebeep
		epause 5
	fi
}

src_unpack() {
	crosscompile_setup
	export ABI="${DEFAULT_ABI}"

	case $(tc-arch) in
		hppa)
			GLIBC_PATCH_EXCLUDE="${GLIBC_PATCH_EXCLUDE} 2000-all-2.3.2-propolice-guard-functions-v3.patch"
			use hardened || GLIBC_PATCH_EXCLUDE="${GLIBC_PATCH_EXCLUDE} 6490_hppa_hardened-disable__init_arrays.patch"
		;;
		mips)
			GLIBC_PATCH_EXCLUDE="${GLIBC_PATCH_EXCLUDE} 3000-all-2.3.4-dl_execstack-PaX-support.patch"
			use_multilib && GLIBC_PATCH_EXCLUDE="${GLIBC_PATCH_EXCLUDE} 6680_mips_nolib3264.patch"
		;;
	esac

	use nomalloccheck || GLIBC_PATCH_EXCLUDE="${GLIBC_PATCH_EXCLUDE} 5020_all_nomalloccheck.patch"

	toolchain-glibc_src_unpack

	case $(tc-arch) in
		alpha)
			# Is this still needed?
			rm -f sysdeps/alpha/alphaev6/memcpy.S
		;;
		amd64)
			if ! has_multilib_profile && ! is_crosscompile; then
				# CONF_LIBDIR support
				epatch ${FILESDIR}/2.3.4/glibc-gentoo-libdir.patch
				sed -i -e "s:@GENTOO_LIBDIR@:$(get_libdir):g" ${S}/sysdeps/unix/sysv/linux/configure
			fi
		;;
		ppc64)
			# setup lib -- seems like a good place to set this up
			has_multilib_profile || get_libdir_override lib64
		;;
	esac

	# disable binutils -as-needed
	sed -e 's/^have-as-needed.*/have-as-needed = no/' -i ${S}/config.make.in

	# Glibc is stupid sometimes, and doesn't realize that with a
	# static C-Only gcc, -lgcc_eh doesn't exist.
	# http://sources.redhat.com/ml/libc-alpha/2003-09/msg00100.html
	# http://sourceware.org/ml/libc-alpha/2005-02/msg00042.html
	echo 'int main(){}' > ${T}/gcc_eh_test.c
	if ! $(tc-getCC ${CTARGET}) ${T}/gcc_eh_test.c -lgcc_eh 2>/dev/null ; then
		sed -i -e 's:-lgcc_eh::' Makeconfig || die "sed gcc_eh"
	fi

	# Some configure checks fail on the first emerge through because they
	# try to link.  This doesn't work well if we don't have a libc yet.
	# http://sourceware.org/ml/libc-alpha/2005-02/msg00042.html
	if is_crosscompile && use build; then
		rm ${S}/sysdeps/sparc/sparc64/elf/configure{,.in}
		rm ${S}/nptl/sysdeps/pthread/configure{,.in}
	fi

	find . -type f -size 0 -o -name "*.orig" -exec rm -f {} \;
	find . -name configure -exec touch {} \;

	# Fix permissions on some of the scripts
	chmod u+x ${S}/scripts/*.sh
}

src_compile() {
	crosscompile_setup

	# MULTILIB-CLEANUP: Fix this when FEATURES=multilib-pkg is in portage
	local MLTEST=$(type dyn_unpack)
	if has_multilib_profile && [ -z "${OABI}" -a "${MLTEST/set_abi}" = "${MLTEST}" ] ; then
		OABI="${ABI}"
		for ABI in $(get_install_abis); do
			export ABI
			einfo "Compiling ${ABI} glibc"
			src_compile
		done
		ABI="${OABI}"
		unset OABI
		return 0
	fi
	unset MLTEST

	ABI=${ABI:-default}
	toolchain-glibc_src_compile
}

src_test() {
	crosscompile_setup

	# MULTILIB-CLEANUP: Fix this when FEATURES=multilib-pkg is in portage
	local MLTEST=$(type dyn_unpack)
	if has_multilib_profile && [ -z "${OABI}" -a "${MLTEST/set_abi}" = "${MLTEST}" ] ; then
		OABI="${ABI}"
		for ABI in $(get_install_abis); do
			export ABI
			einfo "Testing ${ABI} glibc"
			src_test
		done
		ABI="${OABI}"
		unset OABI
		return 0
	fi
	unset MLTEST

	ABI=${ABI:-default}
	toolchain-glibc_src_test
}

src_install() {
	crosscompile_setup

	# MULTILIB-CLEANUP: Fix this when FEATURES=multilib-pkg is in portage
	local MLTEST=$(type dyn_unpack)
	if has_multilib_profile && [ -z "${OABI}" -a "${MLTEST/set_abi}" = "${MLTEST}" ] ; then
		OABI="${ABI}"
		for ABI in $(get_install_abis); do
			export ABI
			einfo "Installing ${ABI} glibc"
			src_install
		done
		ABI="${OABI}"
		unset OABI
		return 0
	fi
	unset MLTEST

	ABI=${ABI:-default}

	# Handle stupid lib32 BS
	unset OLD_LIBDIR
	if [[ $(tc-arch) == "amd64" && ${ABI} == "x86" && $(get_libdir) != "lib" ]] && ! is_crosscompile; then
		OLD_LIBDIR="$(get_libdir)"
		LIBDIR_x86="lib"
	fi

	toolchain-glibc_src_install

	# Handle stupid lib32 BS on amd64
	if [[ -n ${OLD_LIBDIR} ]] ; then
		cd ${S}
		LIBDIR_x86="${OLD_LIBDIR}"
		unset OLD_LIBDIR

		mv ${D}/lib ${D}/$(get_libdir)
		mv ${D}/usr/lib ${D}/usr/$(get_libdir)
		dodir /lib
		dodir /usr/lib
		mv ${D}/usr/$(get_libdir)/locale ${D}/usr/lib
		dosym ../$(get_libdir)/ld-linux.so.2 /lib/ld-linux.so.2

		for f in ${D}/usr/$(get_libdir)/*.so; do
			local basef=$(basename ${f})
			if [ -L ${f} ] ; then
				local target=$(readlink ${f})
				target=${target/\/lib\//\/$(get_libdir)\/}
				rm ${f}
				dosym ${target} /usr/$(get_libdir)/${basef}
			fi
		done

		dosed "s:/lib/:/$(get_libdir)/:g" /usr/$(get_libdir)/lib{c,pthread}.so

		if want_nptl && want_linuxthreads ; then
			dosed  "s:/lib/:/$(get_libdir)/:g" /usr/$(get_libdir)/nptl/lib{c,pthread}.so
		fi
	fi
}

pkg_preinst() {
	toolchain-glibc_pkg_preinst
}

pkg_postinst() {
	toolchain-glibc_pkg_postinst
}
