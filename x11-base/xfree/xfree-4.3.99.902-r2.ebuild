# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.3.99.902-r2.ebuild,v 1.9 2004/04/08 05:56:25 spyderous Exp $

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

# IUSE="sse mmx 3dnow" were disabled in favor of autodetection
# IUSE="gatos" disabled because gatos is broken on ~4.4 now (31 Jan 2004)
IUSE="3dfx cjk debug doc ipv6 nls pam sdk static truetype xml2"
IUSE_INPUT_DEVICES="synaptics wacom"

filter-flags "-funroll-loops"

ALLOWED_FLAGS="-fstack-protector -march -mcpu -O -O1 -O2 -O3 -pipe -fomit-frame-pointer"

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
USE_SNAPSHOT="yes"

FILES_VER="0.1"
PATCH_VER="0.5"
FT2_VER="2.1.4"
XCUR_VER="0.3.1"
SISDRV_VER="021203-1"
SAVDRV_VER="1.1.27t"
MGADRV_VER="1_3_0beta"
#VIADRV_VER="0.1"

BASE_PV="${PV}"
MY_SV="XFree86-${BASE_PV}"

S="${WORKDIR}/xc"
FILES_DIR="${WORKDIR}/files"
PATCH_DIR="${WORKDIR}/patch"

SRC_PATH0="ftp://ftp.xfree86.org/pub/XFree86/develsnaps"

HOMEPAGE="http://www.xfree.org"

# Misc patches we may need to fetch ..
X_PATCHES="http://dev.gentoo.org/~spyderous/xfree/patchsets/${PV}/XFree86-${PV}-patches-${PATCH_VER}.tar.bz2"

X_DRIVERS="http://people.mandrakesoft.com/~flepied/projects/wacom/xf86Wacom.c.gz
	http://www.probo.com/timr/savage-${SAVDRV_VER}.zip"
#	http://www.winischhofer.net/sis/sis_drv_src_${SISDRV_VER}.tar.gz"
#	mirror://gentoo/XFree86-${PV}-drivers-via-${VIADRV_VER}.tar.bz2
# Updated Wacom driver:  http://people.mandrakesoft.com/~flepied/projects/wacom/
# Latest Savage drivers:  http://www.probo.com/timr/savage40.html
# Latest SIS drivers:  http://www.winischhofer.net/

# For the MS Core fonts ..
MS_COREFONTS="./andale32.exe ./arial32.exe
	./arialb32.exe ./comic32.exe
	./courie32.exe ./georgi32.exe
	./impact32.exe ./times32.exe
	./trebuc32.exe ./verdan32.exe
	./webdin32.exe"
#	./IELPKTH.CAB"
# Need windows license to use Tahoma font
MS_FONT_URLS="${MS_COREFONTS//\.\//mirror://sourceforge/corefonts/}"

GENTOO_FILES="http://dev.gentoo.org/~spyderous/xfree/patchsets/${PV}/XFree86-${PV}-files-${FILES_VER}.tar.bz2"

SRC_URI="${SRC_PATH0}/${MY_SV}.tar.bz2
	mirror://gentoo/eurofonts-X11.tar.bz2
	mirror://gentoo/xfsft-encodings.tar.bz2
	mirror://gentoo/gentoo-cursors-tad-${XCUR_VER}.tar.bz2
	truetype? ( ${MS_FONT_URLS} )
	nls? ( mirror://gentoo/gemini-koi8-u.tar.bz2 )
	${GENTOO_FILES}
	${X_DRIVERS}
	${X_PATCHES}"

# http://www.xfree86.org/4.4.0/LICENSE.html with exception of xfree86-1.1
# and BitstreamVera
LICENSE="Adobe-X CID DEC DEC-2 IBM-X NVIDIA-X NetBSD SGI UCB-LBL XC-2
	bigelow-holmes-urw-gmbh-luxi christopher-g-demetriou national-semiconductor
	nokia tektronix the-open-group todd-c-miller x-truetype xfree86-1.0
	MIT SGI-B BSD FTL | GPL-2 MSttfEULA x-oz"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips"

# sys-apps/portage for USE_EXPAND
DEPEND=">=sys-apps/baselayout-1.8.3
	>=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	>=sys-devel/flex-2.5.4a-r5
	>=dev-libs/expat-1.95.3
	>=media-libs/freetype-${FT2_VER}
	>=media-libs/fontconfig-2.1-r1
	>=x11-base/opengl-update-1.4
	>=x11-misc/ttmkfdir-3.0.4
	>=sys-apps/sed-4
	dev-lang/perl
	media-libs/libpng
	app-arch/unzip
	pam? ( >=sys-libs/pam-0.75 )
	truetype? ( app-arch/cabextract )
	>=sys-apps/portage-2.0.49-r13
	!virtual/x11
	!x11-libs/xft"
# RDEPEND="${DEPEND}"
# unzip - needed for savage driver (version 1.1.27t)
# x11-libs/xft -- blocked because of interference with xfree's

PDEPEND="x86? (
			3dfx? ( >=media-libs/glide-v3-3.10 )
			input_devices_synaptics? ( x11-misc/synaptics )
			input_devices_wacom? ( x11-misc/linuxwacom )
		)"

