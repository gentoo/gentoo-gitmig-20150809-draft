# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/toolchain.eclass,v 1.8 2004/09/08 21:01:38 lv Exp $
#
# This eclass should contain general toolchain-related functions that are
# expected to not change, or change much.

inherit eutils
ECLASS=toolchain
INHERITED="$INHERITED $ECLASS"
DESCRIPTION="Based on the ${ECLASS} eclass"
EXPORT_FUNCTIONS src_unpack pkg_setup
IUSE="nls uclibc hardened nomultilib"

if [ "${ETYPE}" == "" ] ; then
	ETYPE="gcc"
fi

# BIG FAT WARNING!!!!! This eclass is still a work in progress!

# This function handles the basics of setting the SRC_URI for a gcc ebuild.
# To use, set SRC_URI with:
#
#	SRC_URI="$(get_gcc_src_uri)"
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
#	SNAPSHOT
#			If set, this variable signals that we should be using a snapshot
#			of gcc from ftp://sources.redhat.com/pub/gcc/snapshots/. It is
#			expected to be in the format "YYYY-MM-DD". Note that if the ebuild
#			has a _pre suffix, this variable is ignored and the prerelease
#			tarball is used instead.
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
#			This should be set to the version of the gentoo patch tarball.
#			The resulting filename of this tarball will be:
#			${P}-patches-${PATCH_VER}.tar.bz2
#
#	PIE_VER
#	PIE_CORE
#			These variables control patching in various updates for the logic
#			controlling Position Independant Executables. PIE_VER is expected
#			to be the version of this patch, and PIE_CORE the actual filename
#			of the patch. An example:
#					PIE_VER="8.7.6.5"
#					PIE_CORE="gcc-3.4.0-piepatches-v${PIE_VER}.tar.bz2"
#
#	PP_VER
#	PP_FVER
#			These variables control patching in stack smashing protection
#			support. They both control the version of ProPolice to download.
#			PP_VER sets the version of the directory in which to find the
#			patch, and PP_FVER sets the version of the patch itself. For
#			example:
#					PP_VER="3_4"
#					PP_FVER="${PP_VER//_/.}-2"
#			would download gcc3_4/protector-3.4-2.tar.gz
#
#	GCC_MANPAGE_VERSION
#			The version of gcc for which we will download manpages. This will
#			default to ${PV}, but we may not want to pre-generate man pages
#			for prerelease test ebuilds for example. This allows you to
#			continue using pre-generated manpages from the last stable release.
#			If set to "none", this will prevent the downloading of manpages,
#			which is useful for individual library targets.
#
# Travis Tilley <lv@gentoo.org> (02 Sep 2004)
#
get_gcc_src_uri() {
	# This variable should be set to the devspace of whoever is currently
	# maintaining GCC. Please dont set this to mirror, that would just
	# make the files unavailable until they get mirrored.
	local devspace_uri="http://dev.gentoo.org/~lv/toolchain-files/"
	GENTOO_TOOLCHAIN_BASE_URI=${GENTOO_TOOLCHAIN_BASE_URI:=${devspace_uri}}

	MAIN_BRANCH="${PV}"  # Tarball, etc used ...

	# Pre-release support
	if [ ${PV} != ${PV/_pre/-} ] ; then
		PRERELEASE=${PV/_pre/-}
	fi

	# Set where to download gcc itself depending on whether we're using a
	# prerelease, snapshot, or release tarball.
	if [ -n "${PRERELEASE}" ] ; then
		GCC_SRC_URI="ftp://gcc.gnu.org/pub/gcc/prerelease-${PRERELEASE}/gcc-${PRERELEASE}.tar.bz2"
	elif [ -n "${SNAPSHOT}" ] ; then
		GCC_SRC_URI="ftp://sources.redhat.com/pub/gcc/snapshots/${SNAPSHOT}/gcc-${SNAPSHOT//-}.tar.bz2"
	else
		GCC_SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/gcc-${MAIN_BRANCH}.tar.bz2"
		# we want all branch updates to be against the main release
		if [ -n "${BRANCH_UPDATE}" ] ; then
			GCC_SRC_URI="${GCC_SRC_URI}
				${GENTOO_TOOLCHAIN_BASE_URI}/${PN}-${MAIN_BRANCH}-branch-update-${BRANCH_UPDATE}.patch.bz2"
		fi
	fi

	# various gentoo patches
	if [ -n "${PATCH_VER}" ] ; then
		GCC_SRC_URI="${GCC_SRC_URI}
			${GENTOO_TOOLCHAIN_BASE_URI}/${P}-patches-${PATCH_VER}.tar.bz2"
	fi

	# propolice aka stack smashing protection
	if [ -n "${PP_VER}" ] ; then
	GCC_SRC_URI="${GCC_SRC_URI}
		http://www.research.ibm.com/trl/projects/security/ssp/gcc${PP_VER}/protector-${PP_FVER}.tar.gz"
	fi

	# PERL cannot be present at bootstrap, and is used to build the man pages.
	# So... lets include some pre-generated ones, shall we?
	GCC_MANPAGE_VERSION=${GCC_MANPAGE_VERSION:=${PV}}
	if [ "${GCC_MANPAGE_VERSION}" != "none" ] ; then
		GCC_SRC_URI="${GCC_SRC_URI}
			${GENTOO_TOOLCHAIN_BASE_URI}/gcc-${GCC_MANPAGE_VERSION}-manpages.tar.bz2"
	fi

	# mmm... PIE =D
	if [ -n "${PIE_CORE}" ] ; then
		GCC_SRC_URI="${GCC_SRC_URI}
			${GENTOO_TOOLCHAIN_BASE_URI}${PIE_CORE}"
	fi

	echo "${GCC_SRC_URI}"
}


