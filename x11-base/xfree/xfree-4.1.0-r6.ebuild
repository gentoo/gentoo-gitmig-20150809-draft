# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.1.0-r6.ebuild,v 1.13 2003/09/07 07:27:40 msterret Exp $

MY_V="`echo ${PV} |sed -e 's:\.::g'`"
S=${WORKDIR}/xc
DESCRIPTION="Xfree86: famouse and free X server"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/4.1.0/source"
SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/4.1.0/source"

SRC_URI="$SRC_PATH0/X${MY_V}src-1.tgz
	 $SRC_PATH0/X${MY_V}src-2.tgz
	 $SRC_PATH0/X${MY_V}src-3.tgz
	 $SRC_PATH1/X${MY_V}src-1.tgz
	 $SRC_PATH1/X${MY_V}src-2.tgz
	 $SRC_PATH1/X${MY_V}src-3.tgz
       	 http://www.ibiblio.org/gentoo/gentoo-sources/truetype.tar.gz"

HOMEPAGE="http://www.xfree.org"
LICENSE="X11"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND=">=sys-libs/ncurses-5.1
        >=sys-libs/zlib-1.1.3-r2
	sys-devel/flex
	dev-lang/perl"

RDEPEND=">=sys-libs/ncurses-5.1"

PROVIDE="virtual/x11 virtual/opengl"
# virtual/glu"
# This has been removed.  Anyone know why exactly ??


src_unpack () {

	unpack X${MY_V}src-{1,2,3}.tgz

	cd ${S}
	cp ${FILESDIR}/${PVR}/site.def config/cf/host.def
	echo "#define DefaultGcc2i386Opt ${CFLAGS}" >>  config/cf/host.def
	echo "#define GccWarningOptions -Wno" >>  config/cf/host.def
	echo "#define DefaultCCOptions -ansi" >>  config/cf/host.def
}

src_compile() {

	emake World || die
}

src_install() {

	make install DESTDIR=${D} || die
	make install.man DESTDIR=${D} || die

	#we zap the host.def file which gets hard-coded with our CFLAGS, messing up other things that use xmkmf
	echo > ${D}/usr/X11R6/lib/X11/config/host.def
	#theoretically, /usr/X11R6/lib/X11/config is a possible candidate for config file management.
	#If we find that people really worry about imake stuff, we may add it.  But for now, we leave
	#the dir unprotected.

	insinto /usr/X11R6/lib/X11
	doins ${FILESDIR}/${PVR}/XftConfig
	cd ${D}/usr/X11R6/lib/X11/fonts
	tar -xz --no-same-owner -f ${DISTDIR}/truetype.tar.gz
	dosym /usr/X11R6/lib/libGL.so.1.2 /usr/X11R6/lib/libMesaGL.so
	dosym /usr/X11R6/bin /usr/bin/X11

	#X installs some /usr/lib/libGL symlinks, pointing to the libGL's in /usr/X11R6/lib.
	#I don't see the point in this.  Yes, according to LSB, the correct location for libGL is
	#in /usr/lib, but this is so closely integrated with X itself that /usr/X11R6/lib seems
	#like the right place.
	rm -rf ${D}/usr/lib

	#dosym /usr/X11R6/lib/libGLU.so.1.3 /usr/lib/libMesaGLU.so
	#We're no longer including libGLU from here.  Packaged separately, from separate sources.

	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/10xfree
	insinto /etc/X11/xinit
	doins ${FILESDIR}/${PVR}/xinitrc
	insinto /etc/X11/xdm
	doins ${FILESDIR}/${PVR}/Xsession
	insinto /etc/X11/fs
	newins ${FILESDIR}/${PVR}/xfs.config config
	insinto /etc/pam.d
	doins ${FILESDIR}/${PVR}/xdm
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PVR}/xdm.start xdm
	newexe ${FILESDIR}/${PVR}/xfs.start xfs
}