PROVIDE="virtual/x11
	virtual/opengl
	virtual/glu
	virtual/xft"

#inherit needs to happen *after* DEPEND has been defined to have "newdepend"
#do the right thing. Otherwise RDEPEND doesn't get set properly.
inherit eutils flag-o-matic gcc xfree

DESCRIPTION="XFree86: free X server"

pkg_setup() {
	# Check for existence of $CC, we use it later
	if [ -z "${CC}" ]
	then
		die "Please set the CC variable to your compiler. export CC=gcc."
	fi
}

src_unpack() {

	# Unpack source and patches
	ebegin "Unpacking source"
		unpack ${MY_SV}.tar.bz2 > /dev/null
	eend 0

	ebegin "Unpacking Gentoo files and patches"
		unpack XFree86-${PV}-files-${FILES_VER}.tar.bz2 > /dev/null
		unpack XFree86-${PV}-patches-${PATCH_VER}.tar.bz2 > /dev/null
	eend 0

	# Unpack TaD's gentoo cursors
	ebegin "Unpacking Gentoo cursors"
		unpack gentoo-cursors-tad-${XCUR_VER}.tar.bz2 > /dev/null
	eend 0

	# Unpack extra fonts stuff from Mandrake
	ebegin "Unpacking fonts"
		if use nls
		then
			unpack gemini-koi8-u.tar.bz2 > /dev/null
		fi
		unpack eurofonts-X11.tar.bz2 > /dev/null
		unpack xfsft-encodings.tar.bz2 > /dev/null
	eend 0

	# Remove bum encoding
	rm -f ${WORKDIR}/usr/X11R6/lib/X11/fonts/encodings/urdunaqsh-0.enc

	# Update the Savage Driver
	# savage driver 1.1.27t is a .zip and contains a savage directory
	# (that's why we have to be in drivers, not in savage subdir).
	# Could be USE flag based

	ebegin "Updating Savage driver"
		cd ${S}/programs/Xserver/hw/xfree86/drivers
		unpack savage-${SAVDRV_VER}.zip > /dev/null
		ln -s ${S}/programs/Xserver/hw/xfree86/vbe/vbe.h \
			${S}/programs/Xserver/hw/xfree86/drivers/savage
		cd ${S}
	eend 0

#	ebegin "Updating SiS driver"
#	cd ${S}/programs/Xserver/hw/xfree86/drivers/sis
#	unpack sis_drv_src_${SISDRV_VER}.tar.gz > /dev/null
#	ln -s ${S}/programs/Xserver/hw/xfree86/vbe/vbe.h \
#		${S}/programs/Xserver/hw/xfree86/drivers/sis
#	cd ${S}
#	eend 0

	# This patch is just plain broken. Results in random failures.
	mv -f ${PATCH_DIR}/0120*parallel-make* ${PATCH_DIR}/excluded

	# Hardened patches (both broken)
	mv -f ${PATCH_DIR}/9960_all_4.3.0-exec-shield-GNU* ${PATCH_DIR}/excluded
	mv -f ${PATCH_DIR}/9961_all_4.3.0-libGL-exec-shield* ${PATCH_DIR}/excluded

	# We dont have an implementation for S/390's yet...
	if [ ! "${ARCH}" = "s390" ]
	then
		mv -f ${PATCH_DIR}/7500* ${PATCH_DIR}/excluded
	fi

#	if [ ! "`use gatos`" ]
#	then
		mv -f ${PATCH_DIR}/9841_all_4.3.0-gatos-mesa* ${PATCH_DIR}/excluded
#	fi

	if use debug
	then
		mv -f ${PATCH_DIR}/5901*acecad-debug* ${PATCH_DIR}/excluded
	fi

	# Only apply for hppa/alpha (exclude for others)
	if [ ! "${ARCH}" = "hppa" -o ! "${ARCH}" = "alpha" ]
	then
		mv -f ${PATCH_DIR}/0251*build-zlib-with-fpic* ${PATCH_DIR}/excluded
	fi

	# TDFX_RISKY - 16-bit, 1024x768 or higher on low-memory voodoo3's
	if [ "`use 3dfx`" -a "${TDFX_RISKY}" = "yes" ]
	then
		mv -f ${PATCH_DIR}/5850* ${PATCH_DIR}/excluded
	else
		mv -f ${PATCH_DIR}/5851* ${PATCH_DIR}/excluded
	fi

	# Bulk patching - based on patch name
	# Will create excluded stuff once it's needed
	cd ${WORKDIR}
	EPATCH_SUFFIX="patch" \
	epatch ${PATCH_DIR}
	cd ${S}

	# Update Wacom Driver, hopefully resolving bug #1632
	# The kernel driver should prob also be updated, this can be
	# found at:
	#
	#  http://people.mandrakesoft.com/~flepied/projects/wacom/
	#
	if ( [ -e "/usr/src/linux" ] && \
		[ ! `is_kernel "2" "2"` ] ) || \
		[ "`uname -r | cut -d. -f1,2`" != "2.2" ]
	then
		ebegin "Updating Wacom USB Driver"
		gzip -dc ${DISTDIR}/xf86Wacom.c.gz > \
			${S}/programs/Xserver/hw/xfree86/input/wacom/xf86Wacom.c || die
		eend 0
	fi

	# Unpack the MS fonts
	if use truetype
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
		cd ${S}; cp ${FILES_DIR}/site.def config/cf/host.def || die
		echo "#define XVendorString \"Gentoo Linux (XFree86 ${PV}, revision ${PR})\"" \
			>> config/cf/host.def

		# Xwrapper has been removed so we now need to use the set uid server
		# again, this mustve happened somewhere after 4.3.0 in the development.
		echo "#define InstallXserverSetUID YES" >> config/cf/host.def
		echo "#define BuildServersOnly NO" >> config/cf/host.def

		# Bug #12775 .. fails with -Os.
		replace-flags "-Os" "-O2"

		if [ "`gcc-version`" != "2.95" ]
		then
			# Should fix bug #4189.  gcc 3.x have problems with -march=pentium4
			# and -march=athlon-tbird

			if [ "`gcc-version`" != "3.3" ]
			then
				replace-flags "-march=pentium4" "-march=pentium3"
				replace-flags "-march=athlon-tbird" "-march=athlon"
			fi

			# Without this, modules breaks with gcc3
			if [ "`gcc-version`" = "3.1" ]
			then
				append-flags "-fno-merge-constants"
				append-flags "-fno-merge-constants"
			fi
		fi

		if ( [ -e "/usr/src/linux" ] && \
			[ ! `is_kernel "2" "2"` ] ) || \
			[ "`uname -r | cut -d. -f1,2`" != "2.2" ]
		then
			echo "#define HasLinuxInput YES" >> config/cf/host.def
		fi

		echo "#define CcCmd ${CC}" >> config/cf/host.def
		echo "#define OptimizedCDebugFlags ${CFLAGS}" >> config/cf/host.def
		echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS}" >> config/cf/host.def

		if [ -n "`use debug`" -o -n "`use static`" ]
		then
			echo "#define DoLoadableServer	NO" >>config/cf/host.def
		fi

		if use debug
		then
			echo "#define XFree86Devel	YES" >> config/cf/host.def
		else
			echo "#define ExtraXInputDrivers acecad" >> config/cf/host.def

			# use less ram .. got this from Spider's makeedit.eclass :)
			echo "#define GccWarningOptions -Wno-return-type -w" \
				>> config/cf/host.def
		fi

		if use pam
		then
			# If you want to have optional pam support, do it properly ...
			echo "#define HasPam YES" >> config/cf/host.def
			echo "#define HasPamMisc YES" >> config/cf/host.def
		else
			echo "#define HasPam NO" >> config/cf/host.def
			echo "#define HasPamMisc NO" >> config/cf/host.def
		fi

		if use nls
		then
			echo "#define XtermWithI18N YES" >> config/cf/host.def
		fi

		if [ "${ARCH}" = "x86" ]
		then
			# build with glide3 support? (build the tdfx_dri.o module)
			if use 3dfx
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
				chips tdfx fbdev ati DevelDrivers vga nv imstt \
				XF86OSCardDrivers XF86ExtraCardDrivers" >> config/cf/host.def
		fi

		if [ "${ARCH}" = "sparc" ]
		then
			echo "#define XF86CardDrivers sunffb sunleo suncg6 suncg3 suncg14 \
			suntcx sunbw2 glint mga tdfx ati savage vesa vga fbdev \
			XF86OSCardDrivers XF86ExtraCardDrivers \
			DevelDrivers" >> config/cf/host.def
		fi

		if use xml2
		then
			echo "#define HasLibxml2 YES" >> config/cf/host.def
		fi

		# The definitions for fontconfig
		echo "#define UseFontconfig YES" >> config/cf/host.def
		echo "#define HasFontconfig YES" >> config/cf/host.def

		# Use the xfree Xft2 lib
		echo "#define SharedLibXft YES" >> config/cf/host.def

		# Set up docs building
		if use doc
		then
			local DOC="YES"
		else
			local DOC="NO"
		fi

		# with USE="X doc' circular dep w/ virtual/ghostscript
		# echo "#define HasGhostScript ${DOC}" >> config/cf/host.def
		echo "#define BuildLinuxDocText ${DOC}" >> config/cf/host.def
		echo "#define BuildLinuxDocHtml ${DOC}" >> config/cf/host.def
		echo "#define BuildLinuxDocPS ${DOC}" >> config/cf/host.def
		echo "#define BuildSpecsDocs ${DOC}" >> config/cf/host.def
		echo "#define BuildHtmlManPages ${DOC}" >> config/cf/host.def

		# enable Japanese docs, optionally
		if use cjk
		then
			echo "#define InstallJapaneseDocs ${DOC}" >> config/cf/host.def
		fi

		# Native Language Support Fonts
		if [ -z "`use nls`" ]
		then
			echo "#define BuildCyrillicFonts NO" >> config/cf/host.def
			echo "#define BuildArabicFonts NO" >> config/cf/host.def
			echo "#define BuildGreekFonts NO" >> config/cf/host.def
			echo "#define BuildHebrewFonts NO" >> config/cf/host.def
			echo "#define BuildThaiFonts NO" >> config/cf/host.def

			if [ -z "`use cjk`" ]
			then
				echo "#define BuildCIDFonts NO" >> config/cf/host.def
				echo "#define BuildJapaneseFonts NO" >> config/cf/host.def
				echo "#define BuildKoreanFonts NO" >> config/cf/host.def
				echo "#define BuildChineseFonts NO" >> config/cf/host.def
			fi
		fi

		if use ipv6
		then
			echo "#define BuildIPv6 YES" >> config/cf/host.def
		else
			echo "#define BuildIPv6 NO" >> config/cf/host.def
		fi

		# Will uncomment this after kde, qt, and *box ebuilds are alterered to use
		# it
		#	if use xinerama
		#	then
		#		echo "#define BuildXinerama YES" >> config/cf/host.def
		#		echo "#define BuildXineramaLibrary YES" >> config/cf/host.def
		#	fi

	# End the host.def definitions here
	eend 0

	cd ${S}
	if use doc
	then
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
	fi

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
	FAST=1 emake World WORLDOPTS=""  || die

	if use nls
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

	if use sdk # || use gatos
	then
		einfo "Installing XFree86 SDK..."
		make install.sdk DESTDIR=${D} || die
	fi

	# This one needs to be in /usr/lib
	insinto /usr/lib/pkgconfig
	doins ${D}/usr/X11R6/lib/pkgconfig/{xcursor,xft}.pc
	# Now remove the invalid xft.pc, and co ...
	rm -rf ${D}/usr/X11R6/lib/pkgconfig

	einfo "Installing man pages..."
	make install.man DESTDIR=${D} || die
	einfo "Compressing man pages..."
	prepman /usr/X11R6

	if use nls
	then
		cd ${S}/nls
		make DESTDIR=${D} install || die
	fi

	# Make sure the user running xterm can only write to utmp.
	fowners root:utmp /usr/X11R6/bin/xterm
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
	doins ${FILES_DIR}/XftConfig
	newins ${FILES_DIR}/XftConfig XftConfig.new
	# This is if we are using Fontconfig only ...
	#newins ${S}/lib/Xft1/XftConfig-OBSOLETE XftConfig
	dosym ../../../../etc/X11/XftConfig /usr/X11R6/lib/X11/XftConfig

	# Install example config file
	newins ${S}/programs/Xserver/hw/xfree86/XF86Config XF86Config.example

	# Install MS fonts.
	if use truetype
	then
		ebegin "Installing MS Core Fonts"
			dodir /usr/X11R6/lib/X11/fonts/truetype
			cp -af ${WORKDIR}/truetype/*.ttf ${D}/usr/X11R6/lib/X11/fonts/truetype
		eend 0
	fi

	# EURO support
	ebegin "Euro Support..."
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/X11R6/lib" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-8x14.bdf | \
			gzip -9 > ${D}/usr/X11R6/lib/X11/fonts/misc/Xlat9-8x14-lat9.pcf.gz
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/X11R6/lib" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-9x16.bdf | \
			gzip -9 > ${D}/usr/X11R6/lib/X11/fonts/misc/Xlat9-9x16-lat9.pcf.gz
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/X11R6/lib" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-10x20.bdf | \
			gzip -9 > ${D}/usr/X11R6/lib/X11/fonts/misc/Xlat9-10x20-lat9.pcf.gz
	eend 0

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
	doins ${FILES_DIR}/lib/*.la

	# Use the server as the X binary now as the wrapper is gone.
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

	if use nls
	then
		ebegin "gemini-koi8 fonts..."
			cd ${WORKDIR}/ukr
			gunzip *.Z
			gzip -9 *.pcf
			cd ${S}
			cp -a ${WORKDIR}/ukr ${D}/usr/X11R6/lib/X11/fonts
		eend 0
	fi

	exeinto /etc/X11
	# new session management script
	doexe ${FILES_DIR}/chooser.sh
	# new display manager script
	doexe ${FILES_DIR}/startDM.sh
	exeinto /etc/X11/Sessions
	for x in ${FILES_DIR}/Sessions/*
	do
		[ -f ${x} ] && doexe ${x}
	done
	insinto /etc/env.d
	doins ${FILES_DIR}/10xfree
	insinto /etc/X11/xinit
	doins ${FILES_DIR}/xinitrc
	exeinto /etc/X11/xdm
	doexe ${FILES_DIR}/Xsession ${FILES_DIR}/Xsetup_0
	insinto /etc/X11/fs
	newins ${FILES_DIR}/xfs.config config
	if use pam
	then
		insinto /etc/pam.d
		newins ${FILES_DIR}/xdm.pamd xdm
		# Need to fix console permissions first
		newins ${FILES_DIR}/xserver.pamd xserver
	fi
	exeinto /etc/init.d
	newexe ${FILES_DIR}/xdm.start xdm
	newexe ${FILES_DIR}/xfs.start xfs
	insinto /etc/conf.d
	newins ${FILES_DIR}/xfs.conf.d xfs

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

	# Make the core cursor the default.  People seem not to like whiteglass
	# for some reason.
	dosed 's:whiteglass:core:' /usr/share/cursors/xfree/default/index.theme

	einfo "Stripping binaries and libraries..."
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

	# Install TaD's gentoo cursors
	insinto /usr/share/cursors/xfree/gentoo/cursors
	doins ${WORKDIR}/cursors/gentoo/cursors/*
	insinto /usr/share/cursors/xfree/gentoo-blue/cursors
	doins ${WORKDIR}/cursors/gentoo-blue/cursors/*
	insinto /usr/share/cursors/xfree/gentoo-silver/cursors
	doins ${WORKDIR}/cursors/gentoo-silver/cursors/*

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

		# This one cause ttmkfdir to segfault :/
		#rm -f ${ROOT}/usr/X11R6/lib/X11/fonts/encodings/large/gbk-0.enc.gz
		rm -f ${ROOT}/usr/X11R6/lib/X11/fonts/encodings/iso8859-6.8x.enc.gz
		rm -f ${ROOT}/usr/X11R6/lib/X11/fonts/encodings/iso8859-6.16.enc.gz

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
						LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/lib" \
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

		# danarmak found out that fc-cache should be run AFTER all the above
		# stuff, as otherwise the cache is invalid, and has to be run again
		# as root anyway
		if [ -x ${ROOT}/usr/bin/fc-cache ]
		then
			ebegin "Creating FC font cache..."
				HOME="/root" ${ROOT}/usr/bin/fc-cache -f
			eend 0
		fi

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

	if use 3dfx
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
	einfo "Please note that the xcursors are in /usr/share/cursors/xfree"
	einfo "Any custom cursor sets should be placed in that directory"
	einfo "This is different from the previous versions of 4.3 and"
	einfo "the 4.2.99 series."
	echo
	ewarn "New in this release: if you wish to set system-wide default"
	ewarn "cursors, please set them in /usr/local/share/cursors/xfree"
	ewarn "so that future emerges will not overwrite those settings"
	echo
	einfo "Listening on ipv4 is disabled by default with startx."
	einfo "To enable it or disable ipv6, edit /usr/X11R6/bin/startx."
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
