# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-x11/xorg-x11-6.7.0.ebuild,v 1.16 2004/04/09 20:02:10 lu_zero Exp $

# This is a snapshot of the XORG-RELEASE-1 branch.

# Libraries which are now supplied in shared form that were not in the past
# include:  libFS.so, libGLw.so, libI810XvMC.so, libXRes.so, libXfontcache.so,
# libXinerama.so, libXss.so, libXvMC.so, libXxf86rush.so, libfontenc.so,
# libxkbfile.so, libxkbui.so

# TODO
# 14 March 2004 <spyderous@gentoo.org>
#   TARGET: 1.0
# 		spy: get sparc patch from weeve
# 		spy: delete old fonts dirs if nothing's left in them.
# 		spy: ati-drivers links to /usr/lib/opengl/xfree/{extensions,include}
# 			check nvidia etc too
# 		spy: #43491, #38232
# 		cyfred: #29953
# 		(DONE) spy: #23023
# 		spy: #21120 needs to be ported
# 		tseng: Update hardened patches
# 			-Also see fd.o bug #296, it's been integrated
# 		spy: Check bugs fixed in Gentoo's xfree-4.3.0,4.3.99 lately
# 		spy: External zlib
# 		(DONE) spy: get _all_ necessary licenses added
# 		(DONE) spy: Drop everything related to obsolete XftConfig
# 		(DONE) spy: Check Fedora patches
# 		(DONE) spy: port PAM circular dep fixes over
# 		(DONE) spy: xorg default cursors installed to /usr/share/cursors/xfree
# 		(DONE) spy: Move as much global stuff as possible to pkg_setup()
# 			-- Bumped to 1.0_pre20040313-r1 for this
# 		(DONE) spy: Rename media-fonts/corefonts to microsoft-fonts, provide
# 			virtual/corefonts in combination with ttf-bitstream-vera, the
# 			default
# 			-- Invalidated by addition of bitstream fonts to source
# 		(DONE) spy: add HaveLib64 switch instead of patch 0181
# 		(DONE) spy: switch to use() instead of ${ARCH}
# 		(DONE) tseng, spy: update pie USE
# 		(DONE) spy: drop wacom
# 		(DONE) spy: Drop MS corefonts, dep on virtual
# 		(DONE) spy: Check SDK patches -- wacom, synaptics
# 		(DONE) spy: Install docs to /usr/share/doc
# 		(DONE) spy: Install man pages to /usr/share/man
# 		(DONE) spy: Remove references to libxml. It was never actually used;
# 			expat was instead. It's still sitting there for no reason
# 		(DONE) spy: Install fonts to /usr/share/fonts/*
# 		(DONE) spy: Add external xft, render, xrender drop-ins
# 		(DONE) spy: Generate xrender.pc
# 		(DONE) spy: Transition to new patch_exclude()
#   TARGET: unknown
# 		spy: Add Alan Cox's VIA 2D+3D driver from XFree86-4.3.0-57.src.rpm, use
# 			XFree86-4.3.0-build-libXinerama-before-libGL-for-via-driver.patch
# 		batt: Backport IGP stuff from DRI CVS?

inherit eutils flag-o-matic gcc xfree

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

# IUSE="sse mmx 3dnow" were disabled in favor of autodetection
# IUSE="gatos" disabled because gatos is broken on ~4.4 now (31 Jan 2004)
IUSE="3dfx cjk debug doc hardened ipv6 nls pam sdk static pie"
# IUSE_INPUT_DEVICES="synaptics wacom"

FILES_VER="0.2"
PATCH_VER="0.2"
#RENDER_VER="0.8"
#XRENDER_VER="0.8.4"
#XFT_VER="2.1.5"
XCUR_VER="0.3.1"
#SISDRV_VER="021203-1"
#SAVDRV_VER="1.1.27t"
#MGADRV_VER="1_3_0beta"
#VIADRV_VER="0.1"
XFSFT_ENC_VER="0.1"

S="${WORKDIR}/xc"

HOMEPAGE="http://freedesktop.org/XOrg"

