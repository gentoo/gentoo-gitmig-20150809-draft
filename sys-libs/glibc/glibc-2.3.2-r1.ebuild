# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.3.2-r1.ebuild,v 1.2 2003/04/19 19:37:34 method Exp $

IUSE="nls pic build nptl"

inherit eutils flag-o-matic gcc

filter-flags "-fomit-frame-pointer -malign-double"

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
strip-flags

# Lock glibc at -O2 -- linuxthreads needs it and we want to be conservative here
export CFLAGS="${CFLAGS//-O?} -O2"
export CXXFLAGS="${CFLAGS}"

NPTL_VER="0.29"

# Minimum kernel version for --enable-kernel
export MIN_KV="2.4.1"
# Minimum kernel version for enabling TLS and NPTL ...
# NOTE: do not change this if you do not know what
#       you are doing !
export MIN_NPTL_KV="2.5.50"

MY_PV="${PV/_}"
S="${WORKDIR}/${P%_*}"
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="http://ftp.gnu.org/gnu/glibc/glibc-${MY_PV}.tar.bz2
	ftp://sources.redhat.com/pub/glibc/snapshots/glibc-${MY_PV}.tar.bz2
	http://ftp.gnu.org/gnu/glibc/glibc-linuxthreads-${MY_PV}.tar.bz2
	ftp://sources.redhat.com/pub/glibc/snapshots/glibc-linuxthreads-${MY_PV}.tar.bz2
	nptl? ( http://people.redhat.com/drepper/nptl/nptl-${NPTL_VER}.tar.bz2 )"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

KEYWORDS="~x86 ~ppc -sparc ~alpha ~hppa ~arm"
# Is 99% compadible, just some .a's bork
SLOT="2.2"
LICENSE="GPL-2"

# Portage-1.8.9 needed for smart library merging feature (avoids segfaults on glibc upgrade)
# Drobbins, 18 Mar 2002: we now rely on the system profile to select the correct linus-headers
DEPEND=">=sys-devel/gcc-3.2.2
	nptl? ( >=sys-devel/gcc-3.2.2-r1 )
	>=sys-devel/binutils-2.13.90.0.18
	virtual/os-headers
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/os-headers
	sys-apps/baselayout
	nls? ( sys-devel/gettext )
	build? ( >=sys-apps/portage-1.9.0 )"

PROVIDE="virtual/glibc"


# Convert a string type kernel version (2.4.0) to an int (132096)
# for easy compairing or versions ...
KV_to_int() {
	[ -z "$1" ] && return 1
	
	local KV="`echo $1 | \
		awk '{ tmp = $0; gsub(/^[0-9\.]*/, "", tmp); sub(tmp, ""); print }'`"
	local KV_MAJOR="`echo "${KV}" | cut -d. -f1`"
	local KV_MINOR="`echo "${KV}" | cut -d. -f2`"
	local KV_MICRO="`echo "${KV}" | cut -d. -f3`"
	local KV_int="$((KV_MAJOR * 65536 + KV_MINOR * 256 + KV_MICRO))"

	# We make version 2.2.0 the minimum version we will handle as
	# a sanity check ... if its less, we fail ...
	if [ "${KV_int}" -ge "131584" ]
	then
		echo "${KV_int}"

		return 0
	else
		return 1
	fi
}

get_KV() {
	local KV="`uname -r`"

	echo "`KV_to_int ${KV}`"

	return $?
}

# Try to get a kernel source tree with version equal or greater
# than $1.  We basically just try a few default locations.  The
# version need to be that which KV_to_int() returns ...
get_KHV() {
	local headers=""
	
	[ -z "$1" ] && return 1
	
	# - First check if linux-headers are installed (or symlink
	#   to current kernel ...)
	# - Ok, do we have access to the current kernel's headers ?
	# - Last option ... maybe its a weird bootstrap with /lib
	#   binded to the chroot ...

	# We do not really support more than 2 arguments ...
	if [ -n "$2" ]
	then
		headers="$2"
	else
		# We try to find the current kernel's headers first,
		# as we would rather build against linux 2.5 headers ...
		headers="/lib/modules/`uname -r`/build/include \
		         ${ROOT}/lib/modules/`uname -r`/build/include \
				 /usr/src/linux/include \
				 ${ROOT}/usr/src/linux/include \
		         ${ROOT}/usr/include"
	fi

	for x in ${headers}
	do
		local header="${x}/linux/version.h"
		
		if [ -f ${header} ]
		then
		
			local version="`grep 'LINUX_VERSION_CODE' ${header} | \
				sed -e 's:^.*LINUX_VERSION_CODE[[:space:]]*::'`"

			if [ "${version}" -ge "$1" ]
			then
				echo "${x}"
			
				return 0
			fi
		fi
	done

	return 1
}

use_nptl() {
	# Enable NPTL support if:
	# - We have 'nptl' in USE
	# - We have 'x86' in USE
	# - We have linux-2.4 or later kernel (should prob check for 2.4.20 ...)
	# - We have a CHOST of "i686-pc-linux-gnu"
	if [ -n "`use nptl`" -a "`use x86`" -a \
	     "`get_KV`" -ge "`KV_to_int ${MIN_NPTL_KV}`" -a "${CHOST/-*}" = "i686" ]
	then
		return 0
	else
		return 1
	fi
}

pkg_setup() {
	# We need gcc 3.2 or later ...
	if [ "`gcc-major-version`" -ne "3" -o "`gcc-minor-version`" -lt "2" ]
	then
		echo
		eerror "As of glibc-2.3, gcc-3.2 or later is needed"
		eerror "for the build to succeed."
		die "GCC too old"
	fi

	if use_nptl
	then
		echo

		# The use_nptl should have already taken care of kernel version,
		# arch and CHOST, so now just check if we can find suitable kernel
		# source tree or headers ....
		einfon "Checking for sufficient version kernel headers ... "
		if ! get_KHV "`KV_to_int ${MIN_NPTL_KV}`" &> /dev/null
		then
			echo "no"
			echo
			eerror "Could not find a kernel source tree or headers with"
			eerror "version ${MIN_NPTL_KV} or later!  Please correct this"
			eerror "and try again."
			die "Insufficient kernel headers present!"
		else
			echo "yes"
		fi
		
		einfon "Checking gcc for __thread support ... "
		if ! gcc -c ${FILESDIR}/test-__thread.c -o ${T}/test.o &> /dev/null
		then
			echo "no"
			echo
			eerror "Could not find a gcc that supports the __thread directive!"
			eerror "please update to gcc-3.2.2-r1 or later, and try again."
			die "No __thread support in gcc!"
		else
			echo "yes"
		fi

		# Default disclaimer ...
		echo
		ewarn "Please note that NPTL support is still very experimental,"
		ewarn "and could break your system!  Press ^C now if you do not know"
		ewarn "what you are doing, and remove \"nptl\" from your USE ..."
		echo
		ewarn "As a final note ... it does NOT work with NVidia GLX!!"
		sleep 5
	
	elif use nptl &> /dev/null
	then
		# Just tell the user not to expect too much ...
		ewarn "You have \"nptl\" in your USE, but your kernel version or"
		ewarn "architecture do not support it!"
	fi
}

src_unpack() {
        if [ `is-flag "-fstack-protector"` -a  `has "sandbox" $FEATURES` ]
        then
                eerror "You have both -fstack-protector and sandbox enabled"
                eerror "glibc will not compile correctly with both of these enabled"
                eerror "Please disable sandbox by calling emerge with FEATURES=\"-sandbox\""
                die
        fi

	unpack glibc-${MY_PV}.tar.bz2
	
	# Extract pre-made man pages.  Otherwise we need perl, which is a no-no.
	mkdir -p ${S}/man; cd ${S}/man
	use_nptl || tar xjf ${FILESDIR}/glibc-manpages-${MY_PV}.tar.bz2
	
	cd ${S}
	# Extract our threads package ...
	if use_nptl
	then
		unpack nptl-${NPTL_VER}.tar.bz2
	else
		unpack glibc-linuxthreads-${MY_PV}.tar.bz2
	fi

	# This next patch fixes a test that will timeout due to ReiserFS' slow handling of sparse files
#	cd ${S}/io; epatch ${FILESDIR}/glibc-2.2.2-test-lfs-timeout.patch

	# This add back glibc 2.2 compadibility.  See bug #8766 and #9586 for more info,
	# and also:
	#
	#  http://lists.debian.org/debian-glibc/2002/debian-glibc-200210/msg00093.html
	#
	# We should think about remoing it in the future after things have settled.
	#
	# Thanks to Jan Gutter <jangutter@tuks.co.za> for reporting it.
	#
	# <azarah@gentoo.org> (26 Oct 2002).
	cd ${S}; epatch ${FILESDIR}/2.3.1/${PN}-2.3.1-ctype-compat-v3.patch

	# One more compat issue which breaks sun-jdk-1.3.1.  See bug #8766 for more
	# info, and also:
	#
	#   http://sources.redhat.com/ml/libc-alpha/2002-04/msg00143.html
	#
	# Thanks to Jan Gutter <jangutter@tuks.co.za> for reporting it.
	#
	# <azarah@gentoo.org> (30 Oct 2002).
	cd ${S}; epatch ${FILESDIR}/2.3.1/${PN}-2.3.1-libc_wait-compat.patch

	# One more compat issue ... libc_stack_end is missing from ld.so.
	# Got this one from diffing redhat glibc tarball .. would help if
	# they used patches and not modified tarball ...
	#
	# <azarah@gentoo.org> (7 Nov 2002).
	cd ${S}; epatch ${FILESDIR}/2.3.1/${PN}-2.3.1-stack_end-compat.patch

	# Fix calculation problems in allocate_static_tls that caused a TLS
	# enabled app that loads libGL.so to segfault.  Thanks to Gareth Hughes
	# from NVidia for pointing me in the right direction.  This patch is
	# from glibc CVS.
	#
	# <azarah@gentoo.org> (6 Apr 2003).
	cd ${S}; epatch ${FILESDIR}/${PV}/${P}-dl-reloc-calc-fix.patch
}

setup_flags() {
	# -freorder-blocks for all but ia64 s390 s390x
	use ppc || append-flags "-freorder-blocks"

	# Sparc support ...
	replace-flags "-mcpu=ultrasparc" "-mcpu=v8 -mtune=ultrasparc"
	replace-flags "-mcpu=v9" "-mcpu=v8 -mtune=v9"

	# -mvis for sparc64 (should this be always, or only with 64bit userspace ?
	[ "${PROFILE_ARCH}" = "sparc64" ] && append-flags "-mvis"

	# -fcall-used-g7 for sparc and sparc64
	use sparc && append-flags "-fcall-used-g7"
}

src_compile() {
	local myconf=""
	local myconf_nptl=""

	setup_flags

	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL

	use nls || myconf="${myconf} --disable-nls"

	if use_nptl
	then
		local kernelheaders="$(get_KHV "`KV_to_int ${MIN_NPTL_KV}`")"
		
		# NTPL and Thread Local Storage support.
		myconf="${myconf} --with-tls --with-__thread \
		                       --enable-add-ons=nptl \
		                       --enable-kernel=${MIN_NPTL_KV} \
		                       --with-headers=${kernelheaders}"
	else
		myconf="${myconf} --without-tls --without-__thread \
		                  --enable-add-ons=linuxthreads"

		# If we build for the build system we use the kernel headers from the target
		# We also now set it without "build" as well, else it might use the
		# current kernel's headers, which might just fail (the linux-headers
		# package is usually well tested...)
#		( use build || use sparc ) \
#			&& myconf="${myconf} --with-headers=${ROOT}usr/include"
		myconf="${myconf} --with-headers=${ROOT}usr/include"

		# If kernel version and headers in ${ROOT}/usr/include are ok,
		# then enable --enable-kernel=${MIN_KV} ...
		if [ "`get_KV`" -ge "`KV_to_int ${MIN_KV}`" -a \
		     -n "$(get_KHV "`KV_to_int ${MIN_KV}`" "${ROOT}/usr/include")" ]
		then
			myconf="${myconf} --enable-kernel=${MIN_KV}"
		else
			myconf="${myconf} --enable-kernel=2.2.5"
		fi
	fi

	einfo "Configuring GLIBC..."
	rm -rf ${S}/buildhere
	mkdir -p ${S}/buildhere
	cd ${S}/buildhere
	../configure --build=${CHOST} \
		--host=${CHOST} \
		--with-gd=no \
		--without-cvs \
		--disable-profile \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--libexecdir=/usr/lib/misc \
		${myconf} || die

	einfo "Building GLIBC..."
	cd ${S}/buildhere
	make PARALLELMFLAGS="${MAKEOPTS}" || die
#	einfo "Doing GLIBC checks..."
#	make check
}

src_install() {
	local buildtarget="buildhere"
	
	setup_flags
	
	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL

	einfo "Installing GLIBC..."
	make PARALLELMFLAGS="${MAKEOPTS}" \
		install_root=${D} \
		install -C ${buildtarget} || die

	# If librt.so is a symlink, change it into linker script (Redhat)
	if [ -L ${D}/usr/lib/librt.so ]
	then
		local LIBRTSO="`cd ${D}/lib; echo librt.so.*`"
		local LIBPTHREADSO="`cd ${D}/lib; echo libpthread.so.*`"

		rm -f ${D}/usr/lib/librt.so
		cat > ${D}/usr/lib/librt.so <<EOF
/* GNU ld script
   librt.so.1 needs libpthread.so.0 to come before libc.so.6*
   in search scope.  */
EOF
		grep "OUTPUT_FORMAT" ${D}/usr/lib/libc.so >> ${D}/usr/lib/librt.so
		echo "GROUP ( /lib/${LIBPTHREADSO} /lib/${LIBRTSO} )" \
			>> ${D}/usr/lib/librt.so
	fi

	if [ -z "`use build`" ]
	then
		einfo "Installing Info pages..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			info -C ${buildtarget} || die
		
		einfo "Installing Locale data..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			localedata/install-locales -C ${buildtarget} || die

		# Compatibility hack: this locale has vanished from glibc,
		# but some other programs are still using it.
		keepdir /usr/lib/locale/ru_RU/LC_MESSAGES

		einfo "Installing man pages and docs..."
		# Install linuxthreads man pages
		use_nptl || {
			dodir /usr/share/man/man3
			doman ${S}/man/*.3thr
		}
		
		# Install nscd config file
		insinto /etc
		doins ${FILESDIR}/nscd.conf
		
		dodoc BUGS ChangeLog* CONFORMANCE COPYING* FAQ INTERFACE \
			NEWS NOTES PROJECTS README*
	else
		rm -rf ${D}/usr/share ${D}/usr/lib/gconv

		einfo "Installing Timezone data..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			timezone/install-others -C ${buildtarget} || die
	fi
	
	if [ "`use pic`" ] 
	then
		find ${S}/${buildtarget}/ -name "soinit.os" -exec cp {} ${D}/lib/soinit.o \;
		find ${S}/${buildtarget}/ -name "sofini.os" -exec cp {} ${D}/lib/sofini.o \;
		find ${S}/${buildtarget}/ -name "*_pic.a" -exec cp {} ${D}/lib \;
		find ${S}/${buildtarget}/ -name "*.map" -exec cp {} ${D}/lib \;
		for i in ${D}/lib/*.map
		do
			mv ${i} ${i%.map}_pic.map
		done
	fi

	# Is this next line actually needed or does the makefile get it right?
	# It previously has 0755 perms which was killing things.
	fperms 4755 /usr/lib/misc/pt_chown

	# Currently libraries in  /usr/lib/gconv do not get loaded if not
	# in search path ...
#	insinto /etc/env.d
#	doins ${FILESDIR}/03glibc
	
	rm -f ${D}/etc/ld.so.cache

	# Prevent overwriting of the /etc/localtime symlink.  We'll handle the
	# creation of the "factory" symlink in pkg_postinst().
	rm -f ${D}/etc/localtime

	# Some things want this, notably ash.
	dosym /usr/lib/libbsd-compat.a /usr/lib/libbsd.a
}

pkg_postinst() {
	# Correct me if I am wrong here, but my /etc/localtime is a file
	# created by zic ....
	# I am thinking that it should only be recreated if no /etc/localtime
	# exists, or if it is an invalid symlink.
	#
	# For invalid symlink:
	#   -f && -e  will fail
	#   -L will succeed
	#
	if [ ! -e ${ROOT}/etc/localtime ]
	then
		echo "Please remember to set your timezone using the zic command."
		rm -f ${ROOT}/etc/localtime
		ln -s ../usr/share/zoneinfo/Factory ${ROOT}/etc/localtime
	fi

	if [ -x ${ROOT}/usr/sbin/iconvconfig ]
	then
		# Generate fastloading iconv module configuration file.
		${ROOT}/usr/sbin/iconvconfig --prefix=${ROOT}
	fi

	# Reload init ...
	if [ "${ROOT}" = "/" ]
	then
		/sbin/init U &> /dev/null
	fi
}

