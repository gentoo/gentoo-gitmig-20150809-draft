# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.3.0-r2.ebuild,v 1.11 2003/04/14 05:30:41 seemant Exp $

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
DEBUG="yes"
RESTRICT="nostrip"

IUSE="3dfx sse mmx 3dnow xml truetype"

inherit eutils flag-o-matic gcc

filter-flags "-funroll-loops"

ALLOWED_FLAGS="-fstack-protector -march -mcpu -O -O2 -O3 -pipe"

# Recently there has been a lot of stability problem in Gentoo-land.  Many
# things can be the cause to this, but I believe that it is due to gcc3
# still having issues with optimizations, or with it not filtering bad
# combinations (protecting the user maybe from themselves) yet.
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

# Are we using a snapshot ?
USE_SNAPSHOT="no"

PATCH_VER="1.0.7"
FT2_VER="2.1.3"
SISDRV_VER="060403-1"
SAVDRV_VER="1.1.27t"

BASE_PV="${PV}"
MY_SV="${BASE_PV//\.}"
S="${WORKDIR}/xc"
DESCRIPTION="Xfree86: famous and free X server"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/${BASE_PV}/source"
SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/${BASE_PV}/source"
HOMEPAGE="http://www.xfree.org"

# Misc patches we may need to fetch ..
X_PATCHES="mirror://gentoo/XFree86-${PV}-patches-${PATCH_VER}.tar.bz2
	http://www.cpbotha.net/files/dri_resume/xfree86-dri-resume-v8.patch"

X_DRIVERS="http://people.mandrakesoft.com/~flepied/projects/wacom/xf86Wacom.c.gz
	http://www.probo.com/timr/savage-${SAVDRV_VER}.zip
	http://www.winischhofer.net/sis/sis_drv_src_${SISDRV_VER}.tar.gz"
#	3dfx? ( mirror://gentoo/glide3-headers.tar.bz2 )"
# Updated Wacom driver:  http://people.mandrakesoft.com/~flepied/projects/wacom/
# Latest Savaga drivers:  http://www.probo.com/timr/savage40.html
# Latest SIS drivers:  http://www.winischhofer.net/
# Glide headers for compiling the tdfx modules

# For the MS Core fonts ..
MS_COREFONTS="./andale32.exe ./arial32.exe
	./arialb32.exe ./comic32.exe
	./courie32.exe ./georgi32.exe
	./impact32.exe ./times32.exe
	./trebuc32.exe ./verdan32.exe
	./webdin32.exe"
#	./IELPKTH.CAB"
# Need windows license to use this one
MS_FONT_URLS="${MS_COREFONTS//\.\//mirror://sourceforge/corefonts/}"

SRC_URI="${SRC_PATH0}/X${MY_SV}src-1.tgz
	${SRC_PATH0}/X${MY_SV}src-2.tgz
	${SRC_PATH0}/X${MY_SV}src-3.tgz
	${SRC_PATH0}/X${MY_SV}src-4.tgz
	${SRC_PATH0}/X${MY_SV}src-5.tgz
	${SRC_PATH0}/X${MY_SV}src-6.tgz
	${SRC_PATH0}/X${MY_SV}src-7.tgz
	${SRC_PATH1}/X${MY_SV}src-1.tgz
	${SRC_PATH1}/X${MY_SV}src-2.tgz
	${SRC_PATH1}/X${MY_SV}src-3.tgz
	${SRC_PATH1}/X${MY_SV}src-4.tgz
	${SRC_PATH1}/X${MY_SV}src-5.tgz
	${SRC_PATH1}/X${MY_SV}src-6.tgz
	${SRC_PATH1}/X${MY_SV}src-7.tgz"

SRC_URI="${SRC_URI}
	${X_PATCHES}
	${X_DRIVERS}
	mirror://gentoo/gemini-koi8-u.tar.bz2
	mirror://gentoo/eurofonts-X11.tar.bz2
	mirror://gentoo/xfsft-encodings.tar.bz2
	mirror://gentoo/XFree86-compose.dir.bz2
	mirror://gentoo/XFree86-en_US.UTF-8.old.bz2
	mirror://gentoo/XFree86-locale.alias.bz2
	mirror://gentoo/XFree86-locale.dir.bz2
	truetype? ( ${MS_FONT_URLS} )"

