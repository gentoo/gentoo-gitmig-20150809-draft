# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.2.1.ebuild,v 1.7 2002/09/19 21:15:27 azarah Exp $

inherit flag-o-matic gcc
# Compile problems with these ...
filter-flags "-funroll-loops"

FT2_VER="2.1.2"
SISDRV_VER="050902-2"

BASE_PV="4.2.0"
MY_SV="${BASE_PV//\.}"
S="${WORKDIR}/xc"
DESCRIPTION="Xfree86: famous and free X server"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/${BASE_PV}/source"
SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/${BASE_PV}/source"
HOMEPAGE="http://www.xfree.org"

X_PATCHES="http://ftp.xfree86.org/pub/XFree86/${PV}/patches/${BASE_PV}-${PV}.diff.gz
	mirror://gentoo/XFree86-${PV}-patches.tar.bz2"

X_DRIVERS="http://people.mandrakesoft.com/~flepied/projects/wacom/xf86Wacom.c.gz
	http://www.probo.com/timr/xf41sav.tgz
	http://www.webit.at/~twinny/sis/sis_drv_src_${SISDRV_VER}.tar.gz
	3dfx? ( mirror://gentoo/glide3-headers.tar.bz2 )"
# Updated Wacom driver at http://people.mandrakesoft.com/~flepied/projects/wacom/
# Latest Savaga drivers at http://www.probo.com/timr/savage40.html
# Latest SIS drivers at http://www.webit.at/~twinny/linuxsis630.shtml
# Glide headers for compiling the tdfx modules

# For the MS Core fonts ..
MS_COREFONTS="./andale32.exe ./arial32.exe
	./arialb32.exe ./comic32.exe
	./courie32.exe ./georgi32.exe
	./impact32.exe ./times32.exe
	./trebuc32.exe ./verdan32.exe
	./webdin32.exe ./IELPKTH.CAB"
MS_FONT_URLS="${MS_COREFONTS//\.\//mirror://sourceforge/corefonts/}"

SRC_URI="${SRC_PATH0}/X${MY_SV}src-1.tgz
	 ${SRC_PATH0}/X${MY_SV}src-2.tgz
	 ${SRC_PATH0}/X${MY_SV}src-3.tgz
	 ${SRC_PATH1}/X${MY_SV}src-1.tgz
	 ${SRC_PATH1}/X${MY_SV}src-2.tgz
	 ${SRC_PATH1}/X${MY_SV}src-3.tgz
	 mirror://sourceforge/freetype/freetype-${FT2_VER}.tar.bz2
	 ${X_PATCHES}
	 ${X_DRIVERS}
	 truetype? ( ${MS_FONT_URLS} )"

LICENSE="X11 MSttfEULA"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND=">=sys-apps/baselayout-1.8.3
	>=sys-libs/ncurses-5.1
	>=sys-libs/pam-0.75
	>=sys-libs/zlib-1.1.3-r2
	sys-devel/flex
	sys-devel/perl
	truetype? ( app-arch/cabextract )"
#	3dfx? ( >=media-libs/glide-v3-3.10 )"
	
RDEPEND=">=sys-apps/baselayout-1.8.3
	>=sys-libs/ncurses-5.1
	>=x11-base/opengl-update-1.4"

PROVIDE="virtual/x11
	virtual/opengl
	virtual/glu"	

src_unpack() {

	unpack X${MY_SV}src-{1,2,3}.tgz \
		freetype-${FT2_VER}.tar.bz2 \
		XFree86-${PV}-patches.tar.bz2

	# Deploy our custom freetype2.  We want it static for stability,
	# and because some things in Gentoo depends the freetype2 that
	# is distributed with XFree86.
	rm -rf ${S}/extras/freetype2
	mv ${WORKDIR}/freetype-${FT2_VER} ${S}/extras/freetype2

	# Install the glide3 headers for compiling the tdfx driver
	if [ -n "`use 3dfx`" ]
	then
		einfo "Installing tempory glide3 headers..."
		cd ${WORKDIR}; unpack glide3-headers.tar.bz2
		cp -f ${S}/lib/GL/mesa/src/drv/tdfx/Imakefile ${T}
		sed -e 's:$(GLIDE3INCDIR):$(WORKDIR)/glide3:g' \
			${T}/Imakefile > ${S}/lib/GL/mesa/src/drv/tdfx/Imakefile
	fi

	# Update to XFree86-4.2.1 tree
	einfo "Updating ${BASE_PV} sources to ${PV}..."
	cd ${S};
	gzip -dc ${DISTDIR}/${BASE_PV}-${PV}.diff.gz | patch -p1 > /dev/null || die

	# Unpack the MS fonts
	if [ -n "`use truetype`" ]
	then
		einfo "Unpacking MS Core Fonts..."
		mkdir -p ${WORKDIR}/truetype; cd ${WORKDIR}/truetype
		for x in ${MS_COREFONTS}
		do
			if [ -f ${DISTDIR}/${x} ]
			then
				einfo "  ${x/\.\/}..."
				cabextract --lowercase ${DISTDIR}/${x} > /dev/null || die
			fi
		done
	fi
	
	# Update the Savage Driver
	einfo "Updating Savage driver..."
	cd ${S}/programs/Xserver/hw/xfree86/drivers/savage
	tar -zxf ${DISTDIR}/xf41sav.tgz || die

	# Update the SIS Driver
	einfo "Updating SiS driver..."
	cd ${S}/programs/Xserver/hw/xfree86/drivers/sis
	tar -zxf ${DISTDIR}/sis_drv_src_${SISDRV_VER}.tar.gz || die

	# Update Wacom Driver, hopefully resolving bug #1632
	# The kernel driver should prob also be updated, this can be
	# found at:
	#
	#  http://people.mandrakesoft.com/~flepied/projects/wacom/
	#
	if [ "`uname -r | cut -d. -f1,2`" != "2.2" ]
	then
		einfo "Updating Wacom USB Driver..."
		gzip -dc ${DISTDIR}/xf86Wacom.c.gz > \
			${S}/programs/Xserver/hw/xfree86/input/wacom/xf86Wacom.c || die
	fi

	cd ${S}

	# Various patches from all over
	einfo "Applying various patches (bugfixes/updates)..."
	for x in ${WORKDIR}/*.patch.bz2
	do
		if [ -f ${x} ]
		then
			einfo "  ${x##*/}..."
			bzip2 -dc ${x} | patch -p2 > /dev/null || die "Failed Patch: ${x##*/}!"
		fi
	done
	for x in ${FILESDIR}/${PV}-patches/*.patch.bz2
	do
		# New ARCH dependant patch naming scheme...
		# 
		# Ranges:
		#
		#   1-19  - generic stuff
		#   20-29 - x86 stuff
		#   30-39 - ppc stuff
		#   40-49 - sparc stuff
		#   50-59 - sparc64 stuff
		#   60-69 - alpha stuff
		#   90-?? - own stuff
		#
		# NOTE: can mabye thing about merging sparc and sparc64
		#
		if [ -f ${x} ] && \
		   [ "${x/_all_}" != "${x}" -o "`eval echo \$\{x/_${ARCH}_\}`" != "${x}" ]
		then
			einfo "  ${x##*/}..."
			bzip2 -dc ${x} | patch -p2 > /dev/null || die "Failed Patch: ${x##*/}!"
		fi
	done

	einfo "Setting up config/cf/host.def..."
	cp ${FILESDIR}/${PVR}/site.def config/cf/host.def
	echo "#define XVendorString \"Gentoo Linux (XFree86 ${PV}, revision ${PR})\"" \
		>> config/cf/host.def

	if [ "`gcc-version`" != "2.95" ]
	then
		# should fix bug #4189.  gcc-3.x have problems with -march=pentium4
		# and -march=athlon-tbird
		export CFLAGS="${CFLAGS/pentium4/pentium3}"
		export CXXFLAGS="${CXXFLAGS/pentium4/pentium3}"
		export CFLAGS="${CFLAGS/athlon-tbird/athlon}"
		export CXXFLAGS="${CXXFLAGS/athlon-tbird/athlon}"
		# Without this, modules breaks with gcc3
		export CFLAGS="${CFLAGS} -fno-merge-constants"
		export CXXFLAGS="${CXXFLAGS} -fno-merge-constants"
	fi
	echo "#define OptimizedCDebugFlags ${CFLAGS}" >> config/cf/host.def
	echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS}" >> config/cf/host.def
	if [ "${DEBUGBUILD}" != "true" ]
	then
		# use less ram .. got this from Spider's makeedit.eclass :)
		echo "#define GccWarningOptions -Wno-return-type -w" >> config/cf/host.def
	fi

	if [ "${ARCH}" = "x86" ]
	then
		# optimize Mesa for architecture
		if [ -n "`use mmx`" ]
		then
			echo "#define HasMMXSupport	YES" >> config/cf/host.def
		fi
		if [ -n "`use 3dnow`" ]
		then
			echo "#define MesaUse3DNow YES" >> config/cf/host.def
			echo "#define MesaUseKatmai NO" >> config/cf/host.def
		elif [ -n "`use sse`" ]
		then
			echo "#define MesaUseKatmai YES" >> config/cf/host.def
			echo "#define MesaUse3DNow NO" >> config/cf/host.def
		fi
	fi

	# build with glide3 support? (build the tdfx_dri.o module)
	if [ -n "`use 3dfx`" ]
	then
		echo "#define HasGlide3 YES" >> config/cf/host.def
	fi

	# Apply Xft quality patch from http://www.cs.mcgill.ca/~dchest/xfthack/