# This function sets the source directory depending on whether we're using
# a prerelease, snapshot, or release tarball. To use it, just set S with:
#
#	S="$(gcc_get_s_dir)"
#
# Travis Tilley <lv@gentoo.org> (03 Sep 2004)
#
gcc_get_s_dir() {
	if [ -n "${PRERELEASE}" ] ; then
		GCC_S="${WORKDIR}/gcc-${PRERELEASE}"
	elif [ -n "${SNAPSHOT}" ] ; then
		GCC_S="${WORKDIR}/gcc-${SNAPSHOT//-}"
	else
		GCC_S="${WORKDIR}/gcc-${MAIN_BRANCH}"
	fi

	echo "${GCC_S}"
}


# gcc_quick_unpack will unpack the gcc tarball and patches in a way that is
# consistant with the behavior of get_gcc_src_uri. The only patch it applies
# itself is the branch update if present.
#
# Travis Tilley <lv@gentoo.org> (03 Sep 2004)
#
gcc_quick_unpack() {
	pushd ${WORKDIR}

	if [ -n "${PRERELEASE}" ] ; then
		unpack gcc-${PRERELEASE}.tar.bz2
	elif [ -n "${SNAPSHOT}" ] ; then
		unpack gcc-${SNAPSHOT//-}.tar.bz2
	else
		unpack gcc-${MAIN_BRANCH}.tar.bz2
		# We want branch updates to be against a release tarball
		if [ -n "${BRANCH_UPDATE}" ] ; then
			pushd ${S:="$(gcc_get_s_dir)"}
			epatch ${DISTDIR}/gcc-${MAIN_BRANCH}-branch-update-${BRANCH_UPDATE}.patch.bz2
			popd
		fi
	fi

	if [ -n "${PATCH_VER}" ]
	then
		unpack ${P}-patches-${PATCH_VER}.tar.bz2
	fi

	if [ -n "${PP_VER}" ]
	then
		unpack protector-${PP_FVER}.tar.gz
	fi

	if [ -n "${PIE_VER}" ]
	then
		unpack ${PIE_CORE}
	fi

	popd
}


# Exclude any unwanted patches, as specified by the following variables:
#
#	GENTOO_PATCH_EXCLUDE
#			List of filenames, relative to ${WORKDIR}/patch/
#
#	PIEPATCH_EXCLUDE
#			List of filenames, relative to ${WORKDIR}/piepatch/
#
# Travis Tilley <lv@gentoo.org> (03 Sep 2004)
#
exclude_gcc_patches() {
	local i
	for i in ${GENTOO_PATCH_EXCLUDE} ; do
		if [ -f ${WORKDIR}/patch/${i} ] ; then
			einfo "Excluding patch ${i}"
			rm -f ${WORKDIR}/patch/${i} || die "failed to delete ${i}"
		fi
	done
	for i in ${PIEPATCH_EXCLUDE} ; do
		if [ -f ${WORKDIR}/piepatch/${i} ] ; then
			einfo "Excluding piepatch ${i}"
			rm -f ${WORKDIR}/piepatch/${i} || die "failed to delete ${i}"
		fi
	done
}


# patch in ProPolice Stack Smashing protection
do_gcc_SSP_patches() {
	epatch ${WORKDIR}/protector.dif
	if [ "${PN}" == "gcc" ] ; then
		epatch ${FILESDIR}/pro-police-docs.patch
	fi

	local ppunpackdir
	if [ "${MY_PV}" == "3.3" ] ; then
		ppunpackdir="${WORKDIR}"
	else
		ppunpackdir="${WORKDIR}/gcc/"
	fi

	cp ${ppunpackdir}/protector.c ${S}/gcc/ || die "protector.c not found"
	cp ${ppunpackdir}/protector.h ${S}/gcc/ || die "protector.h not found"

	if [ "${MY_PV}" != "3.3" ] ; then
		# Etoh started including a testsuite with the gcc 3.4 release
		cp -R ${ppunpackdir}/testsuite/* ${S}/gcc/testsuite/ \
			|| die "testsuite not found"
	fi

	# we apply only the needed parts of protectonly.dif
	sed -e 's|^CRTSTUFF_CFLAGS = |CRTSTUFF_CFLAGS = -fno-stack-protector-all |' \
		-i gcc/Makefile.in || die "Failed to update crtstuff!"

	# if gcc in a stage3 defaults to ssp, is version 3.4.0 and a stage1 is built
	# the build fails building timevar.o w/:
	# cc1: stack smashing attack in function ix86_split_to_parts()
	if gcc -dumpspecs | grep -q "fno-stack-protector:" && [ "${MY_PV}" != "3.3" ]
	then
		use build && epatch ${FILESDIR}/3.4.0/gcc-3.4.0-cc1-no-stack-protector.patch
	fi

	release_version="${release_version}, ssp-${PP_FVER}"
	update_gcc_for_libc_ssp
}


# If glibc or uclibc has been patched to provide the necessary symbols itself,
# then lets use those for SSP instead of libgcc.
update_gcc_for_libc_ssp() {
	if libc_has_ssp ; then
		einfo "Updating gcc to use SSP from libc..."
		sed -e 's|^\(LIBGCC2_CFLAGS.*\)$|\1 -D_LIBC_PROVIDES_SSP_|' \
			-i ${S}/gcc/Makefile.in || die "Failed to update gcc!"
	fi
}


# do various updates to PIE logic
do_gcc_PIE_patches() {
	# corrects startfile/endfile selection and shared/static/pie flag usage
	epatch ${WORKDIR}/piepatch/upstream
	# adds non-default pie support (rs6000)
	epatch ${WORKDIR}/piepatch/nondef
	# adds default pie support (rs6000 too) if DEFAULT_PIE[_SSP] is defined
	epatch ${WORKDIR}/piepatch/def
	# disable relro/now
	use uclibc && epatch ${FILESDIR}/3.3.3/gcc-3.3.3-norelro.patch

	release_version="${release_version}, pie-${PIE_VER}"
}


# configure to build hardened GCC
make_gcc_hard() {
	einfo "Updating gcc to use automatic PIE + SSP building ..."
	sed -e 's|^ALL_CFLAGS = |ALL_CFLAGS = -DEFAULT_PIE_SSP |' \
		-i ${S}/gcc/Makefile.in || die "Failed to update gcc!"

	# rebrand to make bug reports easier
	release_version="${release_version/Gentoo/Gentoo Hardened}"
}


# This function allows us to gentoo-ize gcc's version number and bugzilla
# URL without needing to use patches.
#
# Travis Tilley <lv@gentoo.org> (02 Sep 2004)
#
gcc_version_patch() {
	[ -z "$1" ] && die "no arguments to gcc_version_patch"

	sed -i -e 's~\(const char version_string\[\] = "\S\+\s\+\)[^"]\+\(".*\)~\1@GENTOO@\2~' ${S}/gcc/version.c || die "failed to add @GENTOO@"
	sed -i -e "s:@GENTOO@:$1:g" ${S}/gcc/version.c || die "failed to patch version"
	sed -i -e 's~http:\/\/gcc\.gnu\.org\/bugs\.html~http:\/\/bugs\.gentoo\.org\/~' ${S}/gcc/version.c || die "failed to update bugzilla URL"
}


# The purpose of this DISGUSTING gcc multilib hack is to allow 64bit libs
# to live in lib instead of lib64 where they belong, with 32bit libraries
# in lib32. This hack has been around since the beginning of the amd64 port,
# and we're only now starting to fix everything that's broken. Eventually
# this should go away.
#
# Travis Tilley <lv@gentoo.org> (03 Sep 2004)
#
disgusting_gcc_multilib_HACK() {
	sed -i -e 's~^MULTILIB_OSDIRNAMES.*~MULTILIB_OSDIRNAMES = ../lib64 ../lib32~' ${S}/gcc/config/i386/t-linux64
}


# generic GCC src_unpack, to be called from the ebuild's src_unpack.
# BIG NOTE regarding hardened support: ebuilds with support for hardened are
# expected to export the following variable:
#
#	HARDENED_GCC_WORKS
#			If set, then it is assumed that hardened gcc works for this
#			release and version. If empty, the hardened USE flag has no
#			effect.
#
# For example, the following would be useful:
#
#	pkg_setup() {
#		use x86 || use amd64 && HARDENED_GCC_WORKS="true"
#	}
#
# This allows for additional archs to be supported by hardened when ready.
#
# Travis Tilley <lv@gentoo.org> (03 Sep 2004)
#
gcc_src_unpack() {
	local release_version="Gentoo Linux ${PVR}"

	# fail if using pie patches, building hardened, and glibc doesnt have
	# the necessary support
	[ -n "${PIE_VER}" ] && use hardened && glibc_have_pie

	gcc_quick_unpack
	exclude_gcc_patches

	cd ${S:="$(gcc_get_s_dir)"}

	if [ -n "${PATCH_VER}" ] ; then
		epatch ${WORKDIR}/patch
	fi
	if [ "${ARCH}" != "hppa" -a "${ARCH}" != "hppa64" -a -n "${PP_VER}" ] ; then
		do_gcc_SSP_patches
	fi
	if [ -n "${PIE_VER}" ] ; then
		do_gcc_PIE_patches
	fi
	if use hardened && [ -n "${HARDENED_GCC_WORKS}" ] ; then
		einfo "updating configuration to build hardened GCC"
		make_gcc_hard || die "failed to make gcc hard"
	fi
	if use !nomultilib && use amd64 && [ -z "${SKIP_MULTILIB_HACK}" ] ; then
		disgusting_gcc_multilib_HACK || die "multilib hack failed"
	fi
	einfo "patching gcc version: ${BRANCH_UPDATE} (${release_version})"
	gcc_version_patch "${BRANCH_UPDATE} (${release_version})"

	# Misdesign in libstdc++ (Redhat)
	cp -a ${S}/libstdc++-v3/config/cpu/i{4,3}86/atomicity.h

	# disable --as-needed from being compiled into gcc specs
	# natively when using >=sys-devel/binutils-2.15.90.0.1 this is
	# done to keep our gcc backwards compatible with binutils. 
	# gcc 3.4.1 cvs has patches that need back porting.. 
	# http://gcc.gnu.org/bugzilla/show_bug.cgi?id=14992 (May 3 2004)
	sed -i -e s/HAVE_LD_AS_NEEDED/USE_LD_AS_NEEDED/g ${S}/gcc/config.in

	use uclibc && gnuconfig_update

	cd ${S}; ./contrib/gcc_update --touch &> /dev/null
}


# This function sets up a few essential variables. You can override any of
# the variables defined here before (or after) calling the function. This needs
# to be done for gcc 3.3.x ebuilds, since the default LIBPATH is a sane default
# only for gcc 3.4 and later. An example of this would be the libstdc++-v3
# ebuilds, which are currently based on 3.3 only. You may optionally specify
# that non-versioned directories be used by calling the function with:
#
#	gcc_setup_variables non-versioned
#
# though using non-versioned directories for anything other than possibly a
# few library targets is STRONGLY discouraged. This function sets the following
# variables:
#
#	LOC
#			If for some reason you want to set your prefix to a location other
#			than /usr, this is the variable you want to change.
#
#	LIBPATH
#			This variable (hopefully) sets the root for all installed libraries.
#
#	DATAPATH
#			This variable sets the root for misc installed data. This includes
#			info pages, man pages, and gcc message translations.
#
#	STDCXX_INCDIR
#			Location to install any c++ headers to.
#
# Travis Tilley <lv@gentoo.org> (03 Sep 2004)
#
gcc_setup_variables() {
	MY_PV="`echo ${PV} | awk -F. '{ gsub(/_pre.*|_alpha.*/, ""); print $1 "." $2 }'`"
	MY_PV_FULL="`echo ${PV} | awk '{ gsub(/_pre.*|_alpha.*/, ""); print $0 }'`"

	MAIN_BRANCH="${PV}"  # Tarball, etc used ...
	# Pre-release support. Needed for unpacking source with _pre ebuilds.
	if [ ${PV} != ${PV/_pre/-} ] ; then
		PRERELEASE=${PV/_pre/-}
	fi

	# Theoretical cross compiler support
	[ ! -n "${CCHOST}" ] && export CCHOST="${CHOST}"

	LOC="${LOC:="/usr"}"

	if [ -z "$1" ] ; then
	  # until all of the necessary tools are lib32/lib64 aware, this HAS to
	  # return lib!!!
	  get_libdir_override lib
	  # GCC 3.4 no longer uses gcc-lib.
	  LIBPATH="${LIBPATH:="${LOC}/$(get_libdir)/gcc/${CCHOST}/${MY_PV_FULL}"}"
	  INCLUDEPATH="${INCLUDEPATH:="${LIBPATH}/include"}"
	  BINPATH="${BINPATH:="${LOC}/${CCHOST}/gcc-bin/${MY_PV}"}"
	  DATAPATH="${DATAPATH:="${LOC}/share/gcc-data/${CCHOST}/${MY_PV}"}"
	  # Dont install in /usr/include/g++-v3/, but in gcc internal directory.
	  # We will handle /usr/include/g++-v3/ with gcc-config ...
	  STDCXX_INCDIR="${STDCXX_INCDIR:="${LIBPATH}/include/g++-v${MY_PV/\.*/}"}"
	elif [ "$1" == "non-versioned" ] ; then
	  # using non-versioned directories to install gcc, like what is currently
	  # done for ppc64 and 3.3.3_pre, is a BAD IDEA. DO NOT do it!! However...
	  # setting up variables for non-versioned directories might be useful for
	  # specific gcc targets, like ffcall. Note that we dont override the value
	  # returned by get_libdir here.
	  LIBPATH="${LIBPATH:="${LOC}/$(get_libdir)"}"
	  INCLUDEPATH="${INCLUDEPATH:="${LOC}/include"}"
	  BINPATH="${BINPATH:="${LOC}/bin/"}"
	  DATAPATH="${DATAPATH:="${LOC}/share/"}"
	  STDCXX_INCDIR="${STDCXX_INCDIR:="${LOC}/include/g++-v3/"}"
	fi
}