# Misc patches we may need to fetch ..
X_PATCHES="http://dev.gentoo.org/~spyderous/xorg/${PN}/patchsets/${PV}/${P}-patches-${PATCH_VER}.tar.bz2"

X_DRIVERS=""
# X_DRIVERS="${X_DRIVERS} http://www.probo.com/timr/savage-${SAVDRV_VER}.zip
#	http://www.winischhofer.net/sis/sis_drv_src_${SISDRV_VER}.tar.gz
#	mirror://gentoo/${P}-drivers-via-${VIADRV_VER}.tar.bz2"
# Latest Savage drivers:  http://www.probo.com/timr/savage40.html
# Latest SIS drivers:  http://www.winischhofer.net/

# XLIBS="http://freedesktop.org/~xlibs/release/render-${RENDER_VER}.tar.gz
#	http://freedesktop.org/~xlibs/release/libXrender-${XRENDER_VER}.tar.bz2
#	http://freedesktop.org/~xlibs/release/libXft-${XFT_VER}.tar.bz2"

GENTOO_FILES="http://dev.gentoo.org/~spyderous/xorg/${PN}/patchsets/${PV}/${P}-files-${FILES_VER}.tar.bz2"

SRC_URI="mirror://gentoo/eurofonts-X11.tar.bz2
	http://dev.gentoo.org/~spyderous/xorg/${PN}/patchsets/${PV}/xfsft-encodings-${XFSFT_ENC_VER}.tar.bz2
	mirror://gentoo/gentoo-cursors-tad-${XCUR_VER}.tar.bz2
	nls? ( mirror://gentoo/gemini-koi8-u.tar.bz2 )
	${GENTOO_FILES}
	${X_DRIVERS}
	${X_PATCHES}
	http://freedesktop.org/~xorg/X11R${PV}/src/X11R${PV}-src1.tar.gz
	http://freedesktop.org/~xorg/X11R${PV}/src//X11R${PV}-src2.tar.gz
	http://freedesktop.org/~xorg/X11R${PV}/src//X11R${PV}-src3.tar.gz
	http://freedesktop.org/~xorg/X11R${PV}/src//X11R${PV}-src4.tar.gz
	http://freedesktop.org/~xorg/X11R${PV}/src//X11R${PV}-src5.tar.gz
	doc? (
		http://freedesktop.org/~xorg/X11R${PV}/src//X11R${PV}-src6.tar.gz
		http://freedesktop.org/~xorg/X11R${PV}/src//X11R${PV}-src7.tar.gz
	)"
# SRC_URI="${SRC_URI}
# 	${XLIBS}"

# http://www.xfree86.org/4.3.0/LICENSE.html
LICENSE="Adobe-X CID DEC DEC-2 IBM-X NVIDIA-X NetBSD SGI UCB-LBL XC-2
	bigelow-holmes-urw-gmbh-luxi christopher-g-demetriou national-semiconductor
	nokia tektronix the-open-group todd-c-miller x-truetype xfree86-1.0
	MIT SGI-B BSD FTL | GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

# Need portage-2.0.50_pre9 for `use !foo`
DEPEND=">=sys-apps/baselayout-1.8.3
	>=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	>=sys-devel/flex-2.5.4a-r5
	>=dev-libs/expat-1.95.3
	>=media-libs/freetype-2.1.4
	>=media-libs/fontconfig-2.1-r1
	>=x11-base/opengl-update-1.4
	>=x11-misc/ttmkfdir-3.0.4
	>=sys-apps/sed-4
	dev-lang/perl
	media-libs/libpng
	>=sys-apps/portage-2.0.50_pre9
	!virtual/xft
	!virtual/x11"
# x11-libs/xft -- blocked because of interference with xorg's

PDEPEND="x86? (
			3dfx? ( >=media-libs/glide-v3-3.10 )
			input_devices_synaptics? ( x11-misc/synaptics )
			input_devices_wacom? ( x11-misc/linuxwacom )
		)
		alpha? (
			3dfx? ( >=media-libs/glide-v3-3.10 )
		)
		x11-terms/xterm"

