# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.3.1-r4.ebuild,v 1.8 2003/04/20 20:59:25 method Exp $

IUSE="nls pic build"

inherit eutils flag-o-matic gcc

filter-flags "-fomit-frame-pointer -malign-double"

# Sparc support ...
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

# Lock glibc at -O2 -- linuxthreads needs it and we want to be conservative here
export CFLAGS="${CFLAGS//-O?} -O2"
export CXXFLAGS="${CFLAGS}"

S="${WORKDIR}/${P}"
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="http://ftp.gnu.org/gnu/glibc/glibc-${PV}.tar.gz
	http://ftp.gnu.org/gnu/glibc/glibc-linuxthreads-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

KEYWORDS="x86 ppc sparc alpha mips hppa arm"
# Is 99% compadible, just some .a's bork
SLOT="2.2"
LICENSE="GPL-2"

# Portage-1.8.9 needed for smart library merging feature (avoids segfaults on glibc upgrade)
# Drobbins, 18 Mar 2002: we now rely on the system profile to select the correct linus-headers
DEPEND=">=sys-devel/gcc-3.2-r1
	>=sys-devel/binutils-2.13.90.0.16
	virtual/os-headers
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/os-headers
	sys-apps/baselayout
	nls? ( sys-devel/gettext )
	build? ( >=sys-apps/portage-1.9.0 )"

PROVIDE="virtual/glibc"


pkg_config() {
	if [ "`gcc-major-version`" -ne "3" -o "`gcc-minor-version`" -lt "2" ]
	then
		eerror "As of glibc-2.3, gcc-3.2 or later is needed"
		eerror "for the build to succeed."
		die "GCC too old"
	fi
}

src_unpack() {

	if [ -n "`is-flag "-fstack-protector"`" -a -n "`has "sandbox" $FEATURES`" ] 
	then
		eerror "You have both -fstack-protector and sandbox enabled"
		eerror "glibc will not compile correctly with both of these enabled"
		eerror "Please disable sandbox by calling emerge with FEATURES=\"-sandbox\""
		die
	fi

	unpack glibc-${PV}.tar.gz || die
	# Extract pre-made man pages.  Otherwise we need perl, which is a no-no.
	mkdir -p ${S}/man; cd ${S}/man
	tar xjf ${FILESDIR}/glibc-manpages-${PV}.tar.bz2 || die
	cd ${S}
	unpack glibc-linuxthreads-${PV}.tar.gz || die
	
	# Security Update
	# Fix for http://www.cert.org/advisories/CA-2003-10.html
	epatch ${FILESDIR}/${PN}-xdr_security.patch

	# This next patch fixes a test that will timeout due to ReiserFS' slow handling of sparse files
	cd ${S}/io; epatch ${FILESDIR}/glibc-2.2.2-test-lfs-timeout.patch

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
	cd ${S}; epatch ${FILESDIR}/${PV}/${P}-ctype-compat-v3.patch

	# One more compat issue which breaks sun-jdk-1.3.1.  See bug #8766 for more
	# info, and also:
	#
	#   http://sources.redhat.com/ml/libc-alpha/2002-04/msg00143.html
	#
	# Thanks to Jan Gutter <jangutter@tuks.co.za> for reporting it.
	#
	# <azarah@gentoo.org> (30 Oct 2002).
	cd ${S}; epatch ${FILESDIR}/${PV}/${P}-libc_wait-compat.patch

	# One more compat issue ... libc_stack_end is missing from ld.so.
	# Got this one from diffing redhat glibc tarball .. would help if
	# they used patches and not modified tarball ...
	#
	# <azarah@gentoo.org> (7 Nov 2002).
	cd ${S}; epatch ${FILESDIR}/${PV}/${P}-stack_end-compat.patch

	# This one fixes a corner case with prelinking and preloading
	# This is a diff from the glibc CVS
	# http://sources.redhat.com/ml/libc-alpha/2002-11/msg00151.html
	# <cretin@gentoo.org> (17 Nov 2002).
	cd ${S}; epatch ${FILESDIR}/${PV}/${P}-prelinkfix.patch

	# Fix 'locale -a' not listing all locales.  This to Stefan Jones
	# <cretin@gentoo.org> for this fix, bug #13240.
	cd ${S}; epatch ${FILESDIR}/${PV}/${P}-locale.patch

	# Fix problems with ORACLE, bug #16504
	cd ${S}; epatch ${FILESDIR}/${PV}/${P}-typeo_dl-runtime_c.patch

	# A few patches only for the MIPS platform.  Descriptions of what they
	# do can be found in the patch headers.
	# <tuxus@gentoo.org> thx <dragon@gentoo.org> (11 Jan 2003)
	if [ "${ARCH}" = "mips" ]
	then
		cd ${S}
		epatch ${FILESDIR}/${PV}/${P}-elf-machine-rela-mips.patch
		epatch ${FILESDIR}/${PV}/${P}-exit-syscall-mips.patch
		epatch ${FILESDIR}/${PV}/${P}-fpu-cw-mips.patch
		epatch ${FILESDIR}/${PV}/${P}-inline-syscall-mips.patch
		epatch ${FILESDIR}/${PV}/${P}-libgcc-compat-mips.patch
		epatch ${FILESDIR}/${PV}/${P}-librt-mips.patch
		epatch ${FILESDIR}/${PV}/${P}-tst-rndseek-mips.patch
		epatch ${FILESDIR}/${PV}/${P}-ulps-mips.patch
	fi

    # Some patches for hppa.
    # <gmsoft@gentoo.org> (27 Jan 2003)
    if [ "${ARCH}" = "hppa" ]
    then
        cd ${S}
        epatch ${FILESDIR}/${PV}/glibc23-00-hppa-pthreads.dpatch
        epatch ${FILESDIR}/${PV}/glibc23-01-hppa-dl-machine.dpatch
        epatch ${FILESDIR}/${PV}/glibc23-02-hppa-min-kern-unwind-fde.dpatch
        epatch ${FILESDIR}/${PV}/glibc23-03-hppa-mcontext.dpatch
        epatch ${FILESDIR}/${PV}/glibc23-04-hppa-fcntl64.dpatch
        epatch ${FILESDIR}/${PV}/glibc23-05-hppa-buildhack.dpatch
        epatch ${FILESDIR}/${PV}/glibc23-06-hppa-tests.dpatch
        epatch ${FILESDIR}/${PV}/glibc23-07-hppa-atomicity.dpatch
        epatch ${FILESDIR}/${PV}/glibc23-08-hppa-configure.dpatch
        epatch ${FILESDIR}/${PV}/glibc23-hppa-shmlba.dpatch
    fi

}