# This function checks whether or not glibc has the support required to build
# Position Independant Executables with gcc.
glibc_have_pie() {
	if [ ! -f ${ROOT}/usr/$(get_libdir)/Scrt1.o ] ; then
		echo
		ewarn "Your glibc does not have support for pie, the file Scrt1.o is missing"
		ewarn "Please update your glibc to a proper version or disable hardened"
		echo
		return 1
	fi
}


# This function determines whether or not libc has been patched with stack
# smashing protection support.
libc_has_ssp() {
	local libc_prefix
	use ppc64 && libc_prefix="/lib64/"
	libc_prefix="${libc_prefix:="/$(get_libdir)/"}"

	use uclibc \
		&& local libc_file="libc.so.0" \
		|| local libc_file="libc.so.6"

	local my_libc=${ROOT}/${libc_prefix}/${libc_file}

	# Check for the libc to have the __guard symbols
	if  [ "$(readelf -s "${my_libc}" 2>/dev/null | \
	         grep GLOBAL | grep OBJECT | grep '__guard')" ] && \
	    [ "$(readelf -s "${my_libc}" 2>/dev/null | \
	         grep GLOBAL | grep FUNC | grep '__stack_smash_handler')" ]
	then
		return 0
	else
		return 1
	fi
}


# This function configures gcc. It requires at least one argument, specifying
# whether or not to use versioned directories. Example:
#
#	gcc_do_configure versioned|non-versioned ${other_conf_options}
#
# Other than the variables described for gcc_setup_variables, the following
# will alter tha behavior of gcc_do_configure:
#
#	CCHOST
#	CBUILD
#			Enable building for a target that differs from CHOST
#
#	GCC_TARGET_NO_MULTILIB
#			Disable multilib. Useful when building single library targets.
#
#	GCC_LANG
#			Enable support for ${GCC_LANG} languages. defaults to just "c"
#
# Travis Tilley <lv@gentoo.org> (04 Sep 2004)
#
gcc_do_configure() {
	local confgcc

	[ "$1" != "versioned" -a "$1" != "non-versioned" ] && \
		die "gcc_do_configure called without specifying versioned/non-versioned"
	[ "$1" == "versioned" ] && confgcc="--enable-version-specific-runtime-libs"
	[ "$1" == "non-versioned" ] && confgcc="--libdir=/usr/$(get_libdir)"
	shift

	# If we've forgotten to set the path variables, this will give us
	# reasonable defaults.
	gcc_setup_variables

	# Set configuration based on path variables
	confgcc="${confgcc} \
		--prefix=${LOC} \
		--bindir=${BINPATH} \
		--includedir=${INCLUDEPATH} \
		--datadir=${DATAPATH} \
		--mandir=${DATAPATH}/man \
		--infodir=${DATAPATH}/info \
		--with-gxx-include-dir=${STDCXX_INCDIR} \
		--with-local-prefix=${LOC}/local"

	# Where to install libgcc_s (no worky for versioned?)
	#SLIBDIR="${SLIBDIR:="${LIBPATH}"}"
	#confgcc="${confgcc} --with-slibdir=${SLIBDIR}"

	# Incredibly theoretical cross-compiler support
	confgcc="${confgcc} --host=${CHOST}"
	if [ "${CCHOST}" != "${CHOST}" -a "${CCHOST}" != "" ] ; then
		# Straight from the GCC install doc:
		# "GCC has code to correctly determine the correct value for target 
		# for nearly all native systems. Therefore, we highly recommend you
		# not provide a configure target when configuring a native compiler."
		confgcc="${confgcc} --target=${CCHOST}"
	fi
	if [ "${CBUILD}" != "" ] ; then
		confgcc="${confgcc} --build=${CBUILD}"
	fi

	# multilib support
	if use !nomultilib && [ -z "${GCC_TARGET_NO_MULTILIB}" ] ; then
		confgcc="${confgcc} --enable-multilib"
	else
		confgcc="${confgcc} --disable-multilib"
	fi

	# altivec support
	if use ppc || use ppc64 ; then
		use altivec && confgcc="${confgcc} --enable-altivec"
		use !altivec && confgcc="${confgcc} --disable-altivec"
	fi

	# Native Language Support
	if use nls && use !build ; then
		confgcc="${confgcc} --enable-nls --without-included-gettext"
	else
		confgcc="${confgcc} --disable-nls"
	fi

	# __cxa_atexit is "essential for fully standards-compliant handling of
	# destructors", but apparently requires glibc.
	# --enable-sjlj-exceptions : currently the unwind stuff seems to work 
	# for statically linked apps but not dynamic
	# so use setjmp/longjmp exceptions by default
	# uclibc uses --enable-clocale=uclibc (autodetected)
	# --disable-libunwind-exceptions needed till unwind sections get fixed. see ps.m for details
	if use !uclibc ; then
		confgcc="${confgcc} --enable-__cxa_atexit --enable-clocale=gnu"
	else
		confgcc="${confgcc} --disable-__cxa_atexit --enable-target-optspace \
			--enable-sjlj-exceptions"
	fi

	# reasonably sane globals (hopefully)
	confgcc="${confgcc} \
		--enable-shared \
		--with-system-zlib \
		--disable-checking \
		--disable-werror \
		--disable-libunwind-exceptions \
		--with-gnu-ld \
		--enable-threads=posix"

	# what languages should we enable?
	if [ -z "${GCC_LANG}" ] ; then
		# if not specified, assume we are building for a target that only
		# requires C support
		GCC_LANG="c"
	fi
	confgcc="${confgcc} --enable-languages=${GCC_LANG}"
	use build || use !gcj && confgcc="${confgcc} --disable-libgcj"

	# default arch support
	use sparc && confgcc="${confgcc} --with-cpu=v7"
	use ppc && confgcc="${confgcc} --with-cpu=common"

	# Nothing wrong with a good dose of verbosity
	echo
	einfo "LOC:             ${LOC}"
	einfo "BINPATH:         ${BINPATH}"
	einfo "LIBPATH:         ${LIBPATH}"
	einfo "DATAPATH:        ${DATAPATH}"
	einfo "STDCXX_INCDIR:   ${STDCXX_INCDIR}"
	echo
	einfo "Configuring GCC with: ${confgcc} ${@}"
	echo

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	pushd ${WORKDIR}/build

	# and now to do the actual configuration
	addwrite "/dev/zero"
	${S}/configure ${confgcc} ${@} || die "failed to run configure"

	# return to whatever directory we were in before
	popd
}