LICENSE="X11 MSttfEULA"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa arm"

DEPEND=">=sys-apps/baselayout-1.8.3
	>=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	>=sys-devel/flex-2.5.4a-r5
	>=dev-libs/expat-1.95.3
	dev-lang/perl
	>=media-libs/freetype-${FT2_VER}-r2
	>=media-libs/fontconfig-2.1-r1
	media-libs/libpng
	>=x11-base/opengl-update-1.4
	>=x11-misc/ttmkfdir-3.0.4
	pam? ( >=sys-libs/pam-0.75 )
	truetype? ( app-arch/cabextract )
	app-arch/unzip" # needed for savage driver (version 1.1.27t)
	
PDEPEND=">=x11-libs/xft-2.0.1-r1
	3dfx? ( >=media-libs/glide-v3-3.10 )"

PROVIDE="virtual/x11
	virtual/opengl
	virtual/glu"	

src_unpack() {

	# Unpack source and patches
	unpack X${MY_SV}src-{1,2,3,4,5,6,7}.tgz
	unpack XFree86-${PV}-patches-${PATCH_VER}.tar.bz2

	# Unpack extra fonts stuff from Mandrake
	unpack gemini-koi8-u.tar.bz2
	unpack eurofonts-X11.tar.bz2
	unpack xfsft-encodings.tar.bz2
	
	# Remove bum encoding
	rm -f ${WORKDIR}/usr/X11R6/lib/X11/fonts/encodings/urdunaqsh-0.enc
	
	# Update the Savage Driver
	# savage driver 1.1.27t is a .zip and contains a savage directory
	# (that's why we have to be in drivers, not in savage subdir).
	# Could be USE flag based

	ebegin "Updating Savage driver"
	cd ${S}/programs/Xserver/hw/xfree86/drivers
	unzip -oqq ${DISTDIR}/savage-${SAVDRV_VER}.zip || die
	ln -s ${S}/programs/Xserver/hw/xfree86/vbe/vbe.h \
		${S}/programs/Xserver/hw/xfree86/drivers/savage
	cd ${S}
	eend 0

	ebegin "Updating SiS driver"
	cd ${S}/programs/Xserver/hw/xfree86/drivers/sis
	tar -zxf ${DISTDIR}/sis_drv_src_${SISDRV_VER}.tar.gz || die
	ln -s ${S}/programs/Xserver/hw/xfree86/vbe/vbe.h \
		${S}/programs/Xserver/hw/xfree86/drivers/sis
	cd ${S}
	eend 0
    

	if [ "`gcc-version`" = "2.95" ]
	then
		# Do not apply this patch for gcc-2.95.3, as it cause compile to fail,
		# closing bug #10146.
		EPATCH_EXCLUDE="107_all_4.2.1-gcc32-internal-compiler-error.patch.bz2"
	fi

	if [ -z "`use debug`" ]
	then
		rm -f ${WORKDIR}/patch/202_all_4.2.99.3-acecad-debug.patch.bz2
	fi

	if [ "`use 3dfx`" -a "${TDFX_RISKY}" = "yes" ]
	then
		rm #{WORKDIR}/patch/075*
	fi

	# Various Patches from all over
	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/patch/
	
	unset EPATCH_EXCLUDE
	
	# Fix DRI related problems
	cd ${S}/programs/Xserver/hw/xfree86/
	epatch ${DISTDIR}/xfree86-dri-resume-v8.patch
	
	# Update Wacom Driver, hopefully resolving bug #1632
	# The kernel driver should prob also be updated, this can be
	# found at:
	#
	#  http://people.mandrakesoft.com/~flepied/projects/wacom/
	#
	if [ "`uname -r | cut -d. -f1,2`" != "2.2" ]
	then
		ebegin "Updating Wacom USB Driver"
		gzip -dc ${DISTDIR}/xf86Wacom.c.gz > \
			${S}/programs/Xserver/hw/xfree86/input/wacom/xf86Wacom.c || die
		eend 0
	fi
	
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
		ebegin "Done unpacking Core Fonts"; eend 0
	fi
	
	ebegin "Setting up config/cf/host.def"
	cd ${S}; cp ${FILESDIR}/${PV}/site.def config/cf/host.def || die
	echo "#define XVendorString \"Gentoo Linux (XFree86 ${PV}, revision ${PR})\"" \
		>> config/cf/host.def

	# We're using Xwrapper instead -- so that nothing else needs to be
	# set uid any more.
	echo "#define InstallXserverSetUID NO" >> config/cf/host.def
	echo "#define BuildServersOnly NO" >> config/cf/host.def

	# Bug #12775 .. fails with -Os.
	replace-flags "-Os" "-O2"

	if [ "`gcc-version`" != "2.95" ]
	then
		# Should fix bug #4189.  gcc-3.x have problems with -march=pentium4
		# and -march=athlon-tbird
		replace-flags "-march=pentium4" "-march=pentium3"
		replace-flags "-march=athlon-tbird" "-march=athlon"

		# Without this, modules breaks with gcc3
		if [ "`gcc-version`" = "3.1" ]
		then
			export CFLAGS="${CFLAGS} -fno-merge-constants"
			export CXXFLAGS="${CXXFLAGS} -fno-merge-constants"
		fi
	fi

	if [ "`uname -r | cut -d. -f1,2`" != "2.2" ]
	then
		echo "#define HasLinuxInput YES" >> config/cf/host.def
	fi

	echo "#define OptimizedCDebugFlags ${CFLAGS}" >> config/cf/host.def
	echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS}" >> config/cf/host.def
	if [ -n "`use debug`" ]
	then
		echo "#define XFree86Devel	YES" >> config/cf/host.def
		echo "#define DoLoadableServer	NO" >>config/cf/host.def
	else
		echo "#define ExtraXInputDrivers acecad" >> config/cf/host.def
		# use less ram .. got this from Spider's makeedit.eclass :)
		echo "#define GccWarningOptions -Wno-return-type -w" \
			>> config/cf/host.def
	fi

	if [ -n "`use pam`" ]
	then
		# If you want to have optional pam support, do it properly ...
		echo "#define HasPam YES" >> config/cf/host.def
		echo "#define HasPamMisc YES" >> config/cf/host.def
	else
		echo "#define HasPam NO" >> config/cf/host.def
		echo "#define HasPamMisc NO" >> config/cf/host.def
	fi

	if [ -n "`use nls`" ]
	then
		echo "#define XtermWithI18N YES" >> config/cf/host.def
	fi

	if [ "${ARCH}" = "x86" ]
	then
		# optimize Mesa for architecture
		if [ -n "`use mmx`" ]
		then
			echo "#define HasMMXSupport	YES" >> config/cf/host.def
			echo "#define MesaUseMMX YES" >> config/cf/host.def
		fi
		if [ -n "`use 3dnow`" ]
		then
			echo "#define Has3DNowSupport YES" >> config/cf/host.def
			echo "#define MesaUse3DNow YES" >> config/cf/host.def
		fi
		if [ -n "`use sse`" ]
		then
			echo "#define HasKatmaiSupport YES" >> config/cf/host.def
			echo "#define MesaUseKatmai YES" >> config/cf/host.def
		fi

		# build with glide3 support? (build the tdfx_dri.o module)
		if [ -n "`use 3dfx`" ]
		then
			echo "#define HasGlide3 YES" >> config/cf/host.def
		fi
	fi

	if [ "${ARCH}" = "hppa" ]
	then
		echo "#define DoLoadableServer NO" >> config/cf/host.def
	fi

	if [ "${ARCH}" = "alpha" ]
	then
		echo "#define XF86CardDrivers mga nv tga s3virge sis rendition \
			i740 tdfx cirrus tseng fbdev \
			ati vga v4l glint" >> config/cf/host.def
	fi

	if [ "${ARCH}" = "ppc" ]
	then
		echo "#define XF86CardDrivers mga glint s3virge sis savage trident \
			chips tdfx fbdev ati DevelDrivers vga nv XF86OSCardDrivers \
			XF86ExtraCardDrivers" >> config/cf/host.def
	fi

	if [ -n "`use xml`" ]
	then
		echo "#define HasLibxml2 YES" >> config/cf/host.def
	fi

	# The definitions for fontconfig
	echo "#define UseFontconfig YES" >> config/cf/host.def
	echo "#define HasFontconfig YES" >> config/cf/host.def