PROVIDE="virtual/x11
	virtual/opengl
	virtual/glu
	virtual/xft"

DESCRIPTION="An X11 implementation maintained by the X.Org Foundation"

pkg_setup() {
	# Whether to drop in external render, xrender and xft from freedesktop.org
	# NOTE: The freedesktop versions are the CORRECT upstream versions to use.
	# WARNING: Remember to add the external stuff to SRC_URI when in use.
	EXT_XFT_XRENDER="no"

	# Whether to drop in external drivers
	# NOTE: Remember SRC_URI and DRIVER_VER
	# For savage, remember app-arch/unzip in DEPEND
	EXT_SAVAGE="no"
	EXT_SIS="no"

	FILES_DIR="${WORKDIR}/files"
	PATCHDIR="${WORKDIR}/patch"
	EXCLUDED="${PATCHDIR}/excluded"

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
	#   options that are sensible (and include sse,mmx,3dnow when appropriate).
	#
	# The next command strips CFLAGS and CXXFLAGS from nearly all flags.  If
	# you do not like it, comment it, but do not bugreport if you run into
	# problems.
	#
	# <azarah@gentoo.org> (13 Oct 2002)
	strip-flags

	# Set up CC variable, we use it later
	gcc-getCC

	# See bug #35468, circular pam-X11 dep
	if [ "`use pam`" -a "`best_version x11-base/${PN}`" ]
	then
		einfo "Enabling PAM features in ${PN}..."
	else
		einfo "Disabling PAM features in ${PN}..."
	fi

	if use static
	then
		# A static build disallows building the SDK.
		# See config/xf86.rules.
		if use sdk
		then
			die "The static USE flag is incompatible with gatos and sdk USE flags."
		fi

		# Check for hardened
		if use hardened && has_version ">=sys-devel/gcc-3.3.3-r1"
		then
			append-flags -yet_exec
		elif has_version "sys-devel/hardened-gcc"
		then
			append-flags -yet_exec
		fi
	fi
}