# This function accepts one optional argument, the make target to be used.
# If ommitted, gcc_do_make will try to guess whether it should use all,
# profiledbootstrap, or bootstrap-lean depending on CCHOST and arch. An
# example of how to use this function:
#
#	gcc_do_make all-target-libstdc++-v3
#
# In addition to the target to be used, the following variables alter the
# behavior of this function:
#
#	LDFLAGS
#			Flags to pass to ld
#
#	STAGE1_CFLAGS
#			CFLAGS to use during stage1 of a gcc bootstrap
#
#	BOOT_CFLAGS
#			CFLAGS to use during stages 2+3 of a gcc bootstrap.
#
# Travis Tilley <lv@gentoo.org> (04 Sep 2004)
#
gcc_do_make() {
	# Setup -j in MAKEOPTS
	get_number_of_jobs

	# Only build it static if we are just building the C frontend, else
	# a lot of things break because there are not libstdc++.so ....
	if use static && [ "${GCC_LANG}" = "c" ] ; then
		LDFLAGS="${LDFLAGS:="-static"}"
	fi
	
	STAGE1_CFLAGS="${STAGE1_CFLAGS:="-O"}"
	LIBCFLAGS="${LIBCFLAGS:="${CFLAGS} -g"}"
	LIBCXXFLAGS="${LIBCXXFLAGS:="${CFLAGS} -g -fno-implicit-templates"}"

	if [ -z "${CCHOST}" -o "${CCHOST}" == "${CHOST}" ] ; then
		# we only want to use the system's CFLAGS if not building a
		# cross-compiler.
		BOOT_CFLAGS="${BOOT_CFLAGS:="${CFLAGS}"}"
	else
		BOOT_CFLAGS="${BOOT_CFLAGS:="-O2"}"
	fi

	# Fix for libtool-portage.patch
	local OLDS="${S}"
	S="${WORKDIR}/build"

	# Set make target to $1 if passed
	[ "$1" != "" ] && GCC_MAKE_TARGET="$1"
	# default target
	if [ "${CCHOST}" != "${CHOST}" ] ; then
		# 3 stage bootstrapping doesnt quite work when you cant run the
		# resulting binaries natively ^^;
		GCC_MAKE_TARGET="${GCC_MAKE_TARGET:=all}"
	elif use x86 || use amd64 || use ppc64 ; then
		GCC_MAKE_TARGET="${GCC_MAKE_TARGET:=profiledbootstrap}"
	else
		GCC_MAKE_TARGET="${GCC_MAKE_TARGET:=bootstrap-lean}"
	fi

	# the gcc docs state that parallel make isnt supported for the
	# profiledbootstrap target, as collisions in profile collecting may occur.
	if [ "${GCC_MAKE_TARGET}" == "profiledbootstrap" ] ; then
		MAKE_COMMAND="make"
	else
		MAKE_COMMAND="emake"
	fi

	pushd ${WORKDIR}/build
	einfo "Running ${MAKE_COMMAND} LDFLAGS=\"${LDFLAGS}\" STAGE1_CFLAGS=\"${STAGE1_CFLAGS}\" LIBCFLAGS=\"${LIBCFLAGS}\" LIBCXXFLAGS=\"${LIBCXXFLAGS}\" LIBPATH=\"${LIBPATH}\" BOOT_CFLAGS=\"${BOOT_CFLAGS}\" ${GCC_MAKE_TARGET}"

	${MAKE_COMMAND} LDFLAGS="${LDFLAGS}" STAGE1_CFLAGS="${STAGE1_CFLAGS}" \
		LIBCFLAGS="${LIBCFLAGS}" LIBCXXFLAGS="${LIBCXXFLAGS}" \
		LIBPATH="${LIBPATH}" BOOT_CFLAGS="${BOOT_CFLAGS} ${GCC_MAKE_TARGET}" \
		|| die
	popd
}