#	cd ${S}/lib/Xft
#	cat ${FILESDIR}/${PVR}/xft-quality.diff | patch -p1 || die
}

src_compile() {

	emake World || die

	if [ -n "`use nls`" ]
	then
		cd ${S}/nls
		make || die
		cd ${S}
	fi
}

src_install() {

	# gcc3 related fix.  Do this during install, so that our
	# whole build will not be compiled without mmx instructions.
	if [ "`gcc-version`" != "2.95" ] && [ "${ARCH}" = "x86" ]
	then
		make CDEBUGFLAGS="${CDEBUGFLAGS} -mno-mmx" \
			CXXDEBUGFLAGS="${CXXDEBUGFLAGS} -mno-mmx" \
			install DESTDIR=${D} || die
	else
		make install DESTDIR=${D} || die
	fi
	
	make install.man DESTDIR=${D} || die

	if [ -n "`use nls`" ]
	then
		cd ${S}/nls
		make DESTDIR=${D} install || die
		cd ${S}
	fi

	# Make sure user running xterm can only write to utmp.
	chown root.utmp ${D}/usr/X11R6/bin/xterm
	chmod 2755 ${D}/usr/X11R6/bin/xterm

	# we zap the our CFLAGS in the host.def file, as hardcoded CFLAGS can
	# mess up other things that use xmkmf
	cp ${D}/usr/X11R6/lib/X11/config/host.def ${T}
	awk '!/OptimizedCDebugFlags|GccWarningOptions/ {print $0}' \
		${T}/host.def > ${D}/usr/X11R6/lib/X11/config/host.def
	# theoretically, /usr/X11R6/lib/X11/config is a possible candidate for
	# config file management. If we find that people really worry about imake
	# stuff, we may add it.  But for now, we leave the dir unprotected.

	insinto /etc/X11
	doins ${FILESDIR}/${PVR}/XftConfig
	dosym ../../../../etc/X11/XftConfig /usr/X11R6/lib/X11/XftConfig
	
	# Install MS fonts.
	if [ -n "`use truetype`" ]
	then
		einfo "Installing MS Core Fonts..."
		mkdir -p ${D}/usr/X11R6/lib/X11/fonts/truetype
		mv -f ${WORKDIR}/truetype/*.ttf ${D}/usr/X11R6/lib/X11/fonts/truetype
	fi

	# Standard symlinks
	dodir /usr/{bin,include,lib}
	dosym ../X11R6/bin /usr/bin/X11
	dosym ../X11R6/include/X11 /usr/include/X11
	dosym ../X11R6/include/GL /usr/include/GL
	dosym ../X11R6/lib/X11 /usr/lib/X11

	# Remove invalid symlinks
	rm -f ${D}/usr/lib/libGL.*
	# Create required symlinks
	dosym libGL.so.1.2 /usr/X11R6/lib/libGL.so
	dosym libGL.so.1.2 /usr/X11R6/lib/libGL.so.1
	dosym libGL.so.1.2 /usr/X11R6/lib/libMesaGL.so
	# We move libGLU to /usr/lib now
	dosym libGLU.so.1.3 /usr/lib/libMesaGLU.so

	# .la files for libtool support
	insinto /usr/X11R6/lib
	doins ${FILESDIR}/${PVR}/lib/*.la

	# Remove libz.a, as it causes problems (bug #4777)
	rm -f ${D}/usr/X11R6/lib/libz.a

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

	# next section is to setup the dynamic libGL stuff
	einfo "Moving libGL and friends for dynamic switching..."
	dodir /usr/lib/opengl/xfree/{lib,extensions,include}
	local x=""
	for x in ${D}/usr/X11R6/lib/libGL.so* \
		${D}/usr/X11R6/lib/libGL.la \
		${D}/usr/X11R6/lib/libGL.a \
		${D}/usr/X11R6/lib/libMesaGL.so
	do
		if [ -f ${x} -o -L ${x} ]
		then
			# libGL.a cause problems with tuxracer, etc
			mv -f ${x} ${D}/usr/lib/opengl/xfree/lib
		fi
	done
	for x in ${D}/usr/X11R6/lib/modules/extensions/libglx*
	do
		if [ -f ${x} -o -L ${x} ]
		then
			mv -f ${x} ${D}/usr/lib/opengl/xfree/extensions
		fi
	done
	for x in ${D}/usr/X11R6/include/GL/{gl.h,glx.h,glxtokens.h}
	do
		if [ -f ${x} -o -L ${x} ]
		then
			mv -f ${x} ${D}/usr/lib/opengl/xfree/include
		fi
	done
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

	# make sure we do not have any stale files lying round
	# that could break things.
	rm -f ${ROOT}/usr/X11R6/lib/libGL.*
}

pkg_postinst() {

	env-update
	einfo "Making font dirs..."
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/lib" \
	find ${ROOT}/usr/X11R6/lib/X11/fonts/* -type d -maxdepth 1 \
		-exec ${ROOT}/usr/X11R6/bin/mkfontdir {} \;

	# make sure all the Compose files are present
	for x in $(find ${ROOT}/usr/X11R6/lib/X11/locale/ -mindepth 1 -type d)
	do
		if [ ! -f ${x}/Compose ]
		then
			touch ${x}/Compose
		fi
	done

	# switch to the xfree implementation
	if [ "${ROOT}" = "/" ]
	then
		# use new opengl-update that will not reset user selected
		# OpenGL interface ...
		/usr/sbin/opengl-update --use-old xfree
	fi

	# add back directories that portage nukes on unmerge
	if [ ! -d ${ROOT}/var/lib/xdm ]
	then
		mkdir -p ${ROOT}/var/lib/xdm
	fi
	touch ${ROOT}/var/lib/xdm/.keep

	if [ "`use 3dfx`" ]
	then
		einfo
		einfo "If using a 3DFX card, and you had \"3dfx\" in your USE flags,"
		einfo "please merge media-libs/glide-v3 if you have not done so yet"
		einfo "by doing:"
		einfo
		einfo "  # emerge media-libs/glide-v3"
		einfo
	fi
}

pkg_postrm() {

	# Fix problematic links
	if [ -x ${ROOT}/usr/X11R6/bin/XFree86 ]
	then
		ln -snf ../X11R6/bin ${ROOT}/usr/bin/X11
		ln -snf ../X11R6/include/X11 ${ROOT}/usr/include/X11
		ln -snf ../X11R6/include/GL ${ROOT}/usr/include/GL
		ln -snf ../X11R6/lib/X11 ${ROOT}/usr/lib/X11
	fi
}