src_unpack() {

	# Unpack source and patches
	ebegin "Unpacking source"
		unpack X11R${PV}-src1.tar.gz
		unpack X11R${PV}-src2.tar.gz
		unpack X11R${PV}-src3.tar.gz
		unpack X11R${PV}-src4.tar.gz
		unpack X11R${PV}-src5.tar.gz
	eend 0

	if use doc
	then
		ebegin "Unpacking documentation"
			unpack X11R${PV}-src6.tar.gz
			unpack X11R${PV}-src7.tar.gz
		eend 0
fi

	ebegin "Unpacking Gentoo files and patches"
		unpack ${P}-files-${FILES_VER}.tar.bz2 > /dev/null
		unpack ${P}-patches-${PATCH_VER}.tar.bz2 > /dev/null
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
		unpack xfsft-encodings-${XFSFT_ENC_VER}.tar.bz2 > /dev/null
	eend 0

	# Remove bum encoding
	rm -f ${WORKDIR}/usr/share/fonts/encodings/urdunaqsh-0.enc

	# Update the Savage Driver
	# savage driver 1.1.27t is a .zip and contains a savage directory
	# (that's why we have to be in drivers, not in savage subdir).
	# Could be USE flag based

	if [ "${EXT_SAVAGE}" = "yes" ]
	then
		ebegin "Updating Savage driver"
			cd ${S}/programs/Xserver/hw/xfree86/drivers
			unpack savage-${SAVDRV_VER}.zip > /dev/null
			ln -s ${S}/programs/Xserver/hw/xfree86/vbe/vbe.h \
				${S}/programs/Xserver/hw/xfree86/drivers/savage
			cd ${S}
		eend 0
	fi

	if [ "${EXT_SIS}" = "yes" ]
	then
		ebegin "Updating SiS driver"
			cd ${S}/programs/Xserver/hw/xfree86/drivers/sis
			unpack sis_drv_src_${SISDRV_VER}.tar.gz > /dev/null
			ln -s ${S}/programs/Xserver/hw/xfree86/vbe/vbe.h \
			${S}/programs/Xserver/hw/xfree86/drivers/sis
			cd ${S}
		eend 0
	fi

	if [ "${EXT_XFT_XRENDER}" = "yes" ]
	then
		ebegin "Adding external Render"
			cd ${S}/lib
			unpack render-${RENDER_VER}.tar.gz > /dev/null
			mv render-${RENDER_VER}/render*.h ../include/extensions/
			mkdir -p ../doc/hardcopy/render
			cp render-${RENDER_VER}/{protocol,library} ../doc/hardcopy/render
		eend 0

		ebegin "Adding external Xrender"
			mv Xrender Xrender.old
			unpack libXrender-${XRENDER_VER}.tar.bz2 > /dev/null
			mv libXrender-${XRENDER_VER} Xrender
			cp Xrender.old/Imakefile Xrender/Imakefile
			rm -f Xrender/Makefile*
			touch Xrender/config.h
		eend 0

		ebegin "Adding external Xft"
			mv Xft Xft.old
			unpack libXft-${XFT_VER}.tar.bz2 > /dev/null
			mv libXft-${XFT_VER} Xft
			cp Xft.old/Imakefile Xft/Imakefile
			cp Xft.old/Xft.man Xft/Xft.man
			ln -sf ../Xft.old/config Xft/config
			rm -f Xft/Makefile*
			touch Xft/config.h
		eend 0
		cd ${S}
	fi

	einfo "Excluding patches..."
		# These have been applied upstream
		if [ ! "${EXT_SAVAGE}" = "yes" ]
		then
			patch_exclude 1770 1771 1772 1773
		fi

		# This patch is just plain broken. Results in random failures.
		patch_exclude 0120*parallel-make

		# Hardened patches (both broken)
		patch_exclude 9960_all_4.3.0-exec-shield-GNU
		patch_exclude 9961_all_4.3.0-libGL-exec-shield

		# We dont have an implementation for S/390's yet...
		if use !s390
		then
			patch_exclude 7500
		fi

		if [ "${EXT_XFT_XRENDER}" = "yes" ]
		then
			patch_exclude 1075
		fi

	#	if use !gatos
	#	then
			patch_exclude 9841_all_4.3.0-gatos-mesa
	#	fi

		if use debug
		then
			patch_exclude 5901*acecad-debug
		fi

		# TDFX_RISKY - 16-bit, 1024x768 or higher on low-memory voodoo3's
		if [ "`use 3dfx`" -a "${TDFX_RISKY}" = "yes" ]
		then
			patch_exclude 5850
		else
			patch_exclude 5851
		fi
	einfo "Done excluding patches"

	# Bulk patching - based on patch name
	# Will create excluded stuff once it's needed
	cd ${WORKDIR}
	EPATCH_SUFFIX="patch" \
	epatch ${PATCHDIR}
	cd ${S}

	ebegin "Setting up config/cf/host.def"
		cd ${S}; cp ${FILES_DIR}/site.def config/cf/host.def || die
		echo "#define XVendorString \"Gentoo Linux (The X.Org Foundation ${PV}, revision ${PR}-${PATCH_VER})\"" \
			>> config/cf/host.def

		# Makes ld bail at link time on undefined symbols
		# Suggested by Mike Harris <mharris@redhat.com>
		echo "#define SharedLibraryLoadFlags  -shared -Wl,-z,defs" \
			>> config/cf/host.def

		# FHS install locations for docs
		echo "#define ManDirectoryRoot /usr/share/man" >> config/cf/host.def
		echo "#define DocDir /usr/share/doc/${PF}" >> config/cf/host.def

		# Make man4 and man7 stuff get 'x' suffix like everything else
		# Necessary so we can install to /usr/share/man without overwriting
		echo "#define DriverManDir \$(MANSOURCEPATH)4" >> config/cf/host.def
		echo "#define DriverManSuffix 4x /* use just one tab or cpp will die */" \
			>> config/cf/host.def
		echo "#define MiscManDir \$(MANSOURCEPATH)7" >> config/cf/host.def
		echo "#define MiscManSuffix 7x /* use just one tab or cpp will die */" \
			>> config/cf/host.def

		# Xwrapper has been removed so we now need to use the set uid server
		# again, this mustve happened somewhere after 4.3.0 in the development.
		echo "#define InstallXserverSetUID YES" >> config/cf/host.def
		echo "#define BuildServersOnly NO" >> config/cf/host.def

		# Don't use /lib64 ..
		# Replaces 0181_all_4.3.0-amd64-nolib64.patch
		echo "#define HaveLib64 NO" >> config/cf/host.def

		# Set location of DRM source to be installed
		echo "#define InstSrcDir /usr/src/${PF}" >> config/cf/host.def

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
		echo "#define OptimizedCDebugFlags ${CFLAGS} GccAliasingArgs" >> config/cf/host.def
		echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS} GccAliasingArgs" >> config/cf/host.def

		if use static
		then
			echo "#define DoLoadableServer	NO" >>config/cf/host.def
		else
			if use pie ; then
				einfo "Setting DoLoadableServer/MakeDllModules to YES for etdyn building"
				echo "#define DoLoadableServer  YES" >> config/cf/host.def
				echo "#define MakeDllModules    YES" >> config/cf/host.def
			fi
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

		# Remove circular dep between pam and X11, bug #35468
		# If pam is in USE and we have X11, then we can enable PAM
		if [ "`use pam`" -a "`best_version x11-base/xorg-x11`" ]
		then
			# If you want to have optional pam support, do it properly ...
			echo "#define HasPam YES" >> config/cf/host.def
			echo "#define HasPamMisc YES" >> config/cf/host.def
		else
			echo "#define HasPam NO" >> config/cf/host.def
			echo "#define HasPamMisc NO" >> config/cf/host.def
		fi

		if use x86 || use alpha
		then
			# build with glide3 support? (build the tdfx_dri.o module)
			if use 3dfx
			then
				echo "#define HasGlide3 YES" >> config/cf/host.def
			fi
		fi

		if use hppa
		then
			echo "#define DoLoadableServer NO" >> config/cf/host.def
		fi

		if use alpha
		then
			echo "#define XF86CardDrivers mga nv tga s3virge sis rendition \
				i740 tdfx cirrus tseng fbdev \
				ati vga v4l glint" >> config/cf/host.def
		fi

		if use ppc
		then
			echo "#define XF86CardDrivers mga glint s3virge sis savage trident \
				chips tdfx fbdev ati DevelDrivers vga nv imstt \
				XF86OSCardDrivers XF86ExtraCardDrivers" >> config/cf/host.def
		fi

		if use sparc
		then
			echo "#define XF86CardDrivers sunffb sunleo suncg6 suncg3 suncg14 \
			suntcx sunbw2 glint mga tdfx ati savage vesa vga fbdev \
			XF86OSCardDrivers XF86ExtraCardDrivers \
			DevelDrivers" >> config/cf/host.def
		fi

		# The definitions for fontconfig
		echo "#define UseFontconfig YES" >> config/cf/host.def
		echo "#define HasFontconfig YES" >> config/cf/host.def

		# Use the xorg Xft2 lib
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
		# Caused issues, basic docs aren't installed
		#echo "#define BuildLinuxDocText ${DOC}" >> config/cf/host.def
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
		if use !nls
		then
			echo "#define BuildCyrillicFonts NO" >> config/cf/host.def
			echo "#define BuildArabicFonts NO" >> config/cf/host.def
			echo "#define BuildGreekFonts NO" >> config/cf/host.def
			echo "#define BuildHebrewFonts NO" >> config/cf/host.def
			echo "#define BuildThaiFonts NO" >> config/cf/host.def

			if use !cjk
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
			# In case Gentoo ever works on a system with IPv6 sockets that don't
			# also listen on IPv4 (see config/cf/X11.tmpl)
			echo "#define PreferXdmcpIPv6 YES" >> config/cf/host.def
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
	# MAKEOPTS, they'll redefine an internal xorg Makefile variable and the
	# xorg build will silently die. This is tricky to track down, so I'm
	# adding a preemptive fix for this issue by making sure that MAKE_OPTS is
	# unset. (drobbins, 08 Mar 2003)
	unset MAKE_OPTS

	einfo "Building xorg-x11..."
	FAST=1 emake World WORLDOPTS="" FONTDIR="/usr/share/fonts" || die

	if use nls
	then
		cd ${S}/nls
		make || die
		cd ${S}
	fi

}

