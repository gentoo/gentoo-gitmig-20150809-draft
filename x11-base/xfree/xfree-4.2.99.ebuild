# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.2.99.ebuild,v 1.4 2002/08/14 12:00:14 murphy Exp $

FT2_VER=2.0.9
MY_V="`echo ${PV} |sed -e 's:\.::g'`"
S=${WORKDIR}/xc
DESCRIPTION="Xfree86: famous and free X server"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/${PV}/source"
SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/${PV}/source"

# Misc patches we may wat to fetch
X_PATCHES=""

# Updated Wacom driver
# Homepage:  http://people.mandrakesoft.com/~flepied/projects/wacom/
X_DRIVERS="http://people.mandrakesoft.com/~flepied/projects/wacom/xf86Wacom.c.gz"

#SRC_URI="${SRC_PATH0}/X${MY_V}src-1.tgz
#	 ${SRC_PATH0}/X${MY_V}src-2.tgz
#	 ${SRC_PATH0}/X${MY_V}src-3.tgz
#	 ${SRC_PATH1}/X${MY_V}src-1.tgz
#	 ${SRC_PATH1}/X${MY_V}src-2.tgz
#	 ${SRC_PATH1}/X${MY_V}src-3.tgz
SRC_URI="http://www.ibiblio.org/gentoo/gentoo-sources/X${MY_V}-1.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/X${MY_V}-2.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/X${MY_V}-3.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/X${MY_V}-4.tar.bz2
	mirror://sourceforge/freetype/freetype-${FT2_VER}.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/truetype.tar.gz
	${X_PATCHES}
	${X_DRIVERS}"

HOMEPAGE="http://www.xfree.org"
LICENSE="X11"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.75
	>=sys-libs/zlib-1.1.3-r2
	sys-devel/flex
	sys-devel/perl
	3dfx? ( >=media-libs/glide-v3-3.10 )"
	
RDEPEND=">=sys-libs/ncurses-5.1
	>=x11-base/opengl-update-1.3"

PROVIDE="virtual/x11
	virtual/opengl
	virtual/glu"

pkg_setup() {

	eerror
	eerror "This is very experimental, and can break things horribly!!!!"
	eerror "If you do decide to use it, please unmerge any older versions"
	eerror "of XFree86, as changes to headers can cause problems."
	eerror
	die
}

