# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.2.5-r8.ebuild,v 1.8 2003/05/18 22:22:50 azarah Exp $

IUSE="nls pic build"

inherit flag-o-matic gcc

filter-flags "-fomit-frame-pointer -malign-double"

# Sparc support
replace-flags "-mcpu=ultrasparc" "-mcpu=v8 -mtune=ultrasparc"
replace-flags "-mcpu=v9" "-mcpu=v8 -mtune=v9"

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

S="${WORKDIR}/${P}"
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="ftp://sources.redhat.com/pub/glibc/releases/glibc-${PV}.tar.bz2
	 ftp://sources.redhat.com/pub/glibc/releases/glibc-linuxthreads-${PV}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

KEYWORDS="x86 ppc sparc alpha arm"
SLOT="2.2"
LICENSE="LGPL-2"

# Portage-1.8.9 needed for smart library merging feature (avoids segfaults on glibc upgrade)
# drobbins, 18 Mar 2002: we now rely on the system profile to select the correct linus-headers
DEPEND="virtual/os-headers
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/os-headers
	sys-apps/baselayout
	nls? ( sys-devel/gettext )
	build? ( >=sys-apps/portage-1.9.0 )"

PROVIDE="virtual/glibc"

# Lock glibc at -O2 -- linuxthreads needs it and we want to be conservative here
export CFLAGS="${CFLAGS//-O?} -O2"
export CXXFLAGS="${CFLAGS}"

src_unpack() {
	unpack glibc-${PV}.tar.bz2 || die
	cd ${S}

	# Security
	# Fix for http://www.cert.org/advisories/CA-2003-10.html
	einfo "Applying glibc-xdr_security.patch"
	patch -p1 < ${FILESDIR}/glibc-xdr_security.patch > /dev/null || die

	#extract pre-made man pages.  Otherwise we need perl, which is a no-no.
	mkdir man; cd man
	tar xjf ${FILESDIR}/glibc-manpages-${PV}.tar.bz2 > /dev/null || die
	cd ${S}
	unpack glibc-linuxthreads-${PV}.tar.bz2 || die
	
	# This patch apparently eliminates compiler warnings for some versions of gcc.
	# For information about the string2 patch, see: 
	# http://lists.gentoo.org/pipermail/gentoo-dev/2001-June/001559.html
	einfo "Applying string2.h patch..."
	cd ${S}; patch -p0 < ${FILESDIR}/glibc-2.2.4-string2.h.diff > /dev/null || die

	# This next one is a new patch to fix thread signal handling.  See:
	# http://sources.redhat.com/ml/libc-hacker/2002-02/msg00120.html
	# (Added by drobbins on 05 Mar 2002)
	einfo "Applying threadsig patch..."
	patch -p0 < ${FILESDIR}/${PV}/${P}-threadsig.diff > /dev/null || die

	# This next patch fixes a test that will timeout due to ReiserFS' slow handling of sparse files
	einfo "Applying test-lfs-timeout patch..."
	cd ${S}/io; patch -p0 < ${FILESDIR}/glibc-2.2.2-test-lfs-timeout.patch > /dev/null || die

	# A buffer overflow vulnerability exists in multiple implementations of DNS
	# resolver libraries.  This affects glibc-2.2.5 and earlier. See bug #4923
	# and:
	#
	#   http://www.cert.org/advisories/CA-2002-19.html
	einfo "Applying dns-network-overflow patch..."
	cd ${S}; patch -p1 < ${FILESDIR}/${PV}/${P}-dns-network-overflow.diff >	/dev/null || die

	# Security update for sunrpc
	# <aliz@gentoo.org>
	einfo "Applying sunrpc-overflow patch..."
	cd ${S}; patch -p1 < ${FILESDIR}/${PV}/${P}-sunrpc-overflow.diff > /dev/null || die

	if [ "${ARCH}" = "x86" -o "${ARCH}" = "ppc" ]; then
		# This patch fixes the nvidia-glx probs, openoffice and vmware probs and such..
		# http://sources.redhat.com/ml/libc-hacker/2002-02/msg00152.html
		einfo "Applying divdi3 patch..."
		cd ${S}; patch -p1 < ${FILESDIR}/${PV}/${P}-divdi3.diff > /dev/null || die
	fi

	if [ "${ARCH}" = "ppc" ]; then
	        # This patch fixes the absence of sqrtl on PPC
	        # http://sources.redhat.com/ml/libc-hacker/2002-05/msg00012.html
	        einfo "Applying ppc-sqrtl patch..."
	        cd ${S}; patch -p0 < ${FILESDIR}/${PV}/${P}-ppc-sqrtl.diff > /dev/null || die
	fi

	
	# Some gcc-3.1.1 fixes.  This works fine for other versions of gcc as well,
	# and should generally be ok, as it just fixes define order that causes scope
	# problems with gcc-3.1.1.
	# (Azarah, 14 Jul 2002)
	einfo "Applying gcc311 patch..."
	cd ${S}; patch -p1 < ${FILESDIR}/${PV}/${P}-gcc311.patch > /dev/null || die

	if [ "`gcc-major-version`" -eq "3" -a "`gcc-minor-version`" -ge "2" ]; then
		cd ${S}
		# http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2002/08/0228.html
		# <azarah@gentoo.org> (13 Oct 2002)
		einfo "Applying divbyzero patch..."
		patch -p1 < ${FILESDIR}/${PV}/${P}.divbyzero.patch > /dev/null || die
		einfo "Applying restrict_arr patch..."
		patch -p1 < ${FILESDIR}/${PV}/${P}.restrict_arr.patch > /dev/null || die
	fi

	# Some patches to fixup build on alpha
	if [ "${ARCH}" = "alpha" ]; then
		cd ${S}
		einfo "Applying alpha-gcc3-fix patch..."
		patch -p1 < ${FILESDIR}/${PV}/${P}-alpha-gcc3-fix.diff > /dev/null || die
		einfo "Applying alpha-pcdyn-fix patch..."
		patch -p1 < ${FILESDIR}/${PV}/${P}-alpha-pcdyn-fix.diff > /dev/null || die
	fi

	# Some patches to fixup build on sparc
	
	if use sparc > /dev/null
	then
		einfo "Applying sparc-mathinline patch..."
		cd ${S}; patch -p1 < ${FILESDIR}/${PV}/${P}-sparc-mathinline.patch > /dev/null || die

		einfo "Applying sparc-misc patch..."
		cd ${S}; patch -p1 < ${FILESDIR}/${PV}/${P}-sparc-misc.diff > /dev/null || die

		if [ "${PROFILE_ARCH}" = "sparc64" ]
		then
			einfo "Applying seemant's -fixups patch..."
			cd ${S}; patch -p1 < ${FILESDIR}/${PV}/${P}-sparc64-fixups.diff > /dev/null || die
		fi

		einfo "Applying nall's sparc32-semctl patch..."
		cd ${S} 
		patch -p1 < ${FILESDIR}/${PV}/${P}-sparc32-semctl.patch > /dev/null || die
	fi
	
	# Some patches to fixup build on arm
	if [ "${ARCH}" = "arm" ]; then
		cd ${S}
		einfo "Applying ARM sysdep patch..."
		patch -p0 < ${FILESDIR}/${PV}/${P}-arm-sysdeps-fix.diff || die
		einfo "Applying ARM errlist patch..."
		patch -p0 < ${FILESDIR}/${PV}/${P}-arm-errlist-fix.diff || die
	fi
}

