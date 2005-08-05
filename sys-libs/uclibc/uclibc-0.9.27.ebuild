# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/uclibc/uclibc-0.9.27.ebuild,v 1.23 2005/08/05 00:06:10 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi
# Handle the case where we want uclibc on glibc ...
if [[ ${CTARGET} == ${CHOST} ]] && [[ ${CHOST} != *-uclibc ]] ; then
	export UCLIBC_AND_GLIBC="sitting in a tree"
	export CTARGET=${CHOST%%-*}-pc-linux-uclibc
fi

# To make a new SVN_VER we do.
# wget -O - http://uclibc.org/downloads/snapshots/uClibc-`date +%Y%m%d`.tar.bz2 | tar jxf -
# tar jxf /usr/portage/distfiles/uClibc-0.9.27.tar.bz2
# diff -urN --exclude .svn uClibc-0.9.27 uClibc | bzip2 - > uClibc-0.9.27-svn-update-`date +%Y%m%d`.patch.bz2
# rm -rf uClibc-0.9.27-svn-update-`date +%Y%m%d`.patch.bz2  uClibc uClibc-0.9.27

MY_P=${P/ucl/uCl}
SVN_VER="20050114"
PATCH_VER="1.3"
DESCRIPTION="C library for developing embedded Linux systems"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="http://www.kernel.org/pub/linux/libs/uclibc/${MY_P}.tar.bz2
	mirror://gentoo/${MY_P}-cvs-update-${SVN_VER}.patch.bz2
	mirror://gentoo/${MY_P}-patches-${PATCH_VER}.tar.bz2"

LICENSE="LGPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS="arm m68k mips ppc sh sparc x86"
IUSE="build debug hardened ipv6 wordexp" # nls is not supported yet
RESTRICT="nostrip"

DEPEND="virtual/os-headers"
RDEPEND=""
[[ ${CTARGET} == ${CHOST} ]] && PROVIDE="virtual/libc"

S=${WORKDIR}/${MY_P}

alt_kprefix() {
	if [[ ${CBUILD} == ${CHOST} && ${CTARGET} == ${CHOST} ]] \
	   || [[ -n ${UCLIBC_AND_GLIBC} ]]
	then
		echo /usr
	else
		echo /usr/${CTARGET}
	fi
}
alt_prefix() {
	if [[ ${CTARGET} == ${CHOST} ]] ; then
		echo /usr
	else
		echo /usr/${CTARGET}
	fi
}
alt_rprefix() {
	if [[ ${CTARGET} == ${CHOST} ]] ; then
		echo /
	else
		echo /usr/${CTARGET}/
	fi
}

CPU_ARM="GENERIC_ARM ARM{610,710,720T,920T,922T,926T,_{SA110,SA1100,XSCALE}}"
CPU_M68K=""
CPU_MIPS="MIPS_ISA_{1,2,3,4,MIPS{32,64}}"
CPU_PPC=""
CPU_SH="SH{2,3,4,5}"
CPU_SPARC=""
CPU_X86="GENERIC_386 {3,4,5,6}86 586MMX PENTIUM{II,III,4} K{6,7} ELAN CRUSOE WINCHIP{C6,2} CYRIXIII NEHEMIAH"
IUSE_UCLIBC_CPU="${CPU_ARM} ${CPU_MIPS} ${CPU_PPC} ${CPU_SH} ${CPU_SPARC} ${CPU_X86}"