# Will uncomment this after kde, qt, and *box ebuilds are alterered to use
# it
#	if use xinerama
#	then
#		echo "#define BuildXinerama YES" >> config/cf/host.def
#		echo "#define BuildXineramaLibrary YES" >> config/cf/host.def
#	fi

	# Default to whiteglass maybe?
	echo "#define DefaultCursorTheme whiteglass" >> config/cf/host.def

	# End the host.def definitions here
	eend 0

	cd ${S}
	bzcat ${DISTDIR}/XFree86-compose.dir.bz2 > nls/compose.dir
	bzcat ${DISTDIR}/XFree86-locale.alias.bz2 > nls/locale.alias
	bzcat ${DISTDIR}/XFree86-locale.dir.bz2 > nls/locale.dir
	bzcat ${DISTDIR}/XFree86-en_US.UTF-8.old.bz2 > nls/Compose/en_US.UTF-8

	# These are not included anymore as they are obsolete
	rm -rf ${S}/doc/hardcopy/{XIE,PEX5}
	for x in ${S}/programs/Xserver/hw/xfree86/{XF98Conf.cpp,XF98Config}
	do
		if [ -f ${x} ]
		then
			cp ${x} ${x}.orig
			grep -iv 'Load[[:space:]]*"\(pex5\|xie\)"' ${x}.orig > ${x}
			rm -f ${x}.orig
		fi
	done
}