src_compile() {
	local myconf=""

	# If we build for the build system we use the kernel headers from the target
	use build && myconf="${myconf} --with-headers=${ROOT}usr/include"
	
	use nls || myconf="${myconf} --disable-nls"
	
	einfo "Configuring GLIBC..."
	rm -rf buildhere
	mkdir buildhere
	cd buildhere
	../configure --host=${CHOST} \
		--with-gd=no \
		--without-cvs \
		--enable-add-ons=linuxthreads \
		--disable-profile \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--libexecdir=/usr/lib/misc \
		${myconf} || die
	# This next option breaks the Sun JDK and the IBM JDK
	# We should really keep compatibility with older kernels, anyway
	# --enable-kernel=2.4.0
	
	einfo "Building GLIBC..."
	make PARALLELMFLAGS="${MAKEOPTS}" || die
	einfo "Doing GLIBC checks..."
	make check
}


src_install() {
	export LC_ALL="C"
	einfo "Installing GLIBC..."
	make PARALLELMFLAGS="${MAKEOPTS}" \
		install_root=${D} \
		install -C buildhere || die
		
	if [ -z "`use build`" ]
	then
		einfo "Installing Info pages..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			info -C buildhere || die
		
		einfo "Installing Locale data..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			localedata/install-locales -C buildhere || die
		
		einfo "Installing man pages and docs..."
		# Install linuxthreads man pages
		dodir /usr/share/man/man3
		doman ${S}/man/*.3thr
		
		# Install nscd config file
		insinto /etc
		doins ${S}/nscd/nscd.conf
		
		dodoc BUGS ChangeLog* CONFORMANCE COPYING* FAQ INTERFACE \
			NEWS NOTES PROJECTS README*
	else
		rm -rf ${D}/usr/share ${D}/usr/lib/gconv
	fi
	
	if [ "`use pic`" ] 
	then
		find ${S}/buildhere -name "soinit.os" -exec cp {} ${D}/lib/soinit.o \;
		find ${S}/buildhere -name "sofini.os" -exec cp {} ${D}/lib/sofini.o \;
		find ${S}/buildhere -name "*_pic.a" -exec cp {} ${D}/lib \;
		find ${S}/buildhere -name "*.map" -exec cp {} ${D}/lib \;
		for i in ${D}/lib/*.map
		do
			mv ${i} ${i%.map}_pic.map
		done
	fi
	
	# Is this next line actually needed or does the makefile get it right?
	# It previously has 0755 perms which was killing things.
	fperms 4755 /usr/lib/misc/pt_chown
	
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
}

