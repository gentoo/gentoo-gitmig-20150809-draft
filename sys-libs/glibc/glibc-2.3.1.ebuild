# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.3.1.ebuild,v 1.1 2002/10/20 05:45:34 azarah Exp $

IUSE="nls pic build"

inherit flag-o-matic gcc

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

S="${WORKDIR}/${P}"
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="http://ftp.gnu.org/gnu/glibc/glibc-${PV}.tar.gz
	http://ftp.gnu.org/gnu/glibc/glibc-linuxthreads-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"
# Is 99% compadible, just some .a's bork
SLOT="2.2"
LICENSE="GPL-2"

# Portage-1.8.9 needed for smart library merging feature (avoids segfaults on glibc upgrade)
# Drobbins, 18 Mar 2002: we now rely on the system profile to select the correct linus-headers
DEPEND=">=sys-devel/gcc-3.2-r1
	>=sys-devel/binutils-2.13.90.0.4-r1
	sys-kernel/linux-headers
	nls? ( sys-devel/gettext )"
RDEPEND="sys-kernel/linux-headers
	sys-apps/baselayout
	nls? ( sys-devel/gettext )
	build? ( >=sys-apps/portage-1.9.0 )"

PROVIDE="virtual/glibc"


pkg_config() {
	if [ "`gcc-major-version`" -ne "3" -o "`gcc-minor-version`" -lt "2" ]
	then
		eerror "************************************************"
		eerror " As of glibc-2.3, gcc-3.2 or later is needed"
		eerror " for the build to succeed!"
		eerror "************************************************"
		die "GCC too old!"
	fi
}

src_unpack() {
	unpack glibc-${PV}.tar.gz || die
	# Extract pre-made man pages.  Otherwise we need perl, which is a no-no.
	mkdir man; cd man
	tar xjf ${FILESDIR}/glibc-manpages-${PV}.tar.bz2 || die
	cd ${S}
	unpack glibc-linuxthreads-${PV}.tar.gz || die
	
	# This next patch fixes a test that will timeout due to ReiserFS' slow handling of sparse files
	einfo "Applying test-lfs-timeout patch..."
	cd ${S}/io; patch -p0 < ${FILESDIR}/glibc-2.2.2-test-lfs-timeout.patch > /dev/null || die
}

src_compile() {
	local myconf=""
	
	# If we build for the build system we use the kernel headers from the target
	use build \
		&& myconf="${myconf} --with-header=${ROOT}usr/include"
	# Set it without "build" as well, else it might use the current kernel's
	# headers, which might just fail (the linux-headers package is usually well
	# tested...)
	
	use nls || myconf="${myconf} --disable-nls"

	# Thread Local Storage support.  This dont really work as of yet...
#	use x86 && use tls \
#		&& myconf="${myconf} --with-tls"
	myconf="${myconf} --without-tls"

	if [ "`uname -r | cut -d. -f2`" -ge "4" ]
	then
		myconf="${myconf} --enable-kernel=2.4.0"
	fi
	
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

