# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.2.99.3.ebuild,v 1.12 2002/12/20 23:22:12 seemant Exp $

IUSE="nls 3dfx pam truetype 3dnow sse mmx"

inherit eutils flag-o-matic gcc

filter-flags "-funroll-loops"

PATCH_VER="1.2"
FT2_VER="2.1.2"
FC2_VER="2.1"
SISDRV_VER="141202-1"
SAVDRV_VER="1.1.26t"

MY_V=${PV}
S=${WORKDIR}/xc
S_XFT2="${WORKDIR}/fcpackage.${FC2_VER/\./_}/Xft"
DESCRIPTION="Xfree86: famous and free X server"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/${PV}/source"
SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/${PV}/source"

# Misc patches we may want to fetch
X_PATCHES=""

# Updated Wacom driver
# Homepage:  http://people.mandrakesoft.com/~flepied/projects/wacom/
X_DRIVERS="http://people.mandrakesoft.com/~flepied/projects/wacom/xf86Wacom.c.gz
	http://www.probo.com/timr/savage-${SAVDRV_VER}.tgz
	http://www.webit.at/~twinny/sis/sis_drv_src_${SISDRV_VER}.tar.gz"

# Latest Savage drivers: http://www.probo.com/timr/savage40.html
# Latest SIS drivers: http://www.webit.at/~twinny/linuxsis630.shtml
# Glide stuff is for tdfx modules

# MicroSoft Core fonts
MS_COREFONTS="./andale32.exe ./arial32.exe
	./arialb32.exe ./comic32.exe
	./courie32.exe ./georgi32.exe
	./impact32.exe ./times32.exe
	./trebuc32.exe ./verdan32.exe
	./webdin32.exe"
MS_FONT_URL="${MS_COREFONTS//\.\//mirror://sourceforge/corefonts/}"

SRC_URI="http://www.ibiblio.org/gentoo/gentoo-sources/X${MY_V}-1.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/X${MY_V}-2.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/X${MY_V}-3.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/X${MY_V}-4.tar.bz2
	mirror://sourceforge/freetype/freetype-${FT2_VER}.tar.bz2
	http://www.ibiblio.org/gentoo/gentoo-sources/truetype.tar.gz
	${X_PATCHES}
	${X_DRIVERS}
	truetype? ( ${MS_FONT_URL} )"

HOMEPAGE="http://www.xfree.org"
LICENSE="X11 MSttfEULA"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~mips"

DEPEND=">=sys-libs/ncurses-5.1
	pam? ( >=sys-libs/pam-0.75 )
	>=sys-libs/zlib-1.1.4
	sys-devel/flex
	sys-devel/libtool
	sys-devel/perl
	>=media-libs/freetype-${FT2_VER}-r2
	x11-base/opengl-update
	truetype? ( x11-misc/ttmkfdir
		app-arch/cabextract )"
	
RDEPEND=">=sys-libs/ncurses-5.1
	>=x11-base/opengl-update-1.3
	>=media-libs/fontconfig-2.1"

PROVIDE="virtual/x11
	virtual/opengl
	virtual/glu"