create_gcc_multilib_scripts() {
	mkdir -p ${D}/usr/bin/
	if has_m32 ; then
cat > ${D}/usr/bin/gcc32 <<EOF
#!/bin/sh
exec /usr/bin/gcc -m32 "$@"
EOF
chmod +x ${D}/usr/bin/gcc32
	fi
	if has_m64 ; then
cat > ${D}/usr/bin/gcc64 <<EOF
#!/bin/sh
exec /usr/bin/gcc -m64 "$@"
EOF
chmod +x ${D}/usr/bin/gcc64
	fi
}


# This function will add ${PV} to the names of all shared libraries in the
# directory specified to avoid filename collisions between multiple slotted 
# non-versioned gcc targets. If no directory is specified, it is assumed that
# you want -all- shared objects to have ${PV} added. Example
#
#	add_version_to_shared ${D}/usr/$(get_libdir)
#
# Travis Tilley <lv@gentoo.org> (05 Sep 2004)
#
add_version_to_shared() {
	local sharedlib
	if [ "$1" == "" ] ; then
		local sharedlibdir="${D}"
	else
		local sharedlibdir="$1"
	fi

	for sharedlib in `find ${sharedlibdir} -name *.so*` ; do
		if [ ! -L "${sharedlib}" ] ; then
			einfo "Renaming `basename "${sharedlib}"` to `basename "${sharedlib/.so*/}-${PV}.so.${sharedlib/*.so./}"`"
			mv "${sharedlib}" "${sharedlib/.so*/}-${PV}.so.${sharedlib/*.so./}" \
				|| die
			pushd `dirname "${sharedlib}"` > /dev/null || die
			ln -sf "`basename "${sharedlib/.so*/}-${PV}.so.${sharedlib/*.so./}"`" \
				"`basename "${sharedlib}"`" || die
			popd > /dev/null || die
		fi
	done
}


toolchain_src_unpack() {
	if [ "${ETYPE}" == "gcc" ] ; then
		gcc_src_unpack
	else
		unpack ${A}
	fi
}


toolchain_pkg_setup() {
	if [ "${ETYPE}" == "gcc" ] ; then
		# if pkg name contains 'gcc', assume we want versioned variables.
		# if not, assume we're installing an individual lib target and use
		# non-versioned variables.
		if [ "${PN}" == "${PN/gcc/}" ] ; then
			gcc_setup_variables non-versioned
		else
			gcc_setup_variables versioned
		fi
	fi
}