src_compile() {

	# Set MAKEOPTS to have proper -j? option ..
	get_number_of_jobs

	# If a user defines the MAKE_OPTS variable in /etc/make.conf instead of
	# MAKEOPTS, they'll redefine an internal XFree86 Makefile variable and the
	# xfree build will silently die. This is tricky to track down, so I'm
	# adding a preemptive fix for this issue by making sure that MAKE_OPTS is
	# unset. (drobbins, 08 Mar 2003)
	unset MAKE_OPTS

	einfo "Building XFree86..."
	emake World || die

	if [ -n "`use nls`" ]
	then
		cd ${S}/nls
		make || die
		cd ${S}
	fi
}

src_install() {

	unset MAKE_OPTS

	einfo "Installing XFree86..."
	# gcc3 related fix.  Do this during install, so that our
	# whole build will not be compiled without mmx instructions.
	if [ "`gcc-version`" != "2.95" ] && [ "${ARCH}" = "x86" ]
	then
		make install DESTDIR=${D} || \
		make CDEBUGFLAGS="${CDEBUGFLAGS} -mno-mmx" \
			CXXDEBUGFLAGS="${CXXDEBUGFLAGS} -mno-mmx" \
			install DESTDIR=${D} || die
	else
		make install DESTDIR=${D} || die
	fi

	# We do not want these, so remove them ...
	rm -rf ${D}/usr/X11R6/include/X11/Xft
	rm -f ${D}/usr/X11R6/lib/libXft.{a,so}
	rm -f ${D}/usr/X11R6/bin/xft-config
	rm -f ${D}/usr/X11R6/man/man3/Xft.3x*
	rm -rf ${D}/usr/X11R6/include/fontconfig
	rm -f ${D}/usr/X11R6/lib/libfontconfig.*
	rm -f ${D}/usr/X11R6/bin/{fontconfig-config,fc-cache,fc-list}
	rm -f ${D}/usr/X11R6/man/man3/fontconfig.3x*
	rm -rf ${D}/etc/fonts/

	# This one needs to be in /usr/lib
	insinto /usr/lib/pkgconfig
	doins ${D}/usr/X11R6/lib/pkgconfig/xcursor.pc
	# Now remove the invalid xft.pc, and co ...
	rm -rf ${D}/usr/X11R6/lib/pkgconfig

	einfo "Installing man pages..."
	make install.man DESTDIR=${D} || die
	einfo "Compressing man pages..."
	prepman /usr/X11R6

	if [ -n "`use nls`" ]
	then
		cd ${S}/nls
		make DESTDIR=${D} install || die
	fi

	# Make sure the user running xterm can only write to utmp.
	fowners root.utmp /usr/X11R6/bin/xterm
	fperms 2755 /usr/X11R6/bin/xterm

	# Fix permissions on locale/common/*.so
	for x in ${D}/usr/X11R6/lib/X11/locale/lib/common/*.so*
	do
		if [ -f ${x} ]
		then
			fperms 0755 `echo ${x} | sed -e "s|${D}||"`
		fi
	done

	# Fix permissions on modules ...
	for x in $(find ${D}/usr/X11R6/lib/modules -name '*.o') \
	         $(find ${D}/usr/X11R6/lib/modules -name '*.so')
	do
		if [ -f ${x} ]
		then
			fperms 0755 `echo ${x} | sed -e "s|${D}||"`
		fi
	done

	# We zap our CFLAGS in the host.def file, as hardcoded CFLAGS can
	# mess up other things that use xmkmf
	ebegin "Fixing lib/X11/config/host.def"
	cp ${D}/usr/X11R6/lib/X11/config/host.def ${T}
	awk '!/OptimizedCDebugFlags|OptimizedCplusplusDebugFlags|GccWarningOptions/ {print $0}' \
		${T}/host.def > ${D}/usr/X11R6/lib/X11/config/host.def
	# theoretically, /usr/X11R6/lib/X11/config is a possible candidate for
	# config file management. If we find that people really worry about imake
	# stuff, we may add it.  But for now, we leave the dir unprotected.
	eend 0

	insinto /etc/X11
	# We still use freetype for now ...
	doins ${FILESDIR}/${PV}/XftConfig
	newins ${FILESDIR}/${PV}/XftConfig XftConfig.new
	# This is if we are using Fontconfig only ...
	#newins ${S}/lib/Xft1/XftConfig-OBSOLETE XftConfig
	dosym ../../../../etc/X11/XftConfig /usr/X11R6/lib/X11/XftConfig

	# Install example config file
	newins ${S}/programs/Xserver/hw/xfree86/XF86Config XF86Config.example
	
	# Install MS fonts.
	if [ -n "`use truetype`" ]
	then
		ebegin "Installing MS Core Fonts"
		dodir /usr/X11R6/lib/X11/fonts/truetype
		cp -af ${WORKDIR}/truetype/*.ttf ${D}/usr/X11R6/lib/X11/fonts/truetype
		eend 0
	fi

	# EURO support
	ebegin "Euro Support..."
	${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-8x14.bdf | \
		gzip -9 > ${D}/usr/X11R6/lib/X11/fonts/misc/Xlat9-8x14-lat9.pcf.gz
	${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-9x16.bdf | \
		gzip -9 > ${D}/usr/X11R6/lib/X11/fonts/misc/Xlat9-9x16-lat9.pcf.gz
	eend 0

	# Change the silly red pointer to a white one ...
	if [ -f "${D}/usr/X11R6/lib/X11/icons/default/index.theme" ]
	then
		dosed 's:core:whiteglass:' /usr/X11R6/lib/X11/icons/default/index.theme
	
	elif [ -f "${D}/usr/share/cursors/xfree/default/index.theme" ]
	then
		dosed 's:core:whiteglass:'/usr/share/cursors/xfree/default/index.theme
	fi

	# Standard symlinks
	dodir /usr/{bin,include,lib}
	dosym ../X11R6/bin /usr/bin/X11
	dosym ../X11R6/include/X11 /usr/include/X11
	dosym ../X11R6/include/DPS /usr/include/DPS
	dosym ../X11R6/include/GL /usr/include/GL
	dosym ../X11R6/lib/X11 /usr/lib/X11
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
	doins ${FILESDIR}/${PV}/lib/*.la

	# Remove libz.a, as it causes problems (bug #4777)
	rm -f ${D}/usr/X11R6/lib/libz.a
	# And do not forget the includes (bug #9470)
	rm -f ${D}/usr/X11R6/include/{zconf.h,zlib.h}

	# Use the Xwrapper as the X binary
	rm -f ${D}/usr/X11R6/bin/X
	dosym Xwrapper /usr/X11R6/bin/X
	dosym ../../usr/X11R6/bin/XFree86 /etc/X11/X

	# Fix perms
	fperms 755 /usr/X11R6/lib/X11/xkb/geometry/sgi
	fperms 755 /usr/X11R6/bin/dga

	# Hack from Mandrake (update ours that just created Compose files for
	# all locales)
	for x in $(find ${D}/usr/X11R6/lib/X11/locale/ -mindepth 1 -type d)
	do
		# make empty Compose files for some locales
		# CJK must not have that file (otherwise XIM don't works some times)
		case `basename ${x}` in
			C|microsoft-*|iso8859-*|koi8-*)
				if [ ! -f ${x}/Compose ]
				then
					touch ${x}/Compose
				fi
				;;
			ja*|ko*|zh*)
				if [ -r ${x}/Compose ]
				then
					rm -f ${x}/Compose
				fi
				;;
		esac
	done
	
	# Another hack from Mandrake -- to fix dead + space for the us
	# international keyboard
	for i in ${D}/usr/X11R6/lib/X11/locale/*/Compose
	do
		sed -i \
			-e 's/\(<dead_diaeresis> <space>\).*$/\1 : "\\"" quotedbl/' \
			-e "s/\(<dead_acute> <space>\).*$/\1 : \"'\" apostrophe/" \
			${i}
	done

	# Yet more Mandrake
	ebegin "Encoding files for xfsft font server..."
	dodir /usr/X11R6/lib/X11/fonts/encodings
	cp -a ${WORKDIR}/usr/X11R6/lib/X11/fonts/encodings/* \
		${D}/usr/X11R6/lib/X11/fonts/encodings
	
	for x in ${D}/usr/X11R6/lib/X11/fonts/encodings/{.,large}/*.enc
	do
		[ -f "${x}" ] && gzip -9 -f ${x}
	done
	eend 0

	ebegin "gemini-koi8 fonts..."
	cd ${WORKDIR}/ukr
	gunzip *.Z
	gzip -9 *.pcf
	cd ${S}
	cp -a ${WORKDIR}/ukr ${D}/usr/X11R6/lib/X11/fonts
	eend 0
	
	exeinto /etc/X11
	# new session management script
	doexe ${FILESDIR}/${PV}/chooser.sh
	# new display manager script
	doexe ${FILESDIR}/${PV}/startDM.sh
	exeinto /etc/X11/Sessions
	for x in ${FILESDIR}/${PV}/Sessions/*
	do
		[ -f ${x} ] && doexe ${x}
	done
	insinto /etc/env.d
	doins ${FILESDIR}/${PV}/10xfree
	insinto /etc/X11/xinit
	doins ${FILESDIR}/${PV}/xinitrc
	exeinto /etc/X11/xdm
	doexe ${FILESDIR}/${PV}/Xsession ${FILESDIR}/${PV}/Xsetup_0
	insinto /etc/X11/fs
	newins ${FILESDIR}/${PV}/xfs.config config
	if [ -n "`use pam`" ]
	then
		insinto /etc/pam.d
		newins ${FILESDIR}/${PV}/xdm.pamd xdm
		# Need to fix console permissions first
		newins ${FILESDIR}/${PV}/xserver.pamd xserver
	fi
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PV}/xdm.start xdm
	newexe ${FILESDIR}/${PV}/xfs.start xfs
	insinto /etc/conf.d
	newins ${FILESDIR}/${PV}/xfs.conf.d xfs

	# we want libGLU.so* in /usr/lib
	mv ${D}/usr/X11R6/lib/libGLU.* ${D}/usr/lib

	# next section is to setup the dynamic libGL stuff
	ebegin "Moving libGL and friends for dynamic switching"
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
	eend 0

	einfo "Striping binaries and libraries..."
	# This bit I got from Redhat ... strip binaries and drivers ..
	# NOTE:  We do NOT want to strip the drivers, modules or DRI modules!
	for x in $(find ${D}/ -type f -perm +0111 -exec file {} \; | \
	           grep -v ' shared object,' | \
	           sed -n -e 's/^\(.*\):[  ]*ELF.*, not stripped/\1/p')
	do
	if [ -f ${x} ]
		then
			# Dont do the modules ...
			if [ "${x/\/usr\/X11R6\/lib\/modules}" = "${x}" ]
			then
				echo "`echo ${x} | sed -e "s|${D}||"`"
				strip ${x} || :
			fi
		fi
	done
	# Now do the libraries ...
	for x in ${D}/usr/{lib,lib/opengl/xfree/lib}/*.so.* \
		${D}/usr/X11R6/{lib,lib/X11/locale/lib/common}/*.so.*
	do
		if [ -f ${x} ]
		then
			echo "`echo ${x} | sed -e "s|${D}||"`"
			strip --strip-debug ${x} || :
		fi
	done

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
	rm -f ${ROOT}/usr/X11R6/lib/libGL*
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
			ewarn "/etc/X11/XftConfig is being updated automatically.  Your old"
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
		#      we create fonts.dir files, else fonts.dir files will be
		#      invalid for TrueType fonts...)
		#
		#  3)  Now Generate fonts.dir files.
		#
		#  CID fonts is a bit more involved, but as we do not install any,
		#  thus I am not going to bother.
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
				     -n "$(find ${x} -iname '*.[otps][pft][cfad]' -print)" ]
				then
					${ROOT}/usr/X11R6/bin/ttmkfdir -x 2 \
						-e ${ROOT}/usr/X11R6/lib/X11/fonts/encodings/encodings.dir \
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
			if [ "${x/encodings}" = "${x}" -a \
			     -n "$(find ${x} -iname '*.[otps][pft][cfad]' -print)" ]
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
	# NOTE:  This should not be needed for xfree-4.2.99 or later,
	#        but lets not take chances with people that may downgrade
	#        at a later stage ....
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
		einfo "If using a 3DFX card, and you had \"3dfx\" in your USE flags,"
		einfo "please merge media-libs/glide-v3 if you have not done so yet"
		einfo "by doing:"
		einfo
		einfo "  # emerge media-libs/glide-v3"
		echo
	fi
	echo
	ewarn "BEWARE 1:"
	ewarn "This version of XFree won't work with ati-drivers-2.5.1-r1"
	ewarn "if you are using them please unmerge ati-drivers"
	ewarn " and emerge xfree-drm"
	echo
	ewarn "BEWARE 2:"
	ewarn "If you experience font corruption on OpenOffice.org or similar"
	ewarn "glitches please remake your XF86Config"
	echo

	einfo "Please note that the xcursors are in /usr/share/cursors/xfree"
	einfo "Any custom cursor sets should be placed in that directory"
	einfo "This is different from the previous versions of 4.3 and"
	einfo "the 4.2.99 series."
	
}

pkg_postrm() {

	# Fix problematic links
	if [ -x ${ROOT}/usr/X11R6/bin/XFree86 ]
	then
		ln -snf ../X11R6/bin ${ROOT}/usr/bin/X11
		ln -snf ../X11R6/include/X11 ${ROOT}/usr/include/X11
		ln -snf ../X11R6/include/DPS ${ROOT}/usr/include/DPS
		ln -snf ../X11R6/include/GL ${ROOT}/usr/include/GL
		ln -snf ../X11R6/lib/X11 ${ROOT}/usr/lib/X11
	fi
}