src_unpack () {

	unpack X${MY_V}-{1,2,3,4}.tar.bz2 \
		fcpackage.${FC2_VER/\./_}.tar.gz \
		freetype-${FT2_VER}.tar.bz2

	# Fix permissions
	chmod -R 0755 ${WORKDIR}/fcpackage.${FC2_VER/\./_}/
	

	# Deploy our custom freetype2.  We want it static for stability,
	# and because some things in Gentoo depends the freetype2 that
	# is distributed with XFree86.
#	unpack freetype-${FT2_VER}.tar.bz2
#	cd ${S}/extras/freetype2
#	rm -rf *
#	mv ${WORKDIR}/freetype-${FT2_VER}/* .

	# Install the glide3 headers for compiling the tdfx driver
#	if use 3dfx
#	then
#		ebegin "Installing temporary glide3 headers"
#		cd ${WORKDIR}; unpack glide3-headers.tar.bz2
#		cp -f ${S}/lib/GL/mesa/src/drv/tdfx/Imakefile ${T}
#		sed -e 's:${GLIDE3INCDIR}:${WORKDIR}/glide3:g' \
#			${T}/Imakefile > ${S}/lib/GL/mesa/src/drv/tdfx/Imakefile
#		eend 0
#	fi
	
#	ebegin "Updating Xrender"
#	cd ${S}
#	rm -rf ${S}/lib/Xrender
#	mv ${WORKDIR}/fcpackage.${FC2_VER/\./_}/Xrender ${S}/lib/Xrender || die
#	cp ${S}/lib/Xrender/Imakefile ${S}/lib/Xrender/Imakefile.orig
#	sed -s '2i NONSTANDARD_HEADERS = extutil.h region.h render.h renderproto.h'\
#		${S}/lib/Xrender/Imakefile.orig > ${S}/lib/Xrender/Imakefile
#	eend0


	# Enable hinting for truetype fonts
	cd ${S}/extras/freetype2/include/freetype/config
	cp ftoption.h ftoption.h.orig
	sed -e 's:#undef \(TT_CONFIG_OPTION_BYTECODE_INTERPRETER\):#define \1:' \
		ftoption.h.orig > ftoption.h

	cd ${S}

	# Various patches from all over
	# epatch ${WORKDIR}/patch/
	
	# Update the Savage Driver
	ebegin "Updating Savage driver"
	cd ${S}/programs/Xserver/hw/xfree86/drivers/savage
	tar zxf ${DISTDIR}/savage-${SAVDRV_VER}.tgz || die
	eend 0

	# Update the SIS Driver
	ebegin "Updating SIS Driver"
	cd ${S}/programs/Xserver/hw/xfree86/drivers/sis
	tar zxf ${DISTDIR}/sis_drv_src_${SISDRV_VER}.tar.gz || die
	eend 0

	# Update Wacom Driver, hopefully resolving bug #1632
	# The kernel driver should prob also be updated, this can be
	# found at:
	#
	#  http://people.mandrakesoft.com/~flepied/projects/wacom/
	#
	if [ "`uname -r | cut -d. -f1.2`" != "2.2" ]
	then
		ebegin "Updating Wacom USB Driver"
		gzip -dc ${DISTDIR}/xf86Wacom.c.gz > \
			${S}/programs/Xserver/hw/xfree86/input/wacom/xf86Wacom.c || die
		eend 0
	fi

	# Unpack the MS fonts
	if use truetype
	then
		ebegin "Unpacking MS Core Fonts"
		mkdir -p ${WORKDIR}/truetype; cd ${WORKDIR}/truetype
		for x in ${MS_COREFONTS}
		do
			if [ -f ${DISTDIR}/${x} ]
			then
				einfo "   ${s/\. \/}..."
				cabextract --lowercase ${DISTDIR}/${x} > /dev/null || die
			fi
		done
		eend 0
	fi


	ebegin "Setting up config/cf/host.def"
	cd ${S}
	cp ${FILESDIR}/${PVR}/site.def config/cf/host.def || die
	echo "#define XVendorString \"Gentoo Linux (XFree86 ${PV}, revision ${PR})\"" \
		>> config/cf/host.def
	echo "#define OptimizedCDebugFlags ${CFLAGS}" >> config/cf/host.def
	echo "#define GccWarningOptions -pipe" >> config/cf/host.def

	if [ "`gcc-version`" != "2.95" ]
	then
		export CFLAGS="${CFLAGS/-march=pentium4/-march=pentium3}"
		export CXXFLAGS="${CXXFLAGS/-march=pentium4/-march=pentium3}"
		export CFLAGS="${CFLAGS/-march=athlon-tbird/-march=athlon}"
		export CXXFLAGS="{CXXFLAGS/-march=athlon-tbird/-march=athlon}"

		if [ "`gcc-version`" = "3.1" ]
		then
			export CFLAGS="${CFLAGS} -fno-merge-constants"
			export CXXFLAGS="${CXXFLAGS} -fno-merge-constants"
		fi
	fi
	
	cd ${S}

	if [ "${DEBUGBUILD}" != "true" ]
	then
		# use less ram from Spider's makeedit.eclass
		echo "#define GccWarningOptions -Wno-return-type -w" \
			>> config/cf/host.def
	fi
	
	if use x86
	then
		# optimize Mesa for architecture
		if use mmx
		then
			echo "#define HasMMXSupport	YES" >> config/cf/host.def
			echo "#define MesaUseMMX YES" >> config/cf/host.def
		fi
		if use 3dnow
		then
			echo "#define Has3DNowSupport YES" >> config/cf/host.def
			echo "#define MesaUse3DNow YES" >> config/cf/host.def
		fi
		if use sse
		then
			echo "#define HasKatmaiSupport YES" >> config/cf/host.def
			echo "#define MesaUseKatmai YES" >> config/cf/host.def
		fi
	fi

	if [ "`uname -r | cut -d. -f1,2`" != "2.2" ]
	then
		echo "#define HasLinuxInput YES" >> config/cf/host.def
	fi

	# build with glide3 support? (build the tdfx_dri.o module)
	if use 3dfx
	then
		echo "#define HasGlide3 YES" >> config/cf/host.def
	fi

	if use nls
	then
		echo "#define XtermWithI18N YES" >> config/cf/host.def
	fi
	eend 0
	
	# Not included anymore -- obsolete
	rm -f ${S}/doc/hardcopy/{XIE,PEX5}
	for x in ${S}/programs/Xserver/hw/xfree86/{XF98Conf.cpp,XF98Config}
	do
		if [ -f ${x} ]
		then
			cp ${x} ${x}.orig
			grep -iv 'Load[[:space:]]*"\(pex5\|xie\)"' ${x}.orig > ${x}
			rm -f ${x}.orig
		fi
	done

	# fix build problem (XFree86 server among others, was not
	#					linked against libXau)
	cp ${S}/programs/Xserver/Imakefile \
		${S}/programs/Xserver/Imakefile.orig
	sed -e '2i CCLINK = $(CC) -L../../lib/Xau -lXau' \
		${S}/programs/Xserver/Imakefile.orig \
		> ${S}/programs/Xserver/Imakefile

	# LibPNG fixes
	cd ${S}
	cp xmakefile xmakefile.orig
	sed "s:-lpng:-lpng -lz -lm:" \
		xmakefile.orig > xmakefile

	cd ${S}/config/cf
	cp X11.tmpl X11.tmpl.orig
	sed "s:-lpng:-lpng -lz -lm:" \
		X11.tmpl.orig > X11.tmpl
	
	cd ${S}

}

