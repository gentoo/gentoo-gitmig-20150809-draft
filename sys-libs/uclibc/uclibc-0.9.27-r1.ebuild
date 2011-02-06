# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/uclibc/uclibc-0.9.27-r1.ebuild,v 1.40 2011/02/06 21:36:14 leio Exp $

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

MY_P=uClibc-${PV}
SVN_VER="20050114"
PATCH_VER="1.6"
DESCRIPTION="C library for developing embedded Linux systems"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="mirror://kernel/linux/libs/uclibc/${MY_P}.tar.bz2
	mirror://gentoo/${MY_P}-cvs-update-${SVN_VER}.patch.bz2
	mirror://gentoo/${MY_P}-patches-${PATCH_VER}.tar.bz2
	nls? ( !userlocales? ( pregen? (
		x86? ( http://www.uclibc.org/downloads/uClibc-locale-030818.tgz )
	) ) )"

LICENSE="LGPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS="-* arm m68k ~mips ppc sh sparc x86"
IUSE="build debug elibc_uclibc hardened ipv6 minimal nls pregen userlocales wordexp crosscompile_opts_headers-only"
RESTRICT="strip"

RDEPEND=""
PROVIDE="elibc_uclibc? ( virtual/libc )"
if [[ ${CTARGET} == ${CHOST} ]] ; then
	DEPEND="virtual/os-headers app-misc/pax-utils"
else
	DEPEND=""
fi

S=${WORKDIR}/${MY_P}

alt_build_kprefix() {
	if [[ ${CBUILD} == ${CHOST} && ${CTARGET} == ${CHOST} ]] \
	   || [[ -n ${UCLIBC_AND_GLIBC} ]]
	then
		echo /usr
	else
		echo /usr/${CTARGET}/usr
	fi
}
just_headers() {
	use crosscompile_opts_headers-only && [[ ${CHOST} != ${CTARGET} ]]
}

uclibc_endian() {
	# XXX: this wont work for a toolchain which is bi-endian, but we
	#      dont have any such thing at the moment, so not a big deal
	touch "${T}"/endian.s
	$(tc-getAS ${CTARGET}) "${T}"/endian.s -o "${T}"/endian.o
	case $(file "${T}"/endian.o) in
		*" MSB "*) echo "big";;
		*" LSB "*) echo "little";;
		*)         echo "NFC";;
	esac
	rm -f "${T}"/endian.{s,o}
}

pkg_setup() {
	just_headers && return 0
	has_version ${CATEGORY}/uclibc || return 0
	[[ -n ${UCLIBC_AND_GLIBC} ]] && return 0
	[[ ${ROOT} != "/" ]] && return 0

	if ! built_with_use --missing false ${CATEGORY}/uclibc nls && use nls && ! use pregen ; then
		eerror "You previously built uclibc with USE=-nls."
		eerror "You cannot generate locale data with this"
		eerror "system.  Please rerun emerge with USE=pregen."
		die "host cannot support locales"
	elif built_with_use --missing false ${CATEGORY}/uclibc nls && ! use nls ; then
		eerror "You previously built uclibc with USE=nls."
		eerror "Rebuilding uClibc with USE=-nls will prob"
		eerror "destroy your system."
		die "switching to nls is baaaad"
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
	einfo "Runtime Prefix: /"
	einfo "Devel Prefix:   /usr"
	einfo "Kernel Prefix:  $(alt_build_kprefix)"
	einfo "CBUILD:         ${CBUILD}"
	einfo "CHOST:          ${CHOST}"
	einfo "CTARGET:        ${CTARGET}"
	einfo "CPU:            ${UCLIBC_CPU}"
	einfo "ENDIAN:         $(uclibc_endian)"
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
	echo "ARCH_$(uclibc_endian | tr [a-z] [A-Z])_ENDIAN=y" >> .config

	if [[ $(tc-is-softfloat) != "no" ]] ; then
		sed -i -e '/^HAS_FPU=y$/d' .config
		echo 'HAS_FPU=n' >> .config
	fi

	for def in DO_C99_MATH UCLIBC_HAS_{RPC,CTYPE_CHECKED,WCHAR,HEXADECIMAL_FLOATS,GLIBC_CUSTOM_PRINTF,FOPEN_EXCLUSIVE_MODE,GLIBC_CUSTOM_STREAMS,PRINTF_M_SPEC,FTW} ; do
		sed -i -e "s:# ${def} is not set:${def}=y:" .config
	done
	echo "UCLIBC_HAS_FULL_RPC=y" >> .config
	echo "PTHREADS_DEBUG_SUPPORT=y" >> .config
	echo "UCLIBC_HAS_TZ_FILE_READ_MANY=n" >> .config

	if use nls ; then
		sed -i -e "s:# UCLIBC_HAS_LOCALE is not set:UCLIBC_HAS_LOCALE=y:" .config
		echo "UCLIBC_HAS_XLOCALE=n" >> .config
		echo "UCLIBC_HAS_GLIBC_DIGIT_GROUPING=y" >> .config
		echo "UCLIBC_HAS_SCANF_LENIENT_DIGIT_GROUPING=y" >> .config
		echo "UCLIBC_HAS_GETTEXT_AWARENESS=y" >> .config

		if use pregen ; then
			echo "UCLIBC_PREGENERATED_LOCALE_DATA=y" >> .config
			echo "UCLIBC_DOWNLOAD_PREGENERATED_LOCALE_DATA=y" >> .config
			if use userlocales ; then
				cp "${DISTDIR}"/${MY_P}-user-locale.tar.gz \
					extra/locale/uClibc-locale-030818.tgz \
					|| die "could not copy ${MY_P}-user-locale.tar.gz"
			else
				cp "${DISTDIR}"/${MY_P}-$(tc-arch)-full-locale.tar.gz \
					extra/locale/uClibc-locale-030818.tgz \
					|| die "could not copy locale"
			fi
		else
			echo "UCLIBC_PREGENERATED_LOCALE_DATA=n" >> .config
		fi
	else
		echo "UCLIBC_HAS_LOCALE=n" >> .config
	fi

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
		-e "/^KERNEL_SOURCE/s:=.*:=\"$(alt_build_kprefix)\":" \
		-e "/^SHARED_LIB_LOADER_PREFIX/s:=.*:=\"/$(get_libdir)\":" \
		-e "/^DEVEL_PREFIX/s:=.*:=\"/usr\":" \
		-e "/^RUNTIME_PREFIX/s:=.*:=\"/\":" \
		.config

	yes "" 2> /dev/null | make -s oldconfig > /dev/null || die "could not make oldconfig"

	chmod +x extra/scripts/relative_path.sh

	cp .config myconfig

	emake clean > /dev/null || die "could not clean"
}

