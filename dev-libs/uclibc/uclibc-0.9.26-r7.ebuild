# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/uclibc/uclibc-0.9.26-r7.ebuild,v 1.2 2004/10/28 05:55:32 solar Exp $

inherit eutils flag-o-matic gcc

# To make a new CVS_VER we do.
# wget -O - http://uclibc.org/downloads/snapshots/uClibc-`date +%Y%m%d`.tar.bz2 | tar jxf -
# tar jxf /usr/portage/distfiles/uClibc-0.9.26.tar.bz2
# diff -urN --exclude .cvsignore --exclude CVS uClibc-0.9.26 uClibc | bzip2 - > uClibc-0.9.26-cvs-update-`date +%Y%m%d`.patch.bz2
# rm -rf uClibc-0.9.26-cvs-update-`date +%Y%m%d`.patch.bz2  uClibc uClibc-0.9.26

MY_P="${P/ucl/uCl}"
CVS_VER="20040808"
PATCH_VER="1.1"
DESCRIPTION="C library for developing embedded Linux systems"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="http://www.kernel.org/pub/linux/libs/uclibc/${MY_P}.tar.bz2
	mirror://gentoo/${MY_P}-cvs-update-${CVS_VER}.patch.bz2
	mirror://gentoo/${MY_P}-patches-${PATCH_VER}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc mips arm"
IUSE="build hardened ipv6 static debug" # nls is not supported yet
RESTRICT="nostrip"

DEPEND="sys-devel/gcc"
RDEPEND=""
PROVIDE="virtual/glibc virtual/libc"

S=${WORKDIR}/${MY_P}

check_main_libc() {
	if [ "${CHOST/uclibc}" != "${CHOST}" ] ; then
		SYS_LIBC=uClibc
	else
		SYS_LIBC=glibc
	fi
	export SYS_LIBC
	echo
	einfo "We are building for ${SYS_LIBC} system library"
	echo
}

