# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.2.0-r8.ebuild,v 1.3 2002/04/13 16:43:46 danarmak Exp $

MY_V="`echo ${PV} |sed -e 's:\.::g'`"
S=${WORKDIR}/xc
DESCRIPTION="Xfree86: famous and free X server"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/${PV}/source"
SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/${PV}/source"

SRC_URI="$SRC_PATH0/X${MY_V}src-1.tgz
	 $SRC_PATH0/X${MY_V}src-2.tgz
	 $SRC_PATH0/X${MY_V}src-3.tgz
	 $SRC_PATH1/X${MY_V}src-1.tgz
	 $SRC_PATH1/X${MY_V}src-2.tgz
	 $SRC_PATH1/X${MY_V}src-3.tgz
	 ftp://ftp.xfree86.org/pub/XFree86/4.2.0/fixes/4.2.0-xlib-i18n-module.patch
	 ftp://ftp.xfree86.org/pub/XFree86/4.2.0/fixes/4.2.0-zlib-security.patch
	 ftp://ftp.xfree86.org/pub/XFree86/4.2.0/fixes/4.2.0-libGLU-bad-extern.patch
	 http://www.ibiblio.org/gentoo/gentoo-sources/truetype.tar.gz"
# NOTE:  4.2.0-xlib-i18n-module.patch is ONLY for XFree86 4.2.0

HOMEPAGE="http://www.xfree.org"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	sys-devel/flex
	sys-devel/perl
	glide? ( >=media-libs/glide-v3-3.10 )"
	
RDEPEND=">=sys-libs/ncurses-5.1"

PROVIDE="virtual/x11
	virtual/opengl
	virtual/glu"	

src_unpack () {

	unpack X${MY_V}src-{1,2,3}.tgz

	# resolve bug #794
	# NOTE:  4.2.0-xlib-i18n-module.patch is ONLY for XFree86 4.2.0
	#        4.2.0-zlib-security.patch is also ONLY for XFree86 4.2.0
	#        4.2.0-libGLU-bad-extern.patch same here .. fixes gcc-3.x compile
	#                                      errors
	cd ${WORKDIR}
	patch -p0 < ${DISTDIR}/${PV}-xlib-i18n-module.patch || die
	patch -p0 < ${DISTDIR}/${PV}-zlib-security.patch || die
	patch -p0 < ${DISTDIR}/${PV}-libGLU-bad-extern.patch || die
	
	cd ${S}
	cp ${FILESDIR}/${PVR}/site.def config/cf/host.def
	echo "#define DefaultGcc2i386Opt ${CFLAGS}" >> config/cf/host.def
	echo "#define GccWarningOptions -Wno" >> config/cf/host.def
	echo "#define DefaultCCOptions -ansi" >> config/cf/host.def

	# optimize Mesa for architecture
	if [ -n "`use sse`" ] ; then
		echo "#define MesaUseKatmai YES" >> config/cf/host.def
	fi
	if [ -n "`use 3dnow`" ] ; then
		echo "#define MesaUse3DNow YES" >> config/cf/host.def
	fi

	# build with glide3 support? (build the tdfx_dri.o module)
	if [ -n "`use glide`" ]
	then
		echo "#define HasGlide3 YES" >> config/cf/host.def
	fi

	# fix build problem (XFree86 server among others, was not
	#                    linked against libXau)
	cp ${S}/programs/Xserver/Imakefile \
		${S}/programs/Xserver/Imakefile.orig
	sed -e '2i CCLINK = $(CC) -L../../lib/Xau -lXau' \
		${S}/programs/Xserver/Imakefile.orig \
		> ${S}/programs/Xserver/Imakefile

	# Apply Xft quality patch from  http://www.cs.mcgill.ca/~dchest/xfthack/
	#cd ${S}/lib/Xft
	#cat ${FILESDIR}/${PVR}/xft-quality.diff | patch -p1 || die
}

src_compile() {

	emake World || die

	if [ "`use nls`" ]
	then
		cd ${S}/nls
		make || die
		cd ${s}
	fi
}

src_install() {

	make install DESTDIR=${D} || die
	make install.man DESTDIR=${D} || die

	if [ "`use nls`" ]
	then
		cd ${S}/nls
		make DESTDIR=${D} install || die
		cd ${S}
	fi

	#we zap the host.def file which gets hard-coded with our CFLAGS, messing up other things that use xmkmf
	echo > ${D}/usr/X11R6/lib/X11/config/host.def
	#theoretically, /usr/X11R6/lib/X11/config is a possible candidate for config file management.
	#If we find that people really worry about imake stuff, we may add it.  But for now, we leave
	#the dir unprotected.

	insinto /etc/X11
	doins ${FILESDIR}/${PVR}/XftConfig
	dosym ../../../.././etc/X11/XftConfig /usr/X11R6/lib/X11/XftConfig
	cd ${D}/usr/X11R6/lib/X11/fonts
	tar -xz --no-same-owner -f ${DISTDIR}/truetype.tar.gz
	dodir /usr/bin
	dosym /usr/X11R6/bin /usr/bin/X11

	dosym /usr/X11R6/lib/libGL.so.1.2 /usr/X11R6/lib/libMesaGL.so
	dosym /usr/X11R6/lib/libGLU.so.1.3 /usr/lib/libMesaGLU.so

	# .la files for libtool support
	insinto /usr/X11R6/lib
	doins ${FILESDIR}/${PVR}/lib/*.la

	exeinto /etc/X11
	#new session management script
	doexe ${FILESDIR}/${PVR}/chooser.sh
	#new display manager script
	doexe ${FILESDIR}/${PVR}/startDM.sh
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/${PVR}/Sessions/*
	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/10xfree
	insinto /etc/X11/xinit
	doins ${FILESDIR}/${PVR}/xinitrc
	exeinto /etc/X11/xdm
	doexe ${FILESDIR}/${PVR}/Xsession ${FILESDIR}/${PVR}/Xsetup_0
	insinto /etc/X11/fs
	newins ${FILESDIR}/${PVR}/xfs.config config
	insinto /etc/pam.d
	doins ${FILESDIR}/${PVR}/xdm
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PVR}/xdm.start xdm
	newexe ${FILESDIR}/${PVR}/xfs.start xfs
}

pkg_preinst() {
	#this changed from a file to a symlink
	rm -rf ${ROOT}/usr/X11R6/lib/X11/XftConfig
}

pkg_postinst() {
	env-update
	echo ">>> Making font dirs..."
	find ${ROOT}/usr/X11R6/lib/X11/fonts/* -type d -maxdepth 1 \
		-exec /usr/X11R6/bin/mkfontdir {} ';'
}