check_cpu_opts() {
	local cpu_var="CPU_$(echo $(tc-arch) | tr [a-z] [A-Z])"
	if [[ -z ${UCLIBC_CPU} ]] ; then
		ewarn "You really should consider setting UCLIBC_CPU"
		ewarn "Otherwise, the build will be generic (read: slow)."
		ewarn "Available CPU options:"
		UCLIBC_CPU=$(eval echo ${!cpu_var})
		echo ${UCLIBC_CPU}
		export UCLIBC_CPU=${UCLIBC_CPU%% *}
	else
		local cpu found=0
		for cpu in $(eval echo ${!cpu_var}) ; do
			[[ ${UCLIBC_CPU} == "${cpu}" ]] && found=1 && break
		done
		if [[ ${found} -eq 0 ]] ; then
			ewarn "UCLIBC_CPU choice '${UCLIBC_CPU}' not supported"
			ewarn "Valid choices:"
			eval echo ${!cpu_var}
			die "pick a supported cpu type"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	check_cpu_opts

	echo
	einfo "Runtime Prefix: $(alt_rprefix)"
	einfo "Kernel Prefix:  $(alt_kprefix)"
	einfo "Devel Prefix:   $(alt_prefix)"
	einfo "CBUILD:         ${CBUILD}"
	einfo "CHOST:          ${CHOST}"
	einfo "CTARGET:        ${CTARGET}"
	einfo "CPU:            ${UCLIBC_CPU}"
	einfo "ENDIAN:         $(tc-endian)"
	echo

	########## PATCHES ##########

	[[ -n ${SVN_VER} ]] && \
		epatch "${WORKDIR}"/${MY_P}-cvs-update-${SVN_VER}.patch

	if [[ -n ${PATCH_VER} ]] ; then
		unpack ${MY_P}-patches-${PATCH_VER}.tar.bz2
		EPATCH_SUFFIX="patch"
		epatch "${WORKDIR}"/patch
		# math functions (sinf,cosf,tanf,atan2f,powf,fabsf,copysignf,scalbnf,rem_pio2f)
		use build || epatch "${WORKDIR}"/patch/math
	fi

	########## CPU SELECTION ##########

	local target config_target
	case $(tc-arch) in
		arm)  target="arm";     config_target="GENERIC_ARM";;
		m68k) target="m68k";    config_target="no cpu-specific options";;
		mips) target="mips";    config_target="MIPS_ISA_1";;
		ppc)  target="powerpc"; config_target="no cpu-specific options";;
		sh)   target="sh";      config_target="SH4";;
		x86)  target="i386";    config_target="GENERIC_386";;
		*)    die "$(tc-arch) lists no defaults :/";;
	esac
	sed -i -e "s:default TARGET_i386:default TARGET_${target}:" \
		extra/Configs/Config.in
	sed -i -e "s:default CONFIG_${config_target}:default CONFIG_${UCLIBC_CPU:-${config_target}}:" \
		extra/Configs/Config.${target}

	########## CONFIG SETUP ##########

	make defconfig >/dev/null || die "could not config"

	for def in UCLIBC_PROFILING DO{DEBUG,ASSERTS} SUPPORT_LD_DEBUG{,_EARLY} ; do
		sed -i -e "s:${def}=y:# ${def} is not set:" .config
	done
	if use debug ; then
		echo "SUPPORT_LD_DEBUG=y" >> .config
		echo "DODEBUG=y" >> .config
	fi

	sed -i -e '/ARCH_.*_ENDIAN/d' .config
	echo "ARCH_$(tc-endian | tr [a-z] [A-Z])_ENDIAN=y" >> .config

	if [[ ${CTARGET} == *-softfloat-* ]] ; then
		sed -i -e '/^HAS_FPU=y$/d' .config
		echo 'HAS_FPU=n' >> .config
	fi

	for def in DO_C99_MATH UCLIBC_HAS_{RPC,CTYPE_CHECKED,WCHAR,HEXADECIMAL_FLOATS,GLIBC_CUSTOM_PRINTF,FOPEN_EXCLUSIVE_MODE,GLIBC_CUSTOM_STREAMS,PRINTF_M_SPEC,FTW} ; do
		sed -i -e "s:# ${def} is not set:${def}=y:" .config
	done
	echo "UCLIBC_HAS_FULL_RPC=y" >> .config
	echo "PTHREADS_DEBUG_SUPPORT=y" >> .config
	echo "UCLIBC_HAS_TZ_FILE_READ_MANY=n" >> .config

	#if use nls ; then
	#	sed -i -e "s:# UCLIBC_HAS_LOCALE is not set:UCLIBC_HAS_LOCALE=y:" .config
	#	echo "UCLIBC_HAS_XLOCALE=n" >> .config
	#	echo "UCLIBC_HAS_GLIBC_DIGIT_GROUPING=y" >> .config
	#	echo "UCLIBC_HAS_SCANF_LENIENT_DIGIT_GROUPING=y" >> .config
	#	# removed on 20040907 by mjn3
	#	echo "UCLIBC_HAS_GETTEXT_AWARENESS=y" >> .config
	#	# on pax enabled kernels the locale files can't be built
	#	echo "UCLIBC_PREGENERATED_LOCALE_DATA=n" >> .config
	#fi
	# we disable LOCALE for any case, gettext has to be used
	echo "UCLIBC_HAS_LOCALE=n" >> .config

	use ipv6 && sed -i -e "s:# UCLIBC_HAS_IPV6 is not set:UCLIBC_HAS_IPV6=y:" .config

	# uncomment if you miss wordexp (alsa-lib)
	use wordexp && sed -i -e "s:# UCLIBC_HAS_WORDEXP is not set:UCLIBC_HAS_WORDEXP=y:" .config

	# we need to do it independently of hardened to get ssp.c built into libc
	sed -i -e "s:# UCLIBC_SECURITY.*:UCLIBC_SECURITY=y:" .config
	echo "UCLIBC_HAS_SSP=y" >> .config
	echo "PROPOLICE_BLOCK_ABRT=n" >> .config
	if use debug ; then
		echo "PROPOLICE_BLOCK_SEGV=y" >> .config
		echo "PROPOLICE_BLOCK_KILL=n" >> .config
	else
		echo "PROPOLICE_BLOCK_SEGV=n" >> .config
		echo "PROPOLICE_BLOCK_KILL=y" >> .config
	fi

	if use hardened ; then
		if has $(tc-arch) mips ppc x86 ; then
			echo "UCLIBC_BUILD_PIE=y" >> .config
		else
			echo "UCLIBC_BUILD_PIE=n" >> .config
		fi
		echo "SSP_QUICK_CANARY=n" >> .config
		echo "UCLIBC_BUILD_SSP=y" >> .config
		echo "UCLIBC_BUILD_RELRO=y" >> .config
		echo "UCLIBC_BUILD_NOW=y" >> .config
		echo "UCLIBC_BUILD_NOEXECSTACK=y" >> .config
	else
		echo "UCLIBC_BUILD_PIE=n" >> .config
		echo "SSP_QUICK_CANARY=y" >> .config
		echo "UCLIBC_BUILD_SSP=n" >> .config
		echo "UCLIBC_BUILD_RELRO=n" >> .config
		echo "UCLIBC_BUILD_NOW=n" >> .config
		echo "UCLIBC_BUILD_NOEXECSTACK=n" >> .config
	fi

	# we are building against system installed kernel headers
	sed -i \
		-e "s:KERNEL_SOURCE.*:KERNEL_SOURCE=\"$(alt_kprefix)\":" \
		-e "s:SHARED_LIB_LOADER_PREFIX=.*:SHARED_LIB_LOADER_PREFIX=\"$(alt_rprefix)$(get_libdir)\":" \
		-e "s:DEVEL_PREFIX=.*:DEVEL_PREFIX=\"$(alt_prefix)\":" \
		-e "s:RUNTIME_PREFIX=.*:RUNTIME_PREFIX=\"$(alt_rprefix)\":" \
		.config

	yes "" 2> /dev/null | make -s oldconfig > /dev/null || die "could not make oldconfig"

	chmod +x extra/scripts/relative_path.sh

	cp .config myconfig

	emake clean > /dev/null || die "could not clean"
}