src_install() {

	unset MAKE_OPTS

	einfo "Installing X.org X11..."
	# gcc3 related fix.  Do this during install, so that our
	# whole build will not be compiled without mmx instructions.
	if [ "`gcc-version`" != "2.95" ] && use x86
	then
		make install DESTDIR=${D} FONTDIR="/usr/share/fonts" || \
		make CDEBUGFLAGS="${CDEBUGFLAGS} -mno-mmx" \
			CXXDEBUGFLAGS="${CXXDEBUGFLAGS} -mno-mmx" \
			install DESTDIR=${D} FONTDIR="/usr/share/fonts" || die
	else
		make install DESTDIR=${D} FONTDIR="/usr/share/fonts" || die
	fi

	if use sdk # || use gatos
	then
		einfo "Installing X.org X11 SDK..."
		make install.sdk DESTDIR=${D} || die
	fi

	if [ "${EXT_XFT_XRENDER}" = "yes" ]
	then
		cd ${D}/usr/X11R6/lib
		mv libXft.so.2.1 libXft.so.2.1.1
		ln -snf libXft.so.2.1.1 libXft.so.2
		mv libXrender.so.1.2 libXrender.so.1.2.2
		ln -snf libXrender.so.1.2.2 libXrender.so.1
		cd ${S}

		# Generate xrender.pc using 'EOF' style here document with no expansion
		# (adapted from Red Hat)
		cat <<-'EOF' > ${D}/usr/X11R6/lib/pkgconfig/xrender.pc
		prefix=/usr/X11R6
		exec_prefix=${prefix}
		libdir=${exec_prefix}/lib
		includedir=${prefix}/include

		Name: Xrender
		Description: X Render Library
		Version: 0.8.3
		Cflags: -I${includedir} -I/usr/X11R6/include
		Libs: -L${libdir} -lXrender  -L/usr/X11R6/lib -lX11
		EOF

		fperms 0644 /usr/X11R6/lib/pkgconfig/xrender.pc

		# Fix problem in xft.pc with version not being defined
		sed -i "s:@VERSION@:${XFT_VER}:g" ${D}/usr/X11R6/lib/pkgconfig/xft.pc
	fi

	# This one needs to be in /usr/lib
	insinto /usr/lib/pkgconfig
	doins ${D}/usr/X11R6/lib/pkgconfig/{xcursor,xft}.pc
	if [ "${EXT_XFT_XRENDER}" = "yes" ]
	then
		doins ${D}/usr/X11R6/lib/pkgconfig/xrender.pc
	fi
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

	# Backwards compatibility so X server will still start
	# after installing fonts to /usr/share/fonts
	# if xorg.conf is not edited
	# This provides the 'fixed' font
	dodir /usr/X11R6/lib/X11/fonts/
	dosym ${ROOT}/usr/share/fonts/misc /usr/X11R6/lib/X11/fonts/misc

	# Fix default config files after installing fonts to /usr/share/fonts
	sed -i "s:/usr/X116/lib/X11/fonts:/usr/share/fonts:g" \
		${D}/etc/X11/xorg.conf.example
	sed -i "s:/usr/X116/lib/X11/fonts:/usr/share/fonts:g" \
		${D}/etc/X11/fs/config

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

	# Install example config file
	newins ${S}/programs/Xserver/hw/xfree86/xorg.conf xorg.conf.example

	# EURO support
	ebegin "Euro Support..."
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/X11R6/lib" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-8x14.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-8x14-lat9.pcf.gz
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/X11R6/lib" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-9x16.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-9x16-lat9.pcf.gz
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/X11R6/lib" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-10x20.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-10x20-lat9.pcf.gz
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

	# Backwards compat, FHS, etc.
	dosym ../../usr/X11R6/bin/Xorg /etc/X11/X

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
		dodir /usr/share/fonts/encodings
		cp -a ${WORKDIR}/usr/share/fonts/encodings/* \
			${D}/usr/share/fonts/encodings

		for x in ${D}/usr/share/fonts/encodings/{.,large}/*.enc
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
			cp -a ${WORKDIR}/ukr ${D}/usr/share/fonts
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
	doins ${FILES_DIR}/10xorg
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
		dodir /usr/lib/opengl/${PN}/{lib,extensions,include}
		local x=""
		for x in ${D}/usr/X11R6/lib/libGL.so* \
			${D}/usr/X11R6/lib/libGL.la \
			${D}/usr/X11R6/lib/libGL.a \
			${D}/usr/X11R6/lib/libMesaGL.so
		do
			if [ -f ${x} -o -L ${x} ]
			then
				# libGL.a cause problems with tuxracer, etc
				mv -f ${x} ${D}/usr/lib/opengl/${PN}/lib
			fi
		done
		for x in ${D}/usr/X11R6/lib/modules/extensions/libglx*
		do
			if [ -f ${x} -o -L ${x} ]
			then
				mv -f ${x} ${D}/usr/lib/opengl/${PN}/extensions
			fi
		done
		for x in ${D}/usr/X11R6/include/GL/{gl.h,glx.h,glxtokens.h}
		do
			if [ -f ${x} -o -L ${x} ]
			then
				mv -f ${x} ${D}/usr/lib/opengl/${PN}/include
			fi
		done
	eend 0

	# Make the core cursor the default.  People seem not to like whiteglass
	# for some reason.
	dosed 's:whiteglass:core:' /usr/share/cursors/${PN}/default/index.theme

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
	for x in ${D}/usr/{lib,lib/opengl/${PN}/lib}/*.so.* \
		${D}/usr/X11R6/{lib,lib/X11/locale/lib/common}/*.so.*
	do
		if [ -f ${x} ]
		then
			echo "`echo ${x} | sed -e "s|${D}||"`"
			strip --strip-debug ${x} || :
		fi
	done

	# Install TaD's gentoo cursors
	insinto /usr/share/cursors/${PN}/gentoo/cursors
	doins ${WORKDIR}/cursors/gentoo/cursors/*
	insinto /usr/share/cursors/${PN}/gentoo-blue/cursors
	doins ${WORKDIR}/cursors/gentoo-blue/cursors/*
	insinto /usr/share/cursors/${PN}/gentoo-silver/cursors
	doins ${WORKDIR}/cursors/gentoo-silver/cursors/*

}

pkg_preinst() {

	# More stuff for emergency symlink
	if [ -d ${ROOT}/usr/X11R6/lib/X11/fonts/misc ]
	then
		rm -rf ${ROOT}/usr/X11R6/lib/X11/fonts/misc
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

	# clean the dynamic libGL stuff's home to ensure
	# we don't have stale libs floating around
	if [ -d ${ROOT}/usr/lib/opengl/${PN} ]
	then
		rm -rf ${ROOT}/usr/lib/opengl/${PN}/*
	fi

	# clean out old fonts.* and encodings.dir files, as we
	# will regenerate them
	find ${ROOT}/usr/share/fonts/ -type f -name 'fonts.*' \
		-exec rm -f {} \;
	find ${ROOT}/usr/share/fonts/ -type f -name 'encodings.dir' \
		-exec rm -f {} \;

	# make sure we do not have any stale files lying around
	# that could break things.
	rm -f ${ROOT}/usr/X11R6/lib/libGL*
}

pkg_postinst() {

	env-update

	if [ "${ROOT}" = "/" ]
	then
		local x=""

		umask 022

		# These cause ttmkfdir to segfault :/
		rm -f ${ROOT}/usr/share/fonts/encodings/iso8859-6.8x.enc.gz
		rm -f ${ROOT}/usr/share/fonts/encodings/iso8859-6.16.enc.gz

		# ********************************************************************
		#  A note about fonts and needed files:
		#
		#  1)  Create /usr/share/fonts/encodings/encodings.dir
		#
		#  2)  Create fonts.scale for TrueType fonts (need to do this before
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
			# Create the encodings.dir in /usr/share/fonts/encodings
			LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/lib" \
			${ROOT}/usr/X11R6/bin/mkfontdir -n \
				-e ${ROOT}/usr/share/fonts/encodings \
				-e ${ROOT}/usr/share/fonts/encodings/large \
				-- ${ROOT}/usr/share/fonts/encodings
		eend 0

		if [ -x ${ROOT}/usr/X11R6/bin/ttmkfdir ]
		then
			ebegin "Creating fonts.scale files..."
				for x in $(find ${ROOT}/usr/share/fonts/* -type d -maxdepth 1)
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
							-e ${ROOT}/usr/share/fonts/encodings/encodings.dir \
							-o ${x}/fonts.scale -d ${x}
					fi
				done
			eend 0
		fi

		ebegin "Generating fonts.dir files..."
			for x in $(find ${ROOT}/usr/share/fonts/* -type d -maxdepth 1)
			do
				[ -z "$(ls ${x}/)" ] && continue
				[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

				if [ "${x/encodings}" = "${x}" ]
				then
					LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/lib" \
					${ROOT}/usr/X11R6/bin/mkfontdir \
						-e ${ROOT}/usr/share/fonts/encodings \
						-e ${ROOT}/usr/share/fonts/encodings/large \
						-- ${x}
				fi
			done
		eend 0

		ebegin "Generating Xft cache..."
			for x in $(find ${ROOT}/usr/share/fonts/* -type d -maxdepth 1)
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
			find ${ROOT}/usr/share/fonts/ -type f -name 'font.*' \
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

		# Switch to the xorg implementation.
		# Use new opengl-update that will not reset user selected
		# OpenGL interface ...
		echo; ${ROOT}/usr/sbin/opengl-update --use-old ${PN}
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
	einfo "Please note that the xcursors are in /usr/share/cursors/${PN}"
	einfo "Any custom cursor sets should be placed in that directory"
	echo
	einfo "If you wish to set system-wide default cursors, please set"
	einfo "them in /usr/local/share/cursors/${PN} so that future"
	einfo "emerges will not overwrite those settings"
	echo
	einfo "Listening on TCP is disabled by default with startx."
	einfo "To enable it, edit /usr/X11R6/bin/startx."
	echo

	echo
	ewarn "BEWARE:"
	ewarn "Font installation location has MOVED to:"
	ewarn "/usr/share/fonts"
	ewarn "Edit /etc/X11/xorg.conf, /etc/fonts/fonts.conf,"
	ewarn "/etc/fonts/local.conf and /etc/X11/fs/config"
	ewarn "to reflect this change."
	einfo "One compatibility symlink to the misc fonts,"
	einfo "including the 'fixed' font, has been provided"
	einfo "so an emergency X server will start."
	echo
	ewarn "The configuration file has changed from that in XFree86."
	ewarn "It is xorg.conf instead of XF86Config."
	einfo "You may use xorgcfg, X -configure, or xorgconfig"
	einfo "to create xorg.conf."
	einfo "If XF86Config exists and xorg.conf does not, it will still"
	einfo "read XF86Config."

	# Try to get people to read /usr/share/fonts move
	for TICKER in 1 2 3 4 5
	do
		# Double beep here.
		echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
		echo -ne "\a" ; sleep 1
	done
	sleep 10
}

pkg_postrm() {

	# Fix problematic links
	if [ -x ${ROOT}/usr/X11R6/bin/Xorg ]
	then
		ln -snf ../X11R6/bin ${ROOT}/usr/bin/X11
		ln -snf ../X11R6/include/X11 ${ROOT}/usr/include/X11
		ln -snf ../X11R6/include/DPS ${ROOT}/usr/include/DPS
		ln -snf ../X11R6/include/GL ${ROOT}/usr/include/GL
		ln -snf ../X11R6/lib/X11 ${ROOT}/usr/lib/X11
	fi
}
