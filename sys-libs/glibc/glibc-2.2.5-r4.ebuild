# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.2.5-r4.ebuild,v 1.8 2002/07/16 04:15:00 gerk Exp $
inherit flag-o-matic

filter-flags "-fomit-frame-pointer -malign-double"

S=${WORKDIR}/${P}
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="ftp://sources.redhat.com/pub/glibc/releases/glibc-${PV}.tar.bz2
	 ftp://sources.redhat.com/pub/glibc/releases/glibc-linuxthreads-${PV}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"
KEYWORDS="x86 ppc"
LICENSE="GPL-2 LGPL-2.1"
SLOT="2.2"

#portage-1.8.9 needed for smart library merging feature (avoids segfaults on glibc upgrade)
#drobbins, 18 Mar 2002: we now rely on the system profile to select the correct linus-headers
DEPEND="sys-kernel/linux-headers nls? ( sys-devel/gettext )"
RDEPEND="sys-kernel/linux-headers"

if [ -z "`use build`" ]
then
	RDEPEND="$RDEPEND sys-apps/baselayout"
else
	RDEPEND="$RDEPEND >=sys-apps/portage-1.8.9_pre1 sys-apps/baselayout"
fi

PROVIDE="virtual/glibc"

#lock glibc at -O2 -- linuxthreads needs it and we want to be conservative here
export CFLAGS="$CFLAGS -O2"
export CXXFLAGS="$CFLAGS"

src_unpack() {
	unpack glibc-${PV}.tar.bz2 || die
	cd ${S}
	#extract pre-made man pages.  Otherwise we need perl, which is a no-no.
	mkdir man; cd man
	tar xjf ${FILESDIR}/glibc-manpages-${PV}.tar.bz2 || die
	cd ${S}
	unpack glibc-linuxthreads-${PV}.tar.bz2 || die
	
	# This patch apparently eliminates compiler warnings for some versions of gcc.
	# For information about the string2 patch, see: 
	# http://lists.gentoo.org/pipermail/gentoo-dev/2001-June/001559.html
	patch -p0 < ${FILESDIR}/glibc-2.2.4-string2.h.diff || die

	# This next one is a new patch to fix thread signal handling.  See:
	# http://sources.redhat.com/ml/libc-hacker/2002-02/msg00120.html
	# (Added by drobbins on 05 Mar 2002)
	patch -p0 < ${FILESDIR}/glibc-2.2.5-threadsig.diff || die

	# This next patch fixes a test that will timeout due to ReiserFS' slow handling of sparse files
	cd ${S}/io; patch -p0 < ${FILESDIR}/glibc-2.2.2-test-lfs-timeout.patch || die

	# The following spinlock error should only bite if you compile without any -O in CFLAGS, so a tweak
	# shouldn't be necessary.  The solution is to add -O2.  According to Andreas Jaeger of SuSE, "glibc
	# *needs* to be compiled with optimization" (emphasis mine).  So let's fix the optimization settings,
	# not tweak glibc.
	# (drobbins, 10 Feb 2002)
	# http://sources.redhat.com/ml/bug-glibc/2001-09/msg00041.html
	# http://sources.redhat.com/ml/bug-glibc/2001-09/msg00042.html
	# cd ${S}/linuxthreads
	# cp spinlock.c spinlock.c.orig
	# sed -e 's/"=m" (lock->__status) : "0" (lock->__status/"+m" (lock->__status/g' spinlock.c.orig > spinlock.c
	
	# The glob() buffer overflow in glibc 2.2.4 was fixed in 2.2.5; commenting out.
	# http://lwn.net/2001/1220/a/glibc-vulnerability.php3
	# cd ${S}
	# patch -p1 < ${FILESDIR}/glibc-2.2.4-glob-overflow.diff || die

	if [ ${ARCH} == "x86" ]; then
	# This patch fixes the nvidia-glx probs, openoffice and vmware probs and such..
        # http://sources.redhat.com/ml/libc-hacker/2002-02/msg00152.html
        cd ${S}
        patch -p1 < ${FILESDIR}/glibc-divdi3.diff || die
	fi
	
}

src_compile() {
	local myconf
	# If we build for the build system we use the kernel headers from the target
	[ "`use build`" ] && myconf="--with-header=${ROOT}usr/include"
	[ -z "`use nls`" ] && myconf="${myconf} --disable-nls"
	rm -rf buildhere
	mkdir buildhere
	cd buildhere
	../configure --host=${CHOST} --with-gd=no --without-cvs --enable-add-ons=linuxthreads --disable-profile --prefix=/usr \
		--mandir=/usr/share/man --infodir=/usr/share/info --libexecdir=/usr/lib/misc ${myconf} || die
	
	#This next option breaks the Sun JDK and the IBM JDK
	#We should really keep compatibility with older kernels, anyway
	#--enable-kernel=2.4.0
	make PARALLELMFLAGS="${MAKEOPTS}" || die
	make check
}


src_install() {
	export LC_ALL=C
	make PARALLELMFLAGS="${MAKEOPTS}" install_root=${D} install -C buildhere || die
	if [ -z "`use build`" ]
	then
		make PARALLELMFLAGS="${MAKEOPTS}" install_root=${D} info -C buildhere || die
		make PARALLELMFLAGS="${MAKEOPTS}" install_root=${D} localedata/install-locales -C buildhere || die
		#install linuxthreads man pages
		dodir /usr/share/man/man3
		doman ${S}/man/*.3thr	
		install -m 644 nscd/nscd.conf ${D}/etc
		dodoc BUGS ChangeLog* CONFORMANCE COPYING* FAQ INTERFACE NEWS NOTES PROJECTS README*
	else
		rm -rf ${D}/usr/share ${D}/usr/lib/gconv
	fi
	if [ "`use pic`" ] 
	then
		find ${S}/buildhere -name "*_pic.a" -exec cp {} ${D}/lib \;
		find ${S}/buildhere -name "*.map" -exec cp {} ${D}/lib \;
		for i in ${D}/lib/*.map
		do
			mv ${i} ${i%.map}_pic.map
		done
	fi
	#is this next line actually needed or does the makefile get it right?
	#It previously has 0755 perms which was killing things.
	chmod 4755 ${D}/usr/lib/misc/pt_chown
	rm -f ${D}/etc/ld.so.cache

	#prevent overwriting of the /etc/localtime symlink.  We'll handle the
	#creation of the "factory" symlink in pkg_postinst().
	rm -f ${D}/etc/localtime

	#some things want this, notably ash.
	dosym /usr/lib/libbsd-compat.a /usr/lib/libbsd.a
}

pkg_postinst()
{
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