src_compile() {
	cp myconfig .config

	# last release doesnt support parallel build, 
	# but the current svn repo does ...
	export MAKEOPTS="${MAKEOPTS} -j1"
	type -p ${CTARGET}-ar && export MAKEOPTS="${MAKEOPTS} CROSS=${CTARGET}-"

	emake || die "could not make"
	[[ ${CTARGET} != ${CHOST} ]] && return 0

	if [[ ${CHOST} == *-uclibc ]] ; then
		emake utils || die "could not make utils"
	fi
}

src_test() {
	return 0

	[[ ${CHOST} != ${CTARGET} ]] && return 0
	[[ ${CBUILD} != ${CHOST} ]] && return 0

	# running tests require this
	use build || addwrite /dev/ptmx

	# This is wrong, but uclibc's tests fail bad when screwing 
	# around with sandbox, so lets just punt it
	unset LD_PRELOAD

	# assert test fails on pax/grsec enabled kernels - normal
	# vfork test fails in sandbox (both glibc/uclibc)
	cd test
	make || die "test failed"
}

src_install() {
	emake PREFIX="${D}" install || die "install failed"

	# remove files coming from kernel-headers
	# scsi is uclibc's own directory since cvs 20040212
	rm -rf "${D}"$(alt_prefix)/include/{asm,linux,asm-generic}

	# clean up misc cruft
	find "${D}"$(alt_prefix)/include -type d '(' -name CVS -o -name .svn ')' -print0 | xargs -0 rm -r
	find "${D}"$(alt_prefix)/include -type f -name .cvsignore -print0 | xargs -0 rm -f

	# Make sure we install the sys-include symlink so that when 
	# we build a 2nd stage cross-compiler, gcc finds the target 
	# system headers correctly.  See gcc/doc/gccinstall.info
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		dosym include $(alt_prefix)/sys-include
		return 0
	fi

	if [[ ${CHOST} == *-uclibc ]] ; then
		emake PREFIX="${D}" install_utils || die "install-utils failed"
		dobin extra/scripts/getent
	fi

	if ! use build ; then
		dodoc Changelog* README TODO docs/*.txt DEDICATION.mjn3
		doman debian/*.1
	fi
}

pkg_postinst() {
[[ ${CTARGET} != ${CHOST} ]] && return 0

if [[ ${CHOST} == *-uclibc ]] ; then
	# remove invalid symlinks if any
	#local x=
	#for x in TZ ld.so.conf ld.so.preload ; do
	#	[[ ! -e ${ROOT}/etc/${x} ]] && rm -f "${ROOT}"/etc/${x}
	#done

	if [[ ! -e ${ROOT}/etc/TZ ]] ; then
		echo "Please remember to set your timezone in /etc/TZ."
		echo "UTC" > "${ROOT}"/etc/TZ
	fi

	if [[ ${ROOT} == "/" ]] ; then
		# update cache before reloading init
		/sbin/ldconfig
		# reload init ...
		[ -x /sbin/init ] && /sbin/init U &> /dev/null
		# add entries for alternatives (like minit)
	fi
#else
#should we add the libdir on a non-uclibc based system to ld.so.conf?
fi
}
