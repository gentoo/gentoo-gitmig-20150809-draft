# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.2.3-r4.ebuild,v 1.1 2001/07/28 15:49:20 pete Exp $

A="$P.tar.gz glibc-linuxthreads-${PV}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-${PV}.tar.gz
	 ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-linuxthreads-${PV}.tar.gz
	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-${PV}.tar.gz
	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-linuxthreads-${PV}.tar.gz
	 ftp://ftp.gnu.org/pub/gnu/glibc/glibc-${PV}.tar.gz
	 ftp://ftp.gnu.org/pub/gnu/glibc/glibc-linuxthreads-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

DEPEND="nls? ( sys-devel/gettext ) gd? ( media-libs/libgd )"

if [ -z "`use bootstrap`" ] && [ -z "`use bootcd`" ] && [ -z "`use build`" ]
then
	RDEPEND="gd? ( sys-libs/zlib media-libs/libpng ) sys-apps/baselayout"
else
	RDEPEND="sys-apps/baselayout"
fi

PROVIDE="virtual/glibc"

src_unpack() {
	
    unpack glibc-${PV}.tar.gz
    cd ${S}
    unpack glibc-linuxthreads-${PV}.tar.gz
    for i in mtrace-intl-perl
	do
      echo "Applying $i patch..."
      try patch -p0 < ${FILESDIR}/glibc-2.2.2-${i}.diff
    done
    try patch -p0 < ${FILESDIR}/glibc-2.2.3-libnss.diff
    try patch -p0 < ${FILESDIR}/glibc-2.2.3-string2.diff
    cd io
    try patch -p0 < ${FILESDIR}/glibc-2.2.2-test-lfs-timeout.patch
	
}

src_compile() {
	local myconf
	if [ "`use build`" ]
	then
		# If we build for the build system we use the kernel headers from the target
		myconf="--with-header=${ROOT}usr/include"
	fi
	if [ "`use gd`" ] && [ -z "`use bootstrap`" ]
	then
		myconf="${myconf} --with-gd=yes"
	else
		myconf="${myconf} --with-gd=no"
	fi
    if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
    fi
    rm -rf buildhere
	mkdir buildhere
	cd buildhere
	try ../configure --host=${CHOST} --without-cvs \
		--enable-add-ons=linuxthreads \
		--disable-profile --prefix=/usr \
		--mandir=/usr/share/man --infodir=/usr/share/info \
		--libexecdir=/usr/lib/misc ${myconf}
	
	#This next option breaks the Sun JDK and the IBM JDK
	#We should really keep compatibility with older kernels, anyway
	#--enable-kernel=2.4.0
	try make 
	make check
}


src_install() {
	
    rm -rf ${D}
    mkdir ${D}
    export LC_ALL=C
    try make PARALELLMFLAGS=${MAKEOPTS} install_root=${D} install -C buildhere
    if [ -z "`use build`" ] && [ -z "`use bootcd`" ]
	then
		dodir /etc/rc.d/init.d
		try make PARALELLMFLAGS=${MAKEOPTS} install_root=${D} info -C buildhere
		try make PARALELLMFLAGS=${MAKEOPTS} install_root=${D} localedata/install-locales -C buildhere

	# I commented out linuxthreads man pages because I don't want
	# glibc to build depend on perl
	#    dodir /usr/share/man/man3
	#    try make MANDIR=${D}/usr/share/man/man3 install -C linuxthreads/man
	#    cd ${D}/usr/share/man/man3
	#    for i in *.3thr
	#    do
	#      mv ${i} ${i%.3thr}.3
	#    done
		
		install -m 644 nscd/nscd.conf ${D}/etc
		install -m 755 ${FILESDIR}/nscd ${D}/etc/rc.d/init.d/nscd
		dodoc BUGS ChangeLog* CONFORMANCE COPYING* FAQ INTERFACE NEWS NOTES \
			PROJECTS README*
    else
		rm -rf ${D}/usr/share/{man,info,zoneinfo}
		if [ "`use bootcd`" ]
		then
			rm -rf ${D}/usr/include
			rm -f ${D}/usr/bin/{lddlibc4,iconv,sprof,glibcbug,tzselect,getconf,gencat,getent,locale,mtrace,pcprofiledump,rpcgen,localedef,catchsegv,xtrace}
			rm -rf ${D}/usr/sbin/{zic,nscd,nscd_nischeck,zdump,rpcinfo}
			rm -f ${D}/usr/lib/lib*.a
		fi
    fi

    if [ "`use pic`" ] && [ -z "`use bootcd`" ]
    then
        find ${S}/buildhere -name "*_pic.a" -exec cp {} ${D}/lib \;
        find ${S}/buildhere -name "*.map" -exec cp {} ${D}/lib \;
        for i in ${D}/lib/*.map
        do
          mv ${i} ${i%.map}_pic.map
        done
    fi
    rm ${D}/lib/ld-linux.so.2
    rm ${D}/lib/libc.so.6
    rm ${D}/lib/libpthread.so.0
    chmod 755 ${D}/usr/lib/misc/pt_chown
	rm -f ${D}/etc/ld.so.cache
}

pkg_preinst()
{
    # Check if we run under X
    if [ -e /usr/X11R6/bin/X ] && [ "`/sbin/pidof /usr/X11R6/bin/X`" ] && [ "${ROOT}" = "/" ]
	then
	    echo "glibc can not be installed while X is running!!"
	    exit 1
    fi
    
    echo "Saving ld-linux,libc6 and libpthread"
    for file in ld-linux.so.2 libc.so.6 libpthread.so.0
    do
	if [ -f ${ROOT}lib/${file} ]
	then
	    /bin/cp ${ROOT}lib/${file} ${ROOT}tmp
	    /sbin/sln ${ROOT}tmp/${file} ${ROOT}lib/${file}
	fi
    done
    
    if [ -e ${ROOT}etc/localtime ]
    then
	#keeping old timezone
	if [ -e ${D}/etc/localtime ] ; then
		  /bin/rm ${D}/etc/localtime
		fi
	else
		echo "Please remember to set your timezone using the zic command."
	fi
}

pkg_postinst()
{
  echo "Setting ld-linux,libc6 and libpthread"

  /sbin/sln ${ROOT}lib/ld-${PV}.so ${ROOT}lib/ld-linux.so.2
  /sbin/sln ${ROOT}lib/libc-${PV}.so ${ROOT}lib/libc.so.6
  /sbin/sln ${ROOT}lib/libpthread-0.9.so ${ROOT}lib/libpthread.so.0
  /bin/rm -f ${ROOT}tmp/ld-linux.so.2
  /bin/rm -f ${ROOT}tmp/libc.so.6
  /bin/rm -f ${ROOT}tmp/libpthread.so.0
  /sbin/ldconfig -r ${ROOT}

}