src_compile() {

	einfo "Building XFree86..."
	emake World || die

	if use nls
	then
		cd ${S}/nls
		make || die
	fi
}

src_install() {

	einfo "Installing Xfree86..."
	# gcc3 related fix.  Do this during install, so that our whole build
	# will not be compiled without mmx instructions.
	if [ "`gcc-version`" != "2.95" ] && [ "${ARCH}" ="x86" ]
	then
		make install DESTDIR=${D} ||  \
		make CXXDEBUGFLAGS="${CXXDEBUGFLAGS} -mno-mmx" \
			CDEBUGFLAGS="${CDEBUGFLAGS} -mno-mmx" \
			install DESTDIR=${D} || die
	else
		make install DESTDIR=${D} || die
	fi
	
	einfo "Installing man pages..."
	make install.man DESTDIR=${D} || die
	einfo "Compressing man pages..."
	prepman /usr/X11R6

	if use nls
	then
		cd ${S}/nls
		make DESTDIR=${D} install || die
		cd ${S}
	fi

	# Make sure the user running xterm can only write to utmp
	fowners root.utmp /usr/X11R6/bin/xterm
	fperms 2755 /usr/X11R6/bin/xterm

	# Fix permissions on locale/common/*.so
	for x in /usr/X11R6/lib/X11/locale/common/*.so*
	do
		if [ -f ${x} ]
		then
			fperms 0755 ${x}
		fi
	done


	# we zap our CFLAGS in the host.def file, as hardcoded CFLAGS can
	# mess up other things that use xmkmf
	ebegin "Fixing /usr/X11R6/lib/X11/config/host.def"
	cp ${D}/usr/X11R6/lib/X11/config/host.def ${T}
	awk '!/OptimizedCDebugFlags|OptimizedCplusplusDebugFlags|GccWarningOptions/ {print $0}' \
		${T}/host.def > ${D}/usr/X11R6/lib/X11/config/host.def
	# theoretically, /usr/X11R6/lib/X11/config is a possible candidate for
	# config file management. If we find that people really worry about imake
	# stuff, we may add it.  But for now, we leave the dir unprotected.
	eend 0

	insinto /etc/X11
	# Let's use fontconfig now
	doins ${FILESDIR}/${PVR}/XftConfig
	newins ${FILESDIR}/${PVR}/XftConfig XftConfig.new
	dosym ../../../../etc/X11/XftConfig /usr/X11R6/lib/X11/XftConfig
	#cd ${D}/usr/X11R6/lib/X11/fonts
	#tar -xz --no-same-owner -f ${DISTDIR}/truetype.tar.gz || \
	#	die "Failed to unpack truetype.tar.gz"

	# Install example config file
	newins ${S}/programs/Xserver/hw/xfree86/XF86Config XF86Config.example

	# Install MS fonts
	if [ use truetype ]
	then
		ebegin "Installing MS Core Fonts"
		dodir /usr/X11R6/lib/X11/fonts/truetype
		cp -af ${WORKDIR}/truetype/*.ttf ${D}/usr/X11R6/lib/X11/fonts/truetype
		eend 0
	fi
	
	# Standard symlinks
	dodir /usr/{bin,include,lib}
	dosym ../X11R6/bin /usr/bin/X11
	dosym ../X11R6/include/X11 /usr/include/X11
	dosym ../X11R6/include/DPS /usr/include/DPS
	dosym ../X11R6/include/GL /usr/include/GL
	dosym ../usr/X11R6/lib/X11 /usr/lib/X11
	dosym ../../usr/X11R6/lib/X11/xkb /etc/X11/xkb

	# Some critical directories
	keepdir /var/lib/xdm
	dosym ../../../var/lib/xdm /etc/X11/xdm/authdir

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

	# Some Xft2.0 checks to ease things a bit
	if [ -L ${ROOT}/usr/X11R6/lib/libXft.so ]
	then
		local libxft_link="`readlink ${ROOT}/usr/X11R6/lib/libXft.so`"

		if [ "${libxft_link###/}" = "libXft.so.2.0" ] && \
			[ -f ${ROOT}/usr/lib/libXft.so.2.0 ]
			then
				# Do not overwrite /usr/X11R6/lib/libXft.so if we have
				# Xft2.0 installed
				rm -f ${D}/usr/X11R6/lib/libXft.so

				# Move Xft1.1 headers to not overwrite Xft2.0 headers
				mv -f ${D}/usr/X11R6/include/X11/Xft \
					${D}/usr/X11R6/include/X11/Xft1
		fi
	fi

	# Remove libz.a as it causes problems (bug #4777 and andee in #gentoo)
	rm -f ${D}/usr/X11R6/lib/libz.a
	# And do not forget the includes (bug #9470)
	rm -f ${D}/usr/X11R6/include/{zconf.h,zlib.h}

	# Hack from Mandrake for locales
	for x in $(find ${D}/usr/X11R6/lib/X11/locale/ -mindepth 1 -type d)
	do
		# make empty Compose files for some locales
		# CJK must not have that file otherwise XIM doesn't work at times
		case `basename ${x}` in
			C|microsoft-*|iso8859-*|koi8-*)
				if [ ! -f ${x}/Compose ]
				then
					touch ${x}/Compose
				fi
				;;
			ja*|ko*|zh*)
				if [ -r "${x}/Compose" ]
				then
					rm -f ${x}/Compose
				fi
				;;
		esac
	done

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
	newins ${FILESDIR}/${PVR}/xdm.pamd xdm
	newins ${FILESDIR}/${PVR}/xserver.pamd xserver
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PVR}/xdm.start xdm
	newexe ${FILESDIR}/${PVR}/xfs.start xfs
	insinto /etc/conf.d
	newins ${FILESDIR}/${PVR}/xfs.conf.d xfs

	# we want libGLU.so* in /usr/lib
	mv ${D}/usr/X11R6/lib/libGLU.* ${D}/usr/lib

	# next section is to setup the dynamic libGL stuff
	ebegin "Moving libGL for dynamic switching"
	dodir /usr/lib/opengl/xfree/{lib,extensions,include}
	local x=""
	for x in ${S}/usr/X11R6/lib/libGL.so* \
		${D}/usr/X11R6/lib/libGL.la \
		${D}/usr/X11R6/lib/libGL.a \
		${D}/usr/X11R6/lib/libMesaGL.so
	do
		if [ -f ${x} -o -L ${x} ]
		then
			# libGL.a causes problems with tuxracer
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
	for x in ${D}/usr/X11R6/include/GL/{gl.h,glx,h,gkxtokens.h}
	do
		if [ -f ${x} -o -L ${x} ]
		then
			mv -f ${x} ${D}/usr/lib/opengl/xfree/include
		fi
	done
	eend 0
}

pkg_preinst() {
	# These changed from a directory/file to a symlink and reverse
	if [ ! -L ${ROOT}/usr/X11R6/lib/X11/XftConfig ] && \
	   [ -f ${ROOT}/usr/X11R6/lib/X11/XftConfig ]
	then
		rm -rf ${ROOT}/usr/X11R6/lib/X11/XftConfig
	fi

	if [ -L ${ROOT}/etc/X11/app-defaults ]
	then
		rm -f ${ROOT}/etc/X11/app-defaults
	fi

	if [ ! -L ${ROOT}/usr/X11R6/lib/X11/app-defaults ] && \
	   [ -d ${ROOT}/usr/X11R6/lib/X11/app-defaults ]
	then
		if [ ! -d ${ROOT}/etc/X11/app-defaults ]
		then
			mkdir -p ${ROOT}/etc/X11/app-defaults
		fi

		mv -f ${ROOT}/usr/X11R6/lib/X11/app-defaults ${ROOT}/etc/X11
	fi

	if [ -L ${ROOT}/usr/X11R6/lib/X11/xkb ]
	then
		rm -f ${ROOT}/usr/X11R6/lib/X11/xkb
	fi

	if [ ! -L ${ROOT}/etc/X11/xkb ] && \
	   [ -d ${ROOT}/etc/X11/xkb ]
	then
		if [ ! -d ${ROOT}/usr/X11R6/lib/X11/xkb ]
		then
			mkdir -p ${ROOT}/usr/X11R6/lib/X11
		fi

		mv -f ${ROOT}/etc/X11/xkb ${ROOT}/usr/X11R6/lib/X11
	fi

	# This one was borked, so make sure fixed one gets installed.
	if [ -L ${ROOT}/usr/lib/X11 ]
	then
		rm -f ${ROOT}/usr/lib/X11
	fi

	# clean the dinamic libGL stuff's home to ensure
	# we dont have stale libs floating around
	if [ -d ${ROOT}/usr/lib/opengl/xfree ]
	then
		rm -rf ${ROOT}/usr/lib/opengl/xfree/*
	fi

	# clean out old fonts.* and encodings.dir files, as we
	# will regenerate them
	find ${ROOT}/usr/X11R6/lib/X11/fonts/ -type f -name 'fonts.*' \
		-exec rm -f {} \;
	find ${ROOT}/usr/X11R6/lib/X11/fonts/ -type f -name 'encodings.dir' \
		-exec rm -f {} \;

	# make sure we do not have any stale files lying round
	# that could break things.
	rm -f ${ROOT}/usr/X11R6/lib/libGL.*

}

update_XftConfig() {

	if [ "${ROOT}" = "/" ]
	then
		local CHECK1="f901d29ec6e3cbb0a5b0fd5cbdd9ff33"
		local CHECK2="$(md5sum ${ROOT}/etc/X11/XftConfig | cut -d ' ' -f1)"

		if [ "${CHECK1}" = "${CHECK2}" ]
		then
			echo
			ewarn "Due to an invalid /etc/X11/XftConfig from x11-base/xfree-4.2.1,"
			ewarn "/etc/X11/XftConfig is being updated automatically.  Your
old"
			ewarn "version of /etc/X11/XftConfig will be backed up as:"
			ewarn
			ewarn "  ${ROOT}etc/X11/XftConfig.bak"
			echo

			cp -a ${ROOT}/etc/X11/XftConfig \
				${ROOT}/etc/X11/XftConfig.bak
			mv -f ${ROOT}/etc/X11/XftConfig.new \
				${ROOT}/etc/X11/XftConfig
			rm -f ${ROOT}/etc/X11/._cfg????_XftConfig
		else
			rm -f ${ROOT}/etc/X11/XftConfig.new
		fi
	fi
}

pkg_postinst() {

	env-update

	if [ "${ROOT}" = "/" ]
	then
		local x=""

		umask 022

		if [ -x ${ROOT}/usr/bin/fc-cache ]
		then
			ebegin "Creating FC font cache..."
			HOME="/root" ${ROOT}/usr/bin/fc-cache -f
			eend 0
		fi

		# This one cause ttmkfdir to segfault :/
		#rm -f ${ROOT}/usr/X11R6/lib/X11/fonts/encodings/large/gbk-0.enc.gz

		# ********************************************************************
		#  A note about fonts and needed files:
		#
		#  1)  Create /usr/X11R6/lib/X11/fonts/encodings/encodings.dir
		#
		#  2)  Create font.scale for TrueType fonts (need to do this before
		#	  we create fonts.dir files, else fonts.dir files will be
		#	  invalid for TrueType fonts...)
		#
		#  3)  Now Generate fonts.dir files.
		#
		#  CID fonts is a bit more involved, but as we do not install any,
		#  I am not going to bother.
		#
		#  <azarah@gentoo.org> (20 Oct 2002)
		#
		# ********************************************************************

		ebegin "Generating encodings.dir..."
		# Create the encodings.dir in /usr/X11R6/lib/X11/fonts/encodings
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/lib" \
		${ROOT}/usr/X11R6/bin/mkfontdir -n \
			-e ${ROOT}/usr/X11R6/lib/X11/fonts/encodings \
			-e ${ROOT}/usr/X11R6/lib/X11/fonts/encodings/large \
			-- ${ROOT}/usr/X11R6/lib/X11/fonts/encodings
		eend 0

		if [ -x ${ROOT}/usr/X11R6/bin/ttmkfdir ]
		then
			ebegin "Creating fonts.scale files..."
			for x in $(find ${ROOT}/usr/X11R6/lib/X11/fonts/* -type d -maxdepth 1)
			do
				[ -z "$(ls ${x}/)" ] && continue
				[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

				# Only generate .scale files if there are truetype
				# fonts present ...
				if [ "${x/encodings}" = "${x}" -a \
					 -n "$(find ${x} -iname '*.tt[cf]' -print)" ]
				then
					${ROOT}/usr/X11R6/bin/ttmkfdir \
						-e
${ROOT}/usr/X11R6/lib/X11/fonts/encodings/encodings.dir \
						-o ${x}/fonts.scale -d ${x}
				fi
			done
			eend 0
		fi

		ebegin "Generating fonts.dir files..."
		for x in $(find ${ROOT}/usr/X11R6/lib/X11/fonts/* -type d -maxdepth 1)
		do
			[ -z "$(ls ${x}/)" ] && continue
			[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

			if [ "${x/encodings}" = "${x}" ]
			then
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/lib" \
				${ROOT}/usr/X11R6/bin/mkfontdir \
					-e ${ROOT}/usr/X11R6/lib/X11/fonts/encodings \
					-e ${ROOT}/usr/X11R6/lib/X11/fonts/encodings/large \
					-- ${x}
			fi
		done
		eend 0

		ebegin "Generating Xft Cache..."
		for x in $(find ${ROOT}/usr/X11R6/lib/X11/fonts/* -type d -maxdepth 1)
		do
			[ -z "$(ls ${x}/)" ] && continue
			[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

			# Only generate XftCache files if there are truetype
			# fonts present ...
			if [ "${x/encodings}" = "${x}" ] && \
			   [ -n "$(find ${x} -iname '*.tt[cf]' -print)" -o \
				 -n "$(find ${x} -iname '*.pf[ab]' -print)" ]
			then
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/lib" \
					${ROOT}/usr/X11R6/bin/xftcache ${x} &> /dev/null
			fi
		done
		eend 0

		ebegin "Fixing permissions..."
		find ${ROOT}/usr/X11R6/lib/X11/fonts/ -type f -name 'font.*' \
			-exec chmod 0644 {} \;
		eend 0

		# Switch to the xfree implementation.
		# Use new opengl-update that will not reset user selected
		# OpenGL interface ...
		echo; ${ROOT}/usr/sbin/opengl-update --use-old xfree
	fi

	for x in $(find ${ROOT}/usr/X11R6/lib/X11/locale/ -mindepth 1 -type d)
	do
		# Remove old compose files we might have created incorrectly
		# CJK must not have that file (otherwise XIM don't works some times)
		case `basename ${x}` in
			ja*|ko*|zh*)
				if [ -r "${x}/Compose" ]
				then
					rm -f ${x}/Compose
				fi
				;;
		esac
	done

	# Update /etc/X11/XftConfig if its the one from Xft1.2, as its
	# invalid for Xft1.1 ....
	update_XftConfig

	# These need to be owned by root and the correct permissions
	# (bug #8281)
	for x in ${ROOT}/tmp/.{ICE,X11}-unix
	do
		if [ ! -d ${x} ]
		then
			mkdir -p ${x}
		fi

		chown root:root ${x}
		chmod 1777 ${x}
	done

	if [ "`use 3dfx`" ]
	then
		echo
		einfo "If using a 3DFX card, and you had \"3dfx\" in your USE
flags,"
		einfo "please merge media-libs/glide-v3 if you have not done so yet"
		einfo "by doing:"
		einfo
		einfo "  # emerge media-libs/glide-v3"
		echo
	fi
}

pkg_postrm() {
	
	# Fix problematic links
	if [ -x ${ROOT}/usr/X11R6/bin/XFree86 ]
	then
		ln -snf ../X11R6/bin ${ROOT}/usr/bin/X11
		ln -snf ../X11R6/include/X11 ${ROOT}/usr/include/X11
		ln -snf ../X11R6/include/DPS ${ROOT}/usr/include/DPS
		ln -snf ../X11R6/include/GL  ${ROOT}/usr/include/GL
		ln -snf ../X11R6/lib/X11 ${ROOT}/usr/lib/X11
	fi
}