src_compile() {
	local myconf=""

	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL
	
	# If we build for the build system we use the kernel headers from the target
#	( use build || use sparc ) \
#		&& myconf="${myconf} --with-headers=${ROOT}usr/include"
	myconf="${myconf} --with-headers=${ROOT}usr/include"
	# Set it without "build" as well, else it might use the current kernel's
	# headers, which might just fail (the linux-headers package is usually well
	# tested...)
	
	use nls || myconf="${myconf} --disable-nls"

	# Thread Local Storage support.  This dont really work as of yet...
#	use x86 && use tls \
#		&& myconf="${myconf} --with-tls"
	myconf="${myconf} --without-tls --without-__thread"

	if [ "`uname -r | cut -d. -f2`" -ge "4" ]
	then
		myconf="${myconf} --enable-kernel=2.4.0"
	fi

	# This should not be done for: ia64 s390 s390x
#	use x86 && CFLAGS="${CFLAGS} -freorder-blocks"
	
	einfo "Configuring GLIBC..."
	rm -rf buildhere
	mkdir buildhere
	cd buildhere
	../configure --host=${CHOST} \
		--with-gd=no \
		--without-cvs \
		--enable-add-ons=yes \
		--disable-profile \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--libexecdir=/usr/lib/misc \
		${myconf} || die
	
	einfo "Building GLIBC..."
	make PARALLELMFLAGS="${MAKEOPTS}" || die
#	einfo "Doing GLIBC checks..."
#	make check
}


src_install() {
	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL
	
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

		einfo "Installing Timezone data..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			timezone/install-others -C buildhere || die
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

	# Generate fastloading iconv module configuration file.
	if [ -x ${ROOT}/usr/sbin/iconvconfig ]
	then
		${ROOT}/usr/sbin/iconvconfig --prefix=${ROOT}
	fi

	# Reload init ...
	if [ "${ROOT}" = "/" ]
	then
		/sbin/init U &> /dev/null
	fi
}