src_unpack() {
	unpack ${A}
	cd ${S}

	if [ -n "${CVS_VER}" ]
	then
		epatch ${DISTDIR}/${MY_P}-cvs-update-${CVS_VER}.patch.bz2
	fi

	cp ${FILESDIR}/0.9.26/ssp.c ${S}/libc/sysdeps/linux/common/ \
		|| die "failed to copy ssp.c to ${S}/libc/sysdeps/linux/common/"
	# gcc 3.4 nukes ssp without this patch
	if [ "`gcc-major-version`" -eq "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		epatch ${FILESDIR}/0.9.26/uclibc-0.9.26-ssp-gcc34-after-frandom.patch
	fi

	if [ -n "${PATCH_VER}" ]
	then
		unpack ${MY_P}-patches-${PATCH_VER}.tar.bz2
		# for now we remove relro/now, no support for relro in ldso
		rm -f ${WORKDIR}/patch/*relro*
		rm -f ${WORKDIR}/patch/*now*
		rm -f ${WORKDIR}/patch/11_all_uClibc-0.9.26-socket.patch.bz2
		# remove default ssp build
		use hardened || rm -f ${WORKDIR}/patch/*enable-ssp*
		epatch ${WORKDIR}/patch
	fi

	# support archs which dont implement all syscalls
	[ -z "${CVS_VER}" ] \
		&& epatch ${FILESDIR}/${PV}/arm-fix-missing-syscalls.patch \
		|| epatch ${FILESDIR}/${PV}/uclibc-0.9.26-arm-dl-sysdep.patch
	epatch ${FILESDIR}/${PV}/arm-ucontext.patch

	# build all .S files w/ -Wa,--noexecstack
	if [ "0${CVS_VER}" -ge "20040730" ]; then
		einfo "Skipping noexecstack patch. (need update)"
	else
		epatch ${FILESDIR}/${PV}/${PN}-${PV}-noexecstack.patch
	fi

	# fix segfaults when running things like `emerge sync`
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-resolve-segfault.patch

	# allow libs tagged as ELF_LIBC0 in the cache to be loaded
	epatch ${FILESDIR}/${PV}/${PN}-${PV}-ldso-cache.patch

	# Take extra security precaution's for suid handling with environment variables
	epatch ${FILESDIR}/${PV}/uClibc-20040921-ldso-unsecvars.patch
	cp ${FILESDIR}/${PV}/unsecvars.h ${S}/ldso/include/ || die

	# fixup for install perms
	sed -i -e "s:-fa:-dRf:g" Makefile

	local target=""
	if [ "${ARCH}" == "x86" ] ; then
		target="i386"
	elif [ "${ARCH}" == "ppc" ] ; then
		target="powerpc"
	else
		# sparc|mips|alpha|arm|sh
		target="${ARCH}"
	fi
	sed -i \
		-e "s:default TARGET_i386:default TARGET_${target}:" \
		extra/Configs/Config.in
	sed -i \
		-e "s:default CONFIG_GENERIC_386:default CONFIG_${UCLIBC_CPU:-GENERIC_386}:" \
		extra/Configs/Config.${target}

	make defconfig >/dev/null || die "could not config"

	for def in UCLIBC_PROFILING DO{DEBUG,ASSERTS} SUPPORT_LD_DEBUG{,_EARLY} ; do
		sed -i -e "s:${def}=y:# ${def} is not set:" .config
	done
	if use debug ; then
		echo "SUPPORT_LD_DEBUG=y" >> .config
		echo "DODEBUG=y" >> .config
	fi

	for def in DO_C99_MATH UCLIBC_HAS_{RPC,CTYPE_CHECKED,WCHAR,HEXADECIMAL_FLOATS,GLIBC_CUSTOM_PRINTF,FOPEN_EXCLUSIVE_MODE,GLIBC_CUSTOM_STREAMS,PRINTF_M_SPEC,FTW} ; do
		sed -i -e "s:# ${def} is not set:${def}=y:" .config
	done
	echo "UCLIBC_HAS_FULL_RPC=y" >> .config
	echo "PTHREADS_DEBUG_SUPPORT=y" >> .config

	#if use nls
	#then
	#	sed -i -e "s:# UCLIBC_HAS_LOCALE is not set:UCLIBC_HAS_LOCALE=y:" .config
	#	echo "UCLIBC_HAS_XLOCALE=n" >> .config
	#	echo "UCLIBC_HAS_GLIBC_DIGIT_GROUPING=y" >> .config
	#	echo "UCLIBC_HAS_SCANF_LENIENT_DIGIT_GROUPING=y" >> .config
	#	echo "UCLIBC_HAS_GETTEXT_AWARENESS=y" >> .config
	#	# on pax enabled kernels the locale files can't be built
	#	echo "UCLIBC_PREGENERATED_LOCALE_DATA=n" >> .config
	#fi
	# we disable LOCALE for any case, gettext has to be used
	echo "UCLIBC_HAS_LOCALE=n" >> .config

	use ipv6 && sed -i -e "s:# UCLIBC_HAS_IPV6 is not set:UCLIBC_HAS_IPV6=y:" .config

	if use hardened
	then
		if use x86
		then
			einfo "Enable Position Independent Executable support in ${P}"
			sed -i -e "s:# UCLIBC_PIE_SUPPORT.*:UCLIBC_PIE_SUPPORT=y:" .config
		fi

		einfo "Enable Stack Smashing Protections support in ${P}"
		sed -i -e "s:# UCLIBC_PROPOLICE.*:UCLIBC_PROPOLICE=y:" .config
		echo "PROPOLICE_BLOCK_ABRT=n" >> .config
		echo "PROPOLICE_BLOCK_SEGV=n" >> .config
		echo "PROPOLICE_BLOCK_KILL=y" >> .config
	fi

	# we are building against system installed kernel headers
	sed -i -e 's:KERNEL_SOURCE.*:KERNEL_SOURCE="/usr":' .config

	check_main_libc
	if [ "${SYS_LIBC}" = "uClibc" ] ; then
		sed -i \
			-e 's:SHARED_LIB_LOADER_PREFIX=.*:SHARED_LIB_LOADER_PREFIX="/lib":' \
			-e 's:DEVEL_PREFIX=.*:DEVEL_PREFIX="/usr":' \
			-e 's:RUNTIME_PREFIX=.*:RUNTIME_PREFIX="/":' \
			.config
		sed -i '/LIBRARY_CACHE:=/s:#::' Rules.mak
	fi

	make -s oldconfig > /dev/null || die "could not make oldconfig"

	chmod +x extra/scripts/relative_path.sh

	cp .config myconfig

	emake clean >/dev/null || die "could not clean"

	sed -i 's:-DUCLIBC:$(LIBRARY_CACHE) -DUCLIBC:' ldso/{ldso,libdl}/Makefile
	sed -i 's:\$(R_PREFIX):\\"$(RUNTIME_PREFIX)\\" $(LIBRARY_CACHE):' utils/Makefile
	sed -i 's: I\.: -I.:' ldso/libdl/Makefile
	sed -i 's:sys/user\.h:asm/page.h:' libc/misc/internals/__uClibc_main.c
}

src_compile() {
	# running tests require this
	use build || addwrite /dev/ptmx
	cp myconfig .config

	#if use nls
	#then
	#	# these can be built only if the build system supports locales (as of 0.9.26)
	#	emake -j1 headers
	#	cd extra/locale
	#	make clean
	#	find ./charmaps -name "*.pairs" > codesets.txt
	#	cp LOCALES locales.txt
	#	emake -j1 || die "could not make locales"
	#	cd ../..
	#fi

	emake -j1 || die "could not make"
	check_main_libc
	if [ "${SYS_LIBC}" = "uClibc" ]
	then
		emake -j1 utils || die "could not make utils"
	fi

	if ! use build
	then
		if ! hasq maketest $RESTRICT
		then
			# assert test fails on pax enabled kernels - normal
			# vfork test fails in sandbox (both glibc/uclibc)
			cd test; make; cd ..
		fi
	fi
}

src_install() {
	emake PREFIX=${D} install || die "install failed"

	# remove files coming from kernel-headers
	# scsi is uclibc's own directory since cvs 20040212
	check_main_libc
	if [ "${SYS_LIBC}" = "uClibc" ]
	then
		rm -rf ${D}/usr/include/{asm,linux}
		rm -f ${D}/usr/lib/lib*_pic.a
		! use static && use build && rm -f ${D}/usr/lib/lib*.a

		emake PREFIX=${D} install_utils || die "install-utils failed"
		dodir /usr/bin
		exeinto /usr/bin
		doexe ${FILESDIR}/getent
	fi

	# shameless plug for mjn3 who gives us so much...
	# please give back if you can. -solar
	f=DEDICATION.mjn3 ; [ -e "$f" ] && ( cat $f ; epause 2 )

	if ! use build
	then
		dodoc Changelog* README TODO docs/*.txt DEDICATION.mjn3
		doman debian/*.1
	fi
}

#pkg_postinst() {
#check_main_libc
#if [ "${SYS_LIBC}" = "uClibc" ] ; then
#	if [ "${ROOT}" = "/" ] ; then
#		/sbin/ldconfig
#		[ ! -e /etc/TZ ] && echo UTC > /etc/TZ
#		# reload init?
#	fi
#else
#should we add the lib dir to ld.so.conf?
#fi
#}