src_unpack () {

	unpack X${MY_V}-{1,2,3,4}.tar.bz2

	# Deploy our custom freetype2.  We want it static for stability,
	# and because some things in Gentoo depends the freetype2 that
	# is distributed with XFree86.
	unpack freetype-${FT2_VER}.tar.bz2
	cd ${S}/extras/freetype2
	rm -rf *
	mv ${WORKDIR}/freetype-${FT2_VER}/* .
	# Enable hinting for truetype fonts
	cd ${S}/extras/freetype2/include/freetype/config
	cp ftoption.h ftoption.h.orig
	sed -e 's:#undef TT_CONFIG_OPTION_BYTECODE_INTERPRETER:#define TT_CONFIG_OPTION_BYTECODE_INTERPRETER:' \
		ftoption.h.orig > ftoption.h

	# Update Wacom Driver, hopefully resolving bug #1632
	# The kernel driver should prob also be updated, this can be
	# found at:
	#
	#  http://people.mandrakesoft.com/~flepied/projects/wacom/
	#
	zcat ${DISTDIR}/xf86Wacom.c.gz > \
		${S}/programs/Xserver/hw/xfree86/input/wacom/xf86Wacom.c || die

	cd ${S}

	# Various patches from all over
	for x in ${FILESDIR}/${PV}-patches/*.patch.bz2
	do
		bzcat ${x} | patch -p2 || die "Failed to apply ${x}!"
	done

	cp ${FILESDIR}/${PVR}/site.def config/cf/host.def
	echo "#define XVendorString \"Gentoo Linux (XFree86 ${PV}, revision ${PR})\"" \
		>> config/cf/host.def
	echo "#define OptimizedCDebugFlags ${CFLAGS}" >> config/cf/host.def
	echo "#define GccWarningOptions -pipe" >> config/cf/host.def

	if [ "${ARCH}" = "x86 sparc sparc64" ]
	then
		# optimize Mesa for architecture
		if [ -n "`use mmx`" ]
		then
			echo "#define HasMMXSupport	YES" >> config/cf/host.def
		fi
		if [ -n "`use 3dnow`" ]
		then
			echo "#define MesaUse3DNow YES" >> config/cf/host.def
		elif [ -n "`use sse`" ]
		then
			echo "#define MesaUseKatmai YES" >> config/cf/host.def
		fi
	fi

	# build with glide3 support? (build the tdfx_dri.o module)
	if [ -n "`use 3dfx`" ]
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

	# Apply Xft quality patch from http://www.cs.mcgill.ca/~dchest/xfthack/
#	cd ${S}/lib/Xft
#	cat ${FILESDIR}/${PVR}/xft-quality.diff | patch -p1 || die
}

src_compile() {

	# fix build build problems for tdfx driver
	if [ -n "`use 3dfx`" ]
	then
		cd ${S}/lib/GL/mesa/src/drv/tdfx
		ln -s /usr/include/glide3/glide.h glide.h
		ln -s /usr/include/glide3/glideutl.h glideutl.h
		ln -s /usr/include/glide3/glidesys.h glidesys.h
		ln -s /usr/include/glide3/g3ext.h g3ext.h
		cd ${S}
	fi
	
	emake World || die

	if [ "`use nls`" ]
	then
		cd ${S}/nls
		make || die
		cd ${s}
	fi
}

src_install() {

	# fix compile for gcc-3.1
	if [ "`gcc -dumpversion`" = "3.1" ]
	then
		make CXXDEBUGFLAGS="${CXXDEBUGFLAGS} -mno-mmx" \
		CDEBUGFLAGS="${CDEBUGFLAGS} -mno-mmx" \
		install DESTDIR=${D} || die
	else
		make install DESTDIR=${D} || die
	fi
	
	make install.man DESTDIR=${D} || die

	if [ "`use nls`" ]
	then
		cd ${S}/nls
		make DESTDIR=${D} install || die
		cd ${S}
	fi

	# we zap the our CFLAGS in the host.def file, as hardcoded CFLAGS can
	# mess up other things that use xmkmf
	cp ${D}/usr/X11R6/lib/X11/config/host.def \
		${D}/usr/X11R6/lib/X11/config/host.def.orig
	grep -v OptimizedCDebugFlags ${D}/usr/X11R6/lib/X11/config/host.def.orig > \
		${D}/usr/X11R6/lib/X11/config/host.def
	rm -f ${D}/usr/X11R6/lib/X11/config/host.def.orig
	# theoretically, /usr/X11R6/lib/X11/config is a possible candidate for
	# config file management. If we find that people really worry about imake
	# stuff, we may add it.  But for now, we leave the dir unprotected.

	insinto /etc/X11
	doins ${FILESDIR}/${PVR}/XftConfig
	dosym ../../../../etc/X11/XftConfig /usr/X11R6/lib/X11/XftConfig
	cd ${D}/usr/X11R6/lib/X11/fonts
	tar -xz --no-same-owner -f ${DISTDIR}/truetype.tar.gz || \
		die "Failed to unpack truetype.tar.gz"

	dodir /usr/bin
	dosym /usr/X11R6/bin /usr/bin/X11

	dosym /usr/X11R6/lib/X11 /usr/lib/X11

	dosym libGL.so.1.2 /usr/X11R6/lib/libGL.so
	dosym libGL.so.1.2 /usr/X11R6/lib/libGL.so.1
	dosym libGL.so.1.2 /usr/X11R6/lib/libMesaGL.so
	# We move libGLU to /usr/lib now
	dosym libGLU.so.1.3 /usr/lib/libMesaGLU.so

	# .la files for libtool support
	insinto /usr/X11R6/lib
	doins ${FILESDIR}/${PVR}/lib/*.la

	exeinto /etc/X11
	# new session management script
	doexe ${FILESDIR}/${PVR}/chooser.sh
	# new display manager script
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
	insinto /etc/conf.d
	newins ${FILESDIR}/${PVR}/xfs.conf.d xfs

	# we want libGLU.so* in /usr/lib
	mv ${D}/usr/X11R6/lib/libGLU.* ${D}/usr/lib

	# next section is to setup the dinamic libGL stuff
	dodir /usr/lib/opengl/xfree/{lib,extensions,include}
	mv ${D}/usr/X11R6/lib/libGL.so* ${D}/usr/lib/opengl/xfree/lib
	mv ${D}/usr/X11R6/lib/libGL.la ${D}/usr/lib/opengl/xfree/lib
	# libGL.a cause problems with tuxracer, etc
	mv ${D}/usr/X11R6/lib/libGL.a ${D}/usr/lib/opengl/xfree/lib
	mv ${D}/usr/X11R6/lib/libMesaGL.so ${D}/usr/lib/opengl/xfree/lib
	mv ${D}/usr/X11R6/lib/modules/extensions/libglx* \
		${D}/usr/lib/opengl/xfree/extensions
	mv ${D}/usr/X11R6/include/GL/{gl.h,glx.h,glxtokens.h} \
		${D}/usr/lib/opengl/xfree/include
}

pkg_preinst() {
	# this changed from a directory/file to a symlink
	if [ ! -L ${ROOT}/usr/X11R6/lib/X11/XftConfig ] && \
	   [ -f ${ROOT}/usr/X11R6/lib/X11/XftConfig ]
	then
		rm -rf ${ROOT}/usr/X11R6/lib/X11/XftConfig
	fi
	if [ ! -L ${ROOT}/usr/X11R6/lib/X11/app-defaults ] && \
	   [ -d ${ROOT}/usr/X11R6/lib/X11/app-defaults ]
	then
		mv f ${ROOT}/usr/X11R6/lib/X11/app-defaults ${ROOT}/etc/X11
	fi

	# clean the dinamic libGL stuff's home to ensure
	# we dont have stale libs floating around
	if [ -d ${ROOT}/usr/lib/opengl/xfree ]
	then
		rm -rf ${ROOT}/usr/lib/opengl/xfree/*
	fi
}

pkg_postinst() {
#	env-update
#	echo ">>> Making font dirs..."
#	find ${ROOT}/usr/X11R6/lib/X11/fonts/* -type d -maxdepth 1 \
#		-exec ${ROOT}/usr/X11R6/bin/mkfontdir {} ';'

	#switch to the xfree implementation
	if [ "${ROOT}" = "/" ]
	then
		/usr/sbin/opengl-update xfree
	fi

	# add back directories that portage nukes on unmerge
	if [ ! -d ${ROOT}/var/lib/xdm ]
	then
		mkdir -p ${ROOT}/var/lib/xdm
	fi
	touch ${ROOT}/var/lib/xdm/.keep
}

