# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/uclibc-buildroot/uclibc-buildroot-20040131.ebuild,v 1.1 2004/02/01 06:55:03 pebenito Exp $

inherit eutils crosscompile

# Derived from gcc-3_3.mk and binutils.mk
GCCVER=3.3.2
BINUTILSVER=2.14.90.0.6
UCLIBCVER=0.9.26
BUSYBOXVER=1.00-pre6
TINYLOGINVER=1.4

DESCRIPTION="Embedded root file system"
HOMEPAGE="http://www.uclibc.org/"
SRC_URI="mirror://gnu/gcc/releases/gcc/gcc-${GCCVER}/gcc-${GCCVER}.tar.bz2
	http://dev.gentoo.org/~dragonheart/buildroot-${PV}.tar.bz2
	mirror://kernel/linux/devel/binutils/binutils-${BINUTILSVER}.tar.bz2
	mirror://kernel/linux/libs/uclibc/toolchain/kernel-headers-2.4.21.tar.bz2
	mirror://kernel/linux/libs/uclibc/uClibc-${UCLIBCVER}.tar.bz2
	nls? ( mirror://kernel/linux/libs/uclibc/uClibc-locale-030818.tgz )
	nommu? ( mirror://kernel/linux/libs/uclibc/toolchain/elf2flt-20030620.tar.bz2 )
	debug? ( http://www.busybox.net/downloads/busybox-${BUSYBOXVER}.tar.bz2 )
	debug? ( http://tinylogin.busybox.net/downloads/tinylogin-${TINYLOGINVER}.tar.bz2 )
	softfloat? ( mirror://debian/pool/main/libf/libfloat/libfloat_990616.orig.tar.gz )
	softfloat? ( mirror://debian/pool/main/libf/libfloat/libfloat_990616-3.diff.gz )"

# TODO pregen local is only x86
#nls? ( x86? ( mirror://kernel/linux/libs/uclibc/uClibc-locale-030818.tgz ) )
#
# nested SRC_URI are not supported until portage-2.0.50pre19 bug #16159

# Note: buildroot doesn't exist on mirror://gentoo yet - have to download the cvs and self pack

# for testing only
RESTRICT="nomirror"

LICENSE="LGPL-2"

#
# Since cross compilers require different slots
#
# NOTE - cross-setslot is for applications not compilers
#
# "crosstarget" from crosscompile.eclass is equal to below
if [ -n  "${CCHOST}" ] && [ "${CHOST}" != "${CCHOST}" ];
then
	if [ -n "${TARGET_ARCH}" ]
	then
		SLOT="${TARGET_ARCH}-${CCHOST}"
	else
		SLOT="${CCHOST}"
	fi
else
	if [ -n "${TARGET_ARCH}" ]
	then
		SLOT="${TARGET_ARCH}"
	else
		SLOT="0"
	fi
fi

IUSE="nls ipv6 debug nommu fullrpc pie softfloat"

# Local use flags
# nommu = No memory management unit on target architecture
# fullrpc = defines xdr functions and some lesser used rpc stuff. Required for NFS
# pie = enforce no text relocation support in uClibc (x86 only)
# softfloat = software floating point calculations


# There was some comment some that alpha may be broken although I don't know.
# TODO check these: ~ppc ~mips ~arm ~alpha
KEYWORDS="~x86"

# TODO maybe a few more...
DEPEND="dev-lang/perl
	sys-devel/gcc
	sys-libs/glibc
	>=sys-apps/sed-4
	sys-apps/grep
	sys-apps/findutils
	app-arch/tar
	app-arch/gzip
	sys-apps/coreutils
	sys-devel/patch
	sys-devel/gettext"

# no I haven't checked every virtual/glibc instead of sys-libs/glibc - will check it on itself if
# time/curiosity permits.

RDEPEND=""

PROVIDE="virtual/glibc"

S=${WORKDIR}/buildroot


# MAKEOPTS="${MAKEOPTS} -j1"

uclibc_var_setup() {

	einfo "You can set the TARGET_ARCH env varible to secify"
	einfo "the target architecture for the uclibc (cross-)compiler"
	einfo ""
	einfo "Examples: i386,arm,mips,mipsel"

	TARGETARCH=${TARGET_ARCH}

	if [ -z "${TARGETARCH}" ]; then
		# extract out of /etc/embedded/uClibc.conf if exists
		if [ -f /etc/embedded/uClibc.conf ]; then
			# TODO replace with sed to elminate quotes
			local ARCHCOM=$(grep '^TARGET_ARCH=' /etc/embedded/uClibc.conf)
			TARGETARCH=${ARCHCOM:12}
		else
			TARGETARCH=$(extract-arch `/bin/uname -m`)
		fi
	else
		TARGETARCH=$(extract-arch ${TARGETARCH})
	fi

	# The crosscompile.eclass isn't the definitive
	# authority on what uclibc can compile to.

	if [ "${TARGETARCH}" != "unknown" ]; then
		einfo ""
		einfo "Architecture for ${TARGETARCH}"
	else
		ewarn "Bad architecture <${TARGET_ARCH}>??? attempting anyway"
		# Do anyway??
		TARGETARCH=${TARGET_ARCH}
	fi
	UCLIBCDIR=${S}/build_${TARGETARCH}/uClibc-${UCLIBCVER}
}

uclibc_config_option() {
	#[ "$2" = "" ] && return 1
	#case $1 in
	#	y) /bin/sed -i -e "s:.*$2.*:$2=y:g" .config;;
	#	n) /bin/sed -i -e "s:.*$2.*:$2=n:g" .config;;
	#	*) return 1;;
	#esac
	/bin/sed -i -e "s:#.* $2 .*:$2=$1:g" \
		-e "s:^$2=.*:$2=$1:g" .config

	# TODO line below should be unnecessary
	#echo $2=$1 >> .config

	conf=`grep -E ^$2= .config`
	if [ -z "${conf}" ]; then
		echo $2=$1 >> .config
		einfo $2=$1
	else
		einfo $conf
	fi
}


src_unpack() {
	uclibc_var_setup
	unpack buildroot-${PV}.tar.bz2

	cd ${S}

	[ `use pie` && TARGETARCH!="i386" ] && die "pie use flag can only be used on i386 architectures"

	sed -i -e "s/^ARCH:=\(.*\)/#ARCH:=\1/g" Makefile
	sed -i -e "s/^#ARCH:=\(i386\)/ARCH:=${TARGETARCH}\n#ARCH:=\1/1" Makefile

	sed -i \
		-e "s#^USE_UCLIBC_SNAPSHOT:=.*#USE_UCLIBC_SNAPSHOT:=false#" \
		-e "s#^USE_BUSYBOX_SNAPSHOT:=.*#USE_BUSYBOX_SNAPSHOT:=false#" \
		-e "s#^DL_DIR:=.*#DL_DIR:=${DISTDIR}#" \
		-e "s#^WGET:=.*#WGET:=/bin/true#" \
		-e 's#tar #tar --no-same-owner #' \
		-e "s#^STAGING_DIR=.*#STAGING_DIR=${S}/staging_dir#"  \
		-e "s/^#JLEVEL=.*/JLEVEL=${MAKEOPTS}/" \
		-e 's#^TARGETS+=.*root##' \
		-e 's#TARGETS+=busybox.*##' \
		-e 's#INSTALL_LIBSTDCPP:=.*#INSTALL_LIBSTDCPP:=false#' \
		Makefile

# INSTALL_LIBSTDCPP disabled for testing only


	use softfloat && sed -i -e "s/^SOFT_FLOAT:=.*/SOFT_FLOAT:=true/" Makefile \
		|| sed -i -e "s/^SOFT_FLOAT:=.*/SOFT_FLOAT:=false/" Makefile


	#Version fix for busybox
	#
	#sed -i -e "s#^BUSYBOX_DIR:=\(.*\)/busybox.*#BUSYBOX_DIR:=\1/busybox-${BUSYBOXVER}#" \
	#	-e "s#^BUSYBOX_SOURCE:=busybox-.*#BUSYBOX_SOURCE:=busybox-${BUSYBOXVER}.tar.gz#" \
	#	-e "s#^BUSYBOX_UNZIP.*#BUSYBOX_UNZIP:=gzcat#" make/busybox.mk


	# Tinylogin fix.
	sed -i -e "s#^USE_TINYLOGIN_SNAPSHOT=.*#USE_TINYLOGIN_SNAPSHOT=false#" make/tinylogin.mk

# TODO (maybe?) fix HOSTARCH:= in Makefile

	cat << EOF >> Makefile

# ADDED BY the uClibc-buildroot - ebuild.

patched: \$(LINUX_DIR)/.unpacked \$(BUILD_DIR) \
	 \$(STAGING_DIR) \$(TARGET_DIR) \$(TOOL_BUILD_DIR)  \
	\$(GCC_DIR)/.patched \$(BINUTILS_DIR)/.patched \
	\$(UCLIBC_DIR)/.unpacked

#	\$(TOOL_BUILD_DIR)  \
#
#busybox-defconf:
#	\$(MAKE) CC=\$(TARGET_CC) CROSS="\$(TARGET_CROSS)" -C \$(BUSYBOX_DIR) defconfig
#	touch \$(BUSYBOX_DIR)/.configured

#busybox-oldconf:
#	cp \$(BUSYBOX_CONFIG) \$(BUSYBOX_DIR)/Config.h
#	\$(MAKE) CC=\$(TARGET_CC) CROSS="\$(TARGET_CROSS)" -C \$(BUSYBOX_DIR) oldconfig
#	touch \$(BUSYBOX_DIR)/.configured

uclibc-defconfig:
	touch \$(UCLIBC_DIR)/.configured

# \$(MAKE) -C \$(UCLIBC_DIR) HAVE_DOT_CONFIG=y headers shared

gcchacks: \$(GCC_DIR)/.gcc3_3_build_hacks


#TO FINISH

all-compile: uclibc-defconfig \$(BINUTILS_DIR1)/binutils/objdump \
	\$(GCC_BUILD_DIR1)/.compiled

extras-compile: \$(TINYLOGIN_DIR)/tinylogin
	\$(MAKE) CC=\$(TARGET_CC) CROSS="\$(TARGET_CROSS)" PREFIX="\$(TARGET_DIR)" \
		-C \$(BUSYBOX_DIR)

all-install:  \$(STAGING_DIR)  \$(TARGET_DIR) \
	\$(STAGING_DIR)/lib/libc.a \$(STAGING_DIR)/bin/\$(ARCH)-linux-gcc
	\$(MAKE) -C \$(UCLIBC_DIR) PREFIX=\$(STAGING_DIR) install_dev

extras-install: \$(TARGET_DIR)/bin/busybox \$(TARGET_DIR)/bin/tinylogin


EOF

	# "cp -a" implies --preserve=ownership which is blocked by sandbox

	sed -i -e 's#tar #tar --no-same-owner #' \
		-e 's#cp -a#cp --preserve=mode -dPR#g' \
		make/*.mk

	# Stop uclib.mk clobbering our config
	sed -i -e 's#cp.*config#/bin/true#g' make/uclibc.mk

	emake SED="/bin/sed -i -e" patched || die "failed to patch uclibc buildroot"

	# these hacks affect the search path of the uclibc-toolchain to prevent
	# leakage of gcclibs into the target

#	sed -i -e \
#"/DIR2)\/\.configured/,/DIR2)\/.configured/ s/--\(.*\)=\$(STAGING_DIR)/--\1=\/usr\/${TARGETARCH}-uclibc/g" \
#-e "/DIR2)\/\.installed:/,/\.installed/ s/\$(MAKE)/\$(MAKE) DESTDIR=\$(STAGING_DIR)/" \
#-e 's#\$(STAGING_DIR)/lib/\(libstdc++.*\)# $(GCC_BUILD_DIR2)/$(ARCH)-linux/libstdc++-v3/src/.libs/\1#' \
#		make/gcc-uclibc-3.3.mk

	#emake SED="/bin/sed -i -e" STAGING_DIR=/usr/${TARGETARCH}-uclibc-linux gcchacks

	sed -i -e 's#cp -fa#cp --preserve=mode -dPRf#g' ${UCLIBCDIR}/Makefile

	cd ${UCLIBCDIR}
	local patches="uClibc-0.9.26-Makefile.patch uClibc-${PV}-pie-option.patch"

	for patch in ${patches} ; do
		[ -f ${FILESDIR}/${UCLIBCVER}/${patch} ] && epatch ${FILESDIR}/${UCLIBCVER}/${patch}
	done

	sed -i -e "s#^LOCALE_DATA_FILENAME:=#LOCALE_DATA_FILENAME:=${DISTDIR}/#" \
		-e "s#^WGET:=.*#WGET:=/bin/true#" Makefile
}

src_compile() {
	uclibc_var_setup
	export SED="/bin/sed -i -e"
	emake CROSS= host-sed  || die "host-sed make failed"

	use nls && sed -i -e "s/^ENABLE_LOCALE.*/ENABLE_LOCALE:=true/" Makefile \
		|| sed -i -e "s/^ENABLE_LOCALE.*/ENABLE_LOCALE:=false/" Makefile

	local uconfig;
	use nls && uconfig="sources/uClibc.config-locale" || uconfig="sources/uClibc.config"

	cd ${UCLIBCDIR}


	# restore last config
	if [ -f /etc/embedded/uClibc.config ]; then
		cp /etc/embedded/uClibc.config ${uconfig}
	else
		# or make the default with a few changes
		emake defconfig || die "Could not make uclibc default config"

		uclibc_config_option n MALLOC_GLIBC_COMPAT
		uclibc_config_option y DO_C99_MATH
		uclibc_config_option y UCLIBC_HAS_RPC
		uclibc_config_option n UCLIBC_HAS_CTYPE_UNSAFE
		uclibc_config_option y UCLIBC_HAS_CTYPE_CHECKED
		uclibc_config_option y UCLIBC_HAS_WCHAR
		uclibc_config_option y UCLIBC_HAS_HEXADECIMAL_FLOATS
		uclibc_config_option y UCLIBC_HAS_GLIBC_CUSTOM_PRINTF
		uclibc_config_option y UCLIBC_HAS_FOPEN_EXCLUSIVE_MODE
		uclibc_config_option y UCLIBC_HAS_GLIBC_CUSTOM_STREAMS
		uclibc_config_option y UCLIBC_HAS_PRINTF_M_SPEC
		uclibc_config_option y UCLIBC_HAS_FTW
		uclibc_config_option y UNIX98PTY_ONLY
		uclibc_config_option n UCLIBC_HAS_TZ_FILE_READ_MANY
		uclibc_config_option y UCLIBC_HAS_LFS
	fi

	/bin/sed -i -e 's,^.*TARGET_$(UCLIBC_TARGET_ARCH).*,TARGET_$(TARGETARCH)=y,g' \
		-e 's,^TARGET_ARCH.*,TARGET_ARCH=\"$(TARGETARCH)\",g' \
		-e "s,^KERNEL_SOURCE=.*,KERNEL_SOURCE=\"${WORKDIR}/linux\"," \
		-e 's,^RUNTIME_PREFIX=.*,RUNTIME_PREFIX=\"/\",g' \
		-e 's,^DEVEL_PREFIX=.*,DEVEL_PREFIX=\"/usr/\",g' \
		-e 's,^SHARED_LIB_LOADER_PREFIX=.*,SHARED_LIB_LOADER_PREFIX=\"/lib\",g' \
		-e 's,^.*UCLIBC_HAS_LFS.*,UCLIBC_HAS_LFS=y,g' .config

	if [ `use debug` ]; then
		uclibc_config_option y DODEBUG
		uclibc_config_option y PTHREADS_DEBUG_SUPPORT
	# Other possibe options for debug use flag
	# DOASSERTS
	# SUPPORT_LD_DEBUG
	# SUPPORT_LD_DEBUG_EARLY
	# PTHREADS_DEBUG_SUPPORT
	else
		uclibc_config_option  n DODEBUG
		uclibc_config_option  n PTHREADS_DEBUG_SUPPORT
	fi

	[ `use ipv6` ] && uclibc_config_option y UCLIBC_HAS_IPV6 || \
		uclibc_config_option n UCLIBC_HAS_IPV6

	[ `use fullrpc` ] && uclibc_config_option y UCLIBC_HAS_FULL_RPC || \
		uclibc_config_option n UCLIBC_HAS_FULL_RPC

	[ `use nommu` ] && uclibc_config_option n UCLIBC_HAS_MMU || \
		uclibc_config_option n UCLIBC_HAS_MMU


	# Thanks peter for pointing this one out.
	#[ `use etdyn` ] && uclibc_config_option n CONFIG_PROFILING

	if [ `use pie` ]; then
		uclibc_config_option y UCLIBC_PIE_SUPPORT
		uclibc_config_option y UCLIBC_COMPLETELY_PIC
	else
		uclibc_config_option n UCLIBC_PIE_SUPPORT
		uclibc_config_option n UCLIBC_COMPLETELY_PIC
	fi

	[ `use propolice` ] && uclibc_config_option y UCLIBC_PROPOLICE || \
		uclibc_config_option n UCLIBC_PROPOLICE

	if [ `use softfloat` ]; then
		uclibc_config_option n HAS_FPU
		uclibc_config_option y UCLIBC_HAS_FLOATS
		uclibc_config_option y UCLIBC_HAS_SOFT_FLOAT
	#else
		#TODO for completeness
	fi


	uclibc_config_option n UCLIBC_PREGENERATED_LOCALE_DATA
	uclibc_config_option n UCLIBC_DOWNLOAD_PREGENERATED_LOCALE_DATA

	if [ `use nls` ]; then
		uclibc_config_option y UCLIBC_HAS_LOCALE

		#pregen is for i386 architectures only
		if [ ${TARGETARCH}=="i386" ]; then
			uclibc_config_option y UCLIBC_PREGENERATED_LOCALE_DATA
			uclibc_config_option y UCLIBC_DOWNLOAD_PREGENERATED_LOCALE_DATA
			cp ${DISTDIR}/uClibc-locale-030818.tgz ${UCLIBCDIR}/extra/locale
		else
			uclibc_config_option n UCLIBC_PREGENERATED_LOCALE_DATA
			uclibc_config_option n UCLIBC_DOWNLOAD_PREGENERATED_LOCALE_DATA
			pushd extra/locale
			find charmaps -name "*.pairs" > codesets.txt
			emake clean all || die "Could not generate codepages"
			popd
		fi
		uclibc_config_option y UCLIBC_HAS_XLOCALE
		uclibc_config_option y UCLIBC_HAS_HEXADECIMAL_FLOATS
		uclibc_config_option y UCLIBC_HAS_GLIBC_DIGIT_GROUPING
		uclibc_config_option y UCLIBC_HAS_SCANF_LENIENT_DIGIT_GROUPING
		uclibc_config_option y UCLIBC_HAS_GETTEXT_AWARENESS
		# lots of stuff from uclibc.spec - TODO LATER
	else
		uclibc_config_option n UCLIBC_HAS_LOCALE
		uclibc_config_option n UCLIBC_PREGENERATED_LOCALE_DATA
		uclibc_config_option n UCLIBC_DOWNLOAD_PREGENERATED_LOCALE_DATA
		uclibc_config_option n UCLIBC_HAS_XLOCALE
		uclibc_config_option n UCLIBC_HAS_HEXADECIMAL_FLOATS
		uclibc_config_option n UCLIBC_HAS_GLIBC_DIGIT_GROUPING
		uclibc_config_option n UCLIBC_HAS_SCANF_LENIENT_DIGIT_GROUPING
		uclibc_config_option n UCLIBC_HAS_GETTEXT_AWARENESS
	fi


	cd ${S}
	emake -j1 || die "Could not make uclibc-buildroot"

	if [ -n "`use debug`" ]; then
		if [ -f /etc/embedded/busybox.config ]; then
			emake BUSYBOX_CONFIG=/etc/embedded/busybox.config busybox- \
				|| "Error making busybox old config"
		else
			emake  busybox || "Error making busybox default config"
		fi

		[ -f /etc/embedded/tinylogin.config ] && \
			cp /etc/embedded/tinylogin.config build_${TARGETARCH}/tinylogin-${TINYLOGINVER}/Config.h

		emake extras-compile
	fi
	cd ${UCLIBCDIR}
	local patches="uClibc-${PV}-pie-option.patch"

	for patch in ${patches} ; do
		[ -f ${FILESDIR}/${UCLIBCVER}/${patch} ] && epatch ${FILESDIR}/${UCLIBCVER}/${patch}
	done
}

src_install() {
	uclibc_var_setup
	# later once compile/install separation is done
	#emake all-installed

	use debug && emake extras-installed

	local BINPREFIX=${TARGETARCH}-linux-uclibc

	#rm -rf ${S}staging_dir/usr/include ${S}staging_dir/usr/lib
	rm -f ${S}/staging_dir/bin/sed

	dodir /usr/${BINPREFIX}

	cd staging_dir

	# there's probably a better way to do this but it was giving me the
	# sh?ts trying to find it. usr/bin got mapped to bin in most cases.
	mv info share

	tar -cf - lib/ usr/bin/ bin/ ${BINPREFIX} ${TARGETARCH}-linux \
		include/ | \
		tar --no-same-owner -C ${D}/usr/${BINPREFIX} -xf -

	tar -cf - usr/${BINPREFIX} | \
		tar --no-same-owner -C ${D} -xf -

	doman `find man -type f -name "*.[0-9]"`

	# gcc-config stuff
	local gccconfigfile=${D}/etc/env.d/gcc/${ARCH}-uclibc-${UCLIBCVER}

	dodir /etc/env.d/gcc
	echo "PATH=\"/usr/${BINPREFIX}/usr/bin\"" > ${gccconfigfile}
	echo "ROOTPATH=\"/usr/${BINPREFIX}/usr/bin\"" >> ${gccconfigfile}
	echo "LDPATH=\"/usr/${BINPREFIX}/lib\"" >> ${gccconfigfile}
	echo 'CC="gcc"'  >> ${gccconfigfile}
	echo 'CXX="g++"'  >> ${gccconfigfile}

	# warning- consistancy with Makefile uncertian.
	#use softfloat && ARCH="${TARGETARCH}_nofpu"

	# rootfs (tempory for testing purposes)
	dodir /var/lib/rootfs_${TARGETARCH}

	cp --preserve=mode -dPRf ${S}/build_${TARGETARCH}/root/* ${D}/var/lib/rootfs_${TARGETARCH}

	# Save uclibc/busybox/tinylogin config

	dodir /etc/embedded
	cp ${S}/.config ${D}/etc/embedded/uClibc.config

	[ -f ${S}/build_${ARCH}/busybox-${BUSYBOXVER}/Config.h ] && \
		cp ${S}/build_${ARCH}/busybox-${BUSYBOXVER}/Config.h ${D}/etc/embedded/busybox.config

	[ -f ${S}/build_${ARCH}/tinylogin-${TINYLOGINVER}/Config.h ] && \
		cp ${S}/build_${ARCH}/tinylogin-${TINYLOGINVER}/Config.h ${D}/etc/embedded/tinylogin.config


}