setup_locales() {
	cd "${S}"/extra/locale
	if use userlocales && [[ -f ${ROOT}/etc/locales.build ]] ; then
		:;
	elif use minimal ; then
		find ./charmaps -name ASCII.pairs > codesets.txt
		find ./charmaps -name ISO-8859-1.pairs >> codesets.txt
		cat <<-EOF > locales.txt
		@euro e
		UTF-8 yes
		8-bit yes
		en_US ISO-8859-1
		en_US.UTF-8 UTF-8
		EOF
	else
		find ./charmaps -name '*.pairs' > codesets.txt
		cp LOCALES locales.txt
	fi
	cd -
}

src_compile() {
	cp myconfig .config

	# last release doesnt support parallel build,
	# but the current svn repo does ...
	export MAKEOPTS="${MAKEOPTS} -j1"
	type -p ${CTARGET}-ar && export MAKEOPTS="${MAKEOPTS} CROSS=${CTARGET}-"

	emake headers || die "make headers failed"
	just_headers && return 0

	if use nls && ! use pregen ; then
		cd extra/locale
		make clean || die "make locale clean failed"
		setup_locales
		emake || die "could not make locales"
		cd ../..
	fi

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
	local sysroot=${D}
	[[ ${CHOST} != ${CTARGET} ]] && sysroot="${sysroot}/usr/${CTARGET}"

	local target="install"
	just_headers && target="install_dev"
	emake PREFIX="${sysroot}" ${target} || die "install failed"

	# remove files coming from kernel-headers
	rm -rf "${D}"${sysroot}/usr/include/{asm,linux,asm-generic}

	# clean up misc cruft
	find "${D}"${sysroot}/usr/include -type d '(' -name CVS -o -name .svn ')' -print0 | xargs -0 rm -r
	find "${D}"${sysroot}/usr/include -type f -name .cvsignore -print0 | xargs -0 rm -f

	# Make sure we install the sys-include symlink so that when
	# we build a 2nd stage cross-compiler, gcc finds the target
	# system headers correctly.  See gcc/doc/gccinstall.info
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		dosym usr/include /usr/${CTARGET}/sys-include
		return 0
	fi

	if [[ ${CHOST} == *-uclibc* ]] ; then
		emake PREFIX="${D}" install_utils || die "install-utils failed"
		dobin extra/scripts/getent
	fi

	dodoc Changelog* README TODO docs/*.txt DEDICATION.mjn3
}

pkg_postinst() {
	[[ ${CTARGET} != ${CHOST} ]] && return 0
	[[ ${CHOST} != *-uclibc* ]] && return 0

	if [[ ! -e ${ROOT}/etc/TZ ]] ; then
		ewarn "Please remember to set your timezone in /etc/TZ"
		[[ ! -d ${ROOT}/etc ]] && mkdir -p "${ROOT}"/etc
		echo "UTC" > "${ROOT}"/etc/TZ
	fi

	if [[ ${ROOT} == "/" ]] ; then
		# update cache before reloading init
		/sbin/ldconfig
		# reload init ...
		[[ -x /sbin/telinit ]] && /sbin/telinit U &> /dev/null
	fi
}
