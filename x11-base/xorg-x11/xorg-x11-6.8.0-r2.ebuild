# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-x11/xorg-x11-6.8.0-r2.ebuild,v 1.52 2004/11/04 04:25:49 spyderous Exp $

# Set TDFX_RISKY to "yes" to get 16-bit, 1024x768 or higher on low-memory
# voodoo3 cards.

# Libraries which are now supplied in shared form that were not in the past
# include:  libFS.so, libGLw.so, libI810XvMC.so, libXRes.so, libXfontcache.so,
# libXinerama.so, libXss.so, libXvMC.so, libXxf86rush.so, libfontenc.so,
# libxkbfile.so, libxkbui.so

# TODO
# 18 October 2004 <spyderous@gentoo.org>
#   TARGET: 6.8.0-r2
#		Add some logic so /usr/X11R6/lib can actually be a symlink
#			- Move everything inside to /usr/lib while retaining its MD5 so
#				it will still be uninstalled when portage follows the symlink.
#				Note: A simple $(mv) does this. Do in pkg_preinst().
#		Combine find loops for "Creating fonts.scale files," "Generating
#			fonts.dir files and "Generating Xft cache"
#		Mr_Bones_ the loop in pkg_postinst for removing Compose can probably
#			be one line of bash expansion like rm -f ${ROOT}/usr/$(get_libdir)/
#			X11/locale/{ja*|ko*|zh*}/Compose
#   TARGET: 6.8.0-r3
#		Same for /usr/X11R6/include
#   TARGET: 6.8.0-r4
#		Same for /usr/X11R6/bin

inherit eutils flag-o-matic toolchain-funcs x11

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

# IUSE="gatos" disabled because gatos is broken on ~4.4 now (31 Jan 2004)
IUSE="3dfx 3dnow bitmap-fonts cjk debug dlloader dmx doc font-server hardened
	insecure-drivers ipv6 mmx nls opengl pam sdk sse static truetype-fonts
	type1-fonts uclibc xprint xv"
# IUSE_INPUT_DEVICES="synaptics wacom"

FILES_VER="0.6"
PATCH_VER="0.2.6"
XCUR_VER="0.3.1"
#MGADRV_VER="1_3_0beta"
#VIADRV_VER="0.1"
XFSFT_ENC_VER="0.1"

S=${WORKDIR}/xc

HOMEPAGE="http://freedesktop.org/XOrg"

# Misc patches we may need to fetch ..
X_PATCHES="http://dev.gentoo.org/~spyderous/${PN}/patchsets/${PV}/${P}-patches-${PATCH_VER}.tar.bz2
	http://dev.gentoo.org/~cyfred/distfiles/${P}-patches-${PATCH_VER}.tar.bz2
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"

X_DRIVERS=""
#	mirror://gentoo/${P}-drivers-via-${VIADRV_VER}.tar.bz2"
# Latest Savage drivers:  http://www.probo.com/timr/savage40.html
# Latest SIS drivers:  http://www.winischhofer.net/

GENTOO_FILES="http://dev.gentoo.org/~spyderous/${PN}/patchsets/${PV}/${P}-files-${FILES_VER}.tar.bz2
	http://dev.gentoo.org/~cyfred/distfiles/${P}-files-${FILES_VER}.tar.bz2
	mirror://gentoo/${P}-files-${FILES_VER}.tar.bz2"

SRC_URI="mirror://gentoo/eurofonts-X11.tar.bz2
	font-server? ( http://dev.gentoo.org/~cyfred/xorg/${PN}/patchsets/${PV}/xfsft-encodings-${XFSFT_ENC_VER}.tar.bz2 )
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

LICENSE="Adobe-X CID DEC DEC-2 IBM-X NVIDIA-X NetBSD SGI UCB-LBL XC-2
	bigelow-holmes-urw-gmbh-luxi christopher-g-demetriou national-semiconductor
	nokia tektronix the-open-group todd-c-miller x-truetype xfree86-1.0
	MIT SGI-B BSD || ( FTL GPL-2 )"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	>=sys-devel/flex-2.5.4a-r5
	>=dev-libs/expat-1.95.3
	>=media-libs/freetype-2.1.4
	>=media-libs/fontconfig-2.1-r1
	opengl? ( >=x11-base/opengl-update-1.99 )
	>=x11-misc/ttmkfdir-3.0.9-r2
	>=sys-apps/sed-4
	sys-apps/util-linux
	dev-lang/perl
	media-libs/libpng
	!x11-base/xfree
	!virtual/xft
	!virtual/x11"
# x11-libs/xft -- blocked because of interference with xorg's

# app-text/dgs overlaps libdps.{a,so} libdpstk.{a,so} libpsres.{a,so}
# need to test X's libs w/ imagemagick, graphicsmagick and gtkDPS
RDEPEND="
		!app-text/dgs
		>=sys-libs/zlib-1.1.3-r2
		>=sys-devel/flex-2.5.4a-r5
		>=dev-libs/expat-1.95.3
		>=media-libs/freetype-2.1.4
		>=media-libs/fontconfig-2.1-r1
		opengl? ( >=x11-base/opengl-update-1.99 )
		media-libs/libpng
		>=sys-libs/ncurses-5.1
		!x11-base/xfree
		!virtual/xft
		!virtual/x11"

PDEPEND="x86? (
			3dfx? ( >=media-libs/glide-v3-3.10 )
			input_devices_synaptics? ( x11-misc/synaptics )
			input_devices_wacom? ( x11-misc/linuxwacom )
		)
		alpha? (
			3dfx? ( >=media-libs/glide-v3-3.10 )
		)
		!uclibc? ( x11-terms/xterm )"

PROVIDE="virtual/x11
	virtual/opengl
	virtual/glu
	virtual/xft"

DESCRIPTION="An X11 implementation maintained by the X.Org Foundation"

HOSTCONF="config/cf/host.def"

cflag_setup() {
	# Set up CFLAGS
	filter-flags "-funroll-loops"

	ALLOWED_FLAGS="-fstack-protector -march -mcpu -mtune -O -O0 -O1 -O2 -O3 -Os"
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -pipe -fomit-frame-pointer"
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -g -g0 -g1 -g2 -g3"
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -ggdb -ggdb0 -ggdb1 -ggdb2 -ggdb3"
	# arch-specific section added by popular demand
	case "${ARCH}" in
		mips)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -mips1 -mips2 -mips3 -mips4 -mabi"
			;;
		# -fomit-frame-pointer known to break things and is pointless
		# according to ciaranm
		# And hardened compiler must be softened. -- fmccor, 20.viii.04
		sparc)	filter-flags "-fomit-frame-pointer"
			if use hardened; then
				einfo "Softening gcc for sparc"
				ALLOWED_FLAGS="${ALLOWED_FLAGS} -fno-pie -fno-PIE"
				append-flags "-fno-pie -fno-PIE"
			fi
			;;
		# gcc-3.3.2 causes invalid insn error
		hppa ) replace-cpu-flags 2.0 1.0
			;;
	esac

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
}

pkg_setup() {
	#################################################
	### GET RID OF THIS ONCE THIS EBUILD IS READY ###
	#################################################
	if [ -z "${BREAKME}" ]; then
		die "Set the BREAKME variable to emerge this. It's in development. Stop using it."
	fi

	FILES_DIR="${WORKDIR}/files"
	PATCHDIR="${WORKDIR}/patch"
	EXCLUDED="${PATCHDIR}/excluded"

	# Set up CFLAG-related things
	cflag_setup

	# See bug #35468, circular pam-X11 dep
	if use pam && best_version x11-base/${PN}; then
		einfo "Previous ${PN} installation detected"
		einfo "Enabling PAM features in ${PN}..."
	else
		einfo "Previous ${PN} installation NOT detected"
		einfo "Disabling PAM features in ${PN}..."
		einfo "You must remerge ${PN} to enable pam."
		einfo "See http://bugs.gentoo.org/show_bug.cgi?id=35468."
	fi

	if use static || use dlloader; then
		# A static build disallows building the SDK.
		# See config/xf86.rules.
		# So does a DllModules YES (use dlloader) build (#50562)
		# The latter is pending a potential patch.
		if use sdk; then
			die "The static and dlloader USE flags are currently incompatible with the sdk USE flag."
		fi
	fi

	if use dmx && use doc; then
		die "The dmx and doc USE flags are temporarily incompatible and result in a dead build."
	fi

	if use xv && ! use opengl; then
		eerror "See http://bugs.gentoo.org/show_bug.cgi?id=67996"
		eerror "The xv USE flag currently requires the opengl flag."
		die "This is a known bug. Do not report it."
	fi

	# on amd64 we need /usr/lib64/X11/locale/lib to be a symlink
	# created by the emul lib ebuild in order for adobe acrobat, staroffice,
	# and a few other apps to work.
	use amd64 && get_libdir_override lib64
	# lib32 isnt a supported configuration (yet?)
	[ "${CONF_LIBDIR}" == "lib32" ] && get_libdir_override lib


	# Echo a message to the user about bitmap-fonts
	if ! use bitmap-fonts; then
		ewarn "Please emerge this with USE=\"bitmap-fonts\" to enable"
		ewarn "75dpi and 100dpi fonts.  Your GTK+-1.2 fonts may look"
		ewarn "screwy otherwise"

		ebeep 5
		epause 10
	fi
}

host_def_setup() {
	HOSTCONF=config/cf/host.def

	ebegin "Setting up ${HOSTCONF}"
		cd ${S}; cp ${FILES_DIR}/site.def ${HOSTCONF} \
			|| die "host.def copy failed"
		echo "#define XVendorString \"Gentoo Linux (The X.Org Foundation ${PV}, revision ${PR}-${PATCH_VER})\"" \
			>> ${HOSTCONF}

		# Pending http://bugs.gentoo.org/show_bug.cgi?id=49038 and
		# http://freedesktop.org/cgi-bin/bugzilla/show_bug.cgi?id=600
		#
		# Makes ld bail at link time on undefined symbols
		# Suggested by Mike Harris <mharris@redhat.com>
		#echo "#define SharedLibraryLoadFlags  -shared -Wl,-z,defs" \
		#	>> ${HOSTCONF}

		# Enable i810 on x86_64 (RH #126687)
		echo "#define XF86ExtraCardDrivers i810" >> ${HOSTCONF}

		# FHS install locations
		echo "#define ManDirectoryRoot /usr/share/man" >> ${HOSTCONF}
		echo "#define DocDir /usr/share/doc/${PF}" >> ${HOSTCONF}
		echo "#define FontDir /usr/share/fonts" >> ${HOSTCONF}
		# Saving this for a later revision
		# echo "#define BinDir /usr/bin" >> ${HOSTCONF}
		# /usr/X11R6/lib with exception of /usr/X11R6/lib/X11
		echo "#define LibDir /usr/$(get_libdir)" >> ${HOSTCONF}
		# /usr/X11R6/lib/X11
		echo "#define UsrLibDir /usr/$(get_libdir)" >> ${HOSTCONF}

		# Make man4 and man7 stuff get 'x' suffix like everything else
		# Necessary so we can install to /usr/share/man without overwriting
		echo "#define DriverManDir \$(MANSOURCEPATH)4" >> ${HOSTCONF}
		echo "#define DriverManSuffix 4x /* use just one tab or cpp will die */" \
			>> ${HOSTCONF}
		echo "#define MiscManDir \$(MANSOURCEPATH)7" >> ${HOSTCONF}
		echo "#define MiscManSuffix 7x /* use just one tab or cpp will die */" \
			>> ${HOSTCONF}

		# Don't build xterm -- use external (#54051)
		echo "#define BuildXterm NO" >> ${HOSTCONF}

		# Xwrapper has been removed so we now need to use the set uid server
		# again, this mustve happened somewhere after 4.3.0 in the development.
		echo "#define InstallXserverSetUID YES" >> ${HOSTCONF}
		echo "#define BuildServersOnly NO" >> ${HOSTCONF}

		# Don't use /lib64 if $(get_libdir) != lib64
		# Replaces 0181_all_4.3.0-amd64-nolib64.patch
		if [ "$(get_libdir)" == "lib64" ]; then
			echo "#define HaveLib64 YES" >> ${HOSTCONF}
		else
			echo "#define HaveLib64 NO" >> ${HOSTCONF}
		fi

		# Set location of DRM source to be installed
		echo "#define InstSrcDir ${ROOT}/usr/src/${PF}" >> ${HOSTCONF}

		if [ "$(gcc-major-version)" -eq "3" ]; then
			if use x86; then
				# Should fix bug #4189.  gcc 3.x have problems with
				# -march=pentium4 and -march=athlon-tbird
				# Seems fixed on 3.3 and higher
				if [ "$(gcc-minor-version)" -le "2" ]; then
					replace-cpu-flags pentium4 pentium3
					replace-cpu-flags athlon athlon-tbird
				fi

				#to fix #56702 for now, thanks Spanky
				if [ "$(gcc-minor-version)" -eq "4" ]; then
					if test_flag -mno-sse2; then
						append-flags -mno-sse2
					fi
				fi

				# Try a fix for #49310, see #50931 for more info. <spyderous>
				if [ "$(is-flag -fomit-frame-pointer)" ]; then
					replace-cpu-flags k6 k6-2 k6-3 i586
				fi
			fi

			# Without this, modules breaks with gcc3
			if [ "$(gcc-minor-version)" -eq "1" ]; then
				append-flags "-fno-merge-constants"
				append-flags "-fno-merge-constants"
			fi

			if [ "$(gcc-minor-version)" -eq "2" ]; then
				if [ "$(gcc-micro-version)" -lt "2" ]; then
					# Bug #12775 .. fails with -Os.
					replace-flags "-Os" "-O2"
				fi
			elif [ "$(gcc-minor-version)" -lt "2" ]; then
				# Bug #12775 .. fails with -Os.
				replace-flags "-Os" "-O2"
			fi
		elif [ "$(gcc-major-version)" -lt "3" ]; then
			# Bug #12775 .. fails with -Os.
			replace-flags "-Os" "-O2"
		fi

		if ( [ -e "${ROOT}/usr/src/linux" ] \
			&& [ ! $(is_kernel "2" "2") ] ) \
			|| [ "$(uname -r | cut -d. -f1,2)" != "2.2" ]; then
			echo "#define HasLinuxInput YES" >> ${HOSTCONF}
		fi

		echo "#define CcCmd $(tc-getCC)" >> ${HOSTCONF}
		echo "#define OptimizedCDebugFlags ${CFLAGS} GccAliasingArgs" >> ${HOSTCONF}
		echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS} GccAliasingArgs" >> ${HOSTCONF}

		if use static; then
			echo "#define DoLoadableServer	NO" >>${HOSTCONF}
		else
			if use dlloader; then
				einfo "Setting DoLoadableServer/MakeDllModules to YES."
				echo "#define DoLoadableServer  YES" >> ${HOSTCONF}
				echo "#define MakeDllModules    YES" >> ${HOSTCONF}
				if use hardened; then
					echo "#define HardenedGccSpecs YES" >> ${HOSTCONF}
				fi
			fi
		fi

		use_build debug XFree86Devel
		use_build debug BuildDebug
		use_build debug DebuggableLibraries

		if ! use debug; then
			echo "#define ExtraXInputDrivers acecad" >> ${HOSTCONF}

			# use less ram .. got this from Spider's makeedit.eclass :)
			echo "#define GccWarningOptions -Wno-return-type -w" \
				>> ${HOSTCONF}
		fi

		# Remove circular dep between pam and X11, bug #35468
		# If pam is in USE and we have X11, then we can enable PAM
#		if use pam && [ "$(best_version x11-base/xorg-x11)" ]
		if [ "$(best_version x11-base/xorg-x11)" ]; then
			# If you want to have optional pam support, do it properly ...
			use_build pam HasPam
			use_build pam HasPamMisc
		fi

		if use x86 || use alpha; then
			# build with glide3 support? (build the tdfx_dri.o module)
			if use 3dfx; then
				echo "#define HasGlide3 YES" >> ${HOSTCONF}
			fi
# 			This won't work unless we can disable building the tdfx stuff
# 			entirely :/
#			use_build 3dfx HasGlide3
		fi

		if use x86; then
			# optimize Mesa for architecture
			use_build mmx HasMMXSupport
			use_build mmx MesaUseMMX

			use_build 3dnow Has3DNowSupport
			use_build 3dnow MesaUse3DNow

			use_build sse HasKatmaiSupport
			use_build sse MesaUseKatmai
			use_build sse HasSSESupport
			use_build sse MesaUseSSE

			# Compile the VIA driver
			# echo "#define XF86ExtraCardDrivers via" >> ${HOSTCONF}
		fi

		# Do we want the glx extension? This will turn off XF86DRI if it's off.
		# DRI can't build if glx isn't built, so keep this below DRI define.
		# Do this before hppa so they can turn DRI off
		use_build opengl BuildGlxExt
		use_build opengl BuildGLXLibrary
		use_build opengl BuildXF86DRI

		if use hppa; then
			echo "#define DoLoadableServer NO" >> ${HOSTCONF}
			echo "#define BuildXF86DRI NO" >> config/cf/host.def
			echo "#undef DriDrivers" >> config/cf/host.def
			echo "#define XF86CardDrivers fbdev" >> config/cf/host.def
		fi

		# Make xv optional for more minimal builds
		use_build xv BuildXvLibrary
		use_build xv BuildXvExt

		# uclibc love from iggy
		if use uclibc; then
			echo "#define BuildGLULibrary NO" >> config/cf/host.def
		fi

		if use alpha; then
			echo "#define XF86CardDrivers mga nv tga s3virge sis rendition \
				i740 tdfx cirrus tseng fbdev \
				ati vga v4l glint" >> ${HOSTCONF}
		fi

		if use ppc; then
			echo "#define XF86CardDrivers mga glint s3virge sis savage trident \
				chips tdfx fbdev ati DevelDrivers vga nv imstt \
				XF86OSCardDrivers XF86ExtraCardDrivers" >> ${HOSTCONF}
		fi

		if use ppc64; then
			echo "#define MakeDllModules YES" >> ${HOSTCONF}
			echo "#define XF86VgaHw YES" >> ${HOSTCONF}
			echo "#define XF86FBDevHw YES" >> ${HOSTCONF}
			echo "#define XF86CardDrivers fbdev v4l ati vga nv" >> ${HOSTCONF}
		fi

		if use sparc; then
			echo "#define XF86CardDrivers sunffb sunleo suncg6 suncg3 suncg14 \
			suntcx sunbw2 glint mga tdfx ati savage vesa vga fbdev \
			XF86OSCardDrivers XF86ExtraCardDrivers \
			DevelDrivers" >> ${HOSTCONF}
			if use hardened; then
				einfo "Softening the assembler so cfb modules will play nice with sunffb"
				echo "#define AsCmd CcCmd -c -x assembler -fno-pie -fno-PIE" >> ${HOSTCONF}
				echo "#define ModuleAsCmd CcCmd -c -x assembler -fno-pie -fno-PIE" >> ${HOSTCONF}
			fi
			if ( [ -e "${ROOT}/usr/src/linux" ] \
				&& !( $(is_kernel "2" "6") ) ) \
				|| [ "$(uname -r | cut -d. -f1,2)" != "2.6" ]; then
				einfo "Building for kernels less than 2.6 requires special treatment"
				echo "#define UseDeprecatedKeyboardDriver YES" >> ${HOSTCONF}
				einfo "Avoid bug #46593 for sparc32-SMP with kernel 2.4.xx"
				echo "/* Add a line to avoid bug #56593 on sparc32 */" >> \
				  programs/Xserver/hw/xfree86/drivers/ati/r128_driver.c
			fi
		fi

		# The definitions for fontconfig
		echo "#define UseFontconfig YES" >> ${HOSTCONF}
		echo "#define HasFontconfig YES" >> ${HOSTCONF}

		# Use the xorg Xft2 lib
		echo "#define SharedLibXft YES" >> ${HOSTCONF}

		# with USE="X doc' circular dep w/ virtual/ghostscript
		# echo "#define HasGhostScript ${DOC}" >> ${HOSTCONF}
		# Caused issues, basic docs aren't installed
		use_build doc BuildLinuxDocText
		use_build doc BuildLinuxDocPS
		use_build doc BuildSpecsDocs
		use_build doc BuildHtmlManPages
		use_build doc InstallHardcopyDocs

		# enable Japanese docs, optionally
		use doc && use_build cjk InstallJapaneseDocs

		# Native Language Support Fonts
		use_build nls BuildCyrillicFonts
		use_build nls BuildArabicFonts
		use_build nls BuildGreekFonts
		use_build nls BuildHebrewFonts
		use_build nls BuildThaiFonts

		if use nls; then
			use_build cjk BuildCIDFonts
			use_build cjk BuildJapaneseFonts
			use_build cjk BuildKoreanFonts
			use_build cjk BuildChineseFonts
		fi

		# Crappy bitmap fonts
		use_build bitmap-fonts Build75DpiFonts
		use_build bitmap-fonts Build100DpiFonts

		# Type1 fonts
		use_build type1-fonts BuildType1Fonts

		# TrueType fonts
		use_build truetype-fonts BuildTrueTypeFonts

		# X Font Server
		use_build font-server BuildFontServer

		# Distributed Multiheaded X
		use_build dmx BuildDmx

		use_build insecure-drivers BuildDevelDRIDrivers

		if use ipv6; then
			# In case Gentoo ever works on a system with IPv6 sockets that don't
			# also listen on IPv4 (see config/cf/X11.tmpl)
			echo "#define PreferXdmcpIPv6 YES" >> ${HOSTCONF}
		fi

		use_build ipv6 BuildIPv6

		# Ajax is the man for getting this going for us
		echo "#define ProPoliceSupport YES" >> ${HOSTCONF}

		# Make xprint optional
		use_build xprint BuildXprint
		# Build libXp even when xprint is off. It's just for clients, server
		if ! use xprint; then
			echo "#define BuildXprintLib YES" >> ${HOSTCONF}
		fi

	# End the host.def definitions here
	eend 0
}

patch_setup() {
	einfo "Excluding patches..."
		# These have been applied upstream
		patch_exclude 1770 1771 1772 1773

		# This patch is just plain broken. Results in random failures.
		patch_exclude 0120*parallel-make

		# Hardened patches (both broken)
		patch_exclude 9960_all_4.3.0-exec-shield-GNU
		patch_exclude 9961_all_4.3.0-libGL-exec-shield

		# Xbox nvidia driver, patch is a total hack, tears apart xc/config/cf
		# (#68726). Only apply when necessary so we don't screw other stuff up.
		if [ ! "${PROFILE_ARCH}" = "xbox" ]; then
			patch_exclude 9990
		fi

		# this patch comments out the Xserver line in xdm's config
		# We only want it here
		if ! use s390; then
			patch_exclude 7500
		fi

	#	if ! use gatos; then
	#		patch_exclude 9841_all_4.3.0-gatos-mesa
	#	fi

		if use debug; then
			patch_exclude 5901*acecad-debug
		fi

		# TDFX_RISKY - 16-bit, 1024x768 or higher on low-memory voodoo3's
		if use 3dfx && [ "${TDFX_RISKY}" = "yes" ]; then
			patch_exclude 5850
		else
			patch_exclude 5851
		fi
	einfo "Done excluding patches"
}

src_unpack() {

	# Unpack source and patches
	ebegin "Unpacking source"
#		unpack ${P}.tar.bz2
		unpack X11R${PV}-src{1,2,3,4,5}.tar.gz
	eend 0

	if use doc; then
		ebegin "Unpacking documentation"
			unpack X11R${PV}-src{6,7}.tar.gz
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
		if use nls; then
			unpack gemini-koi8-u.tar.bz2 > /dev/null
		fi
		unpack eurofonts-X11.tar.bz2 > /dev/null
		if use font-server; then
			unpack xfsft-encodings-${XFSFT_ENC_VER}.tar.bz2 > /dev/null
		fi
	eend 0

	# Remove bum encoding
	rm -f ${WORKDIR}/usr/share/fonts/encodings/urdunaqsh-0.enc

	patch_setup

	# Bulk patching - based on patch name
	# Will create excluded stuff once it's needed
	cd ${WORKDIR}
	EPATCH_SUFFIX="patch" \
	epatch ${PATCHDIR}
	cd ${S}

	host_def_setup

	cd ${S}
	if use doc; then
		# These are not included anymore as they are obsolete
		local x
		for x in ${S}/programs/Xserver/hw/xfree86/{XF98Conf.cpp,XF98Config}; do
			if [ -f ${x} ]; then
				sed -i '/Load[[:space:]]*"\(pex5\|xie\)"/d' ${x}
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
	if use debug; then
		chmod u+x ${S}/config/util/makeg.sh
		FAST=1 ${S}/config/util/makeg.sh World WORLDOPTS="" \
			|| die "debug make World failed"
	else
		FAST=1 emake World WORLDOPTS="" || die "make World failed"
	fi

	if use nls; then
		emake -C ${S}/nls || die "nls build failed"
	fi

}

backward_compat_setup() {
	# Backwards compatibility for /usr/share move
	G_FONTDIRS="CID Speedo TTF Type1 encodings local misc util"
	if use bitmap-fonts; then
		G_FONTDIRS="${G_FONTDIRS} 75dpi 100dpi"
	fi

	dodir /usr/$(get_libdir)/X11/fonts/
	for G_FONTDIR in ${G_FONTDIRS}; do
		dosym ../../../share/fonts/${G_FONTDIR} /usr/$(get_libdir)/X11/fonts/${G_FONTDIR}
	done

	dosym ../share/man /usr/X11R6/man
	# Have the top-level lib symlink made first, so real dirs don't get created
	dosym ../lib /usr/X11R6/lib
	dosym ../../../share/doc/${PF} /usr/X11R6/$(get_libdir)/X11/doc
#	dosym ../share/bin /usr/X11R6/bin
}

compose_files_setup() {
	# Hack from Mandrake (update ours that just created Compose files for
	# all locales)
	local x
	for x in $(find ${D}/usr/$(get_libdir)/locale/ -mindepth 1 -type d); do
		# make empty Compose files for some locales
		# CJK must not have that file (otherwise XIM don't works some times)
		case $(basename ${x}) in
			C|microsoft-*|iso8859-*|koi8-*)
				if [ ! -f ${x}/Compose ]; then
					touch ${x}/Compose
				fi
				;;
			ja*|ko*|zh*)
				if [ -r ${x}/Compose ]; then
					rm -f ${x}/Compose
				fi
				;;
		esac
	done

	# Another hack from Mandrake -- to fix dead + space for the us
	# international keyboard
	local i
	for i in ${D}/usr/$(get_libdir)/locale/*/Compose; do
		sed -i \
			-e 's/\(<dead_diaeresis> <space>\).*$/\1 : "\\"" quotedbl/' \
			-e "s/\(<dead_acute> <space>\).*$/\1 : \"'\" apostrophe/" ${i} \
			|| eerror "sed ${i} failed"
	done
}

etc_files_install() {
	insinto /etc/X11

	# Install example config file
	newins ${S}/programs/Xserver/hw/xfree86/xorg.conf xorg.conf.example

	exeinto /etc/X11
	# new session management script
	doexe ${FILES_DIR}/chooser.sh
	# new display manager script
	doexe ${FILES_DIR}/startDM.sh
	exeinto /etc/X11/Sessions
	# doexe skips directories, so this should be safe
	doexe ${FILES_DIR}/Sessions/*
	insinto /etc/env.d
	doins ${FILES_DIR}/10xorg
	insinto /etc/X11/xinit
	doins ${FILES_DIR}/xinitrc
	exeinto /etc/X11/xdm
	doexe ${FILES_DIR}/Xsession ${FILES_DIR}/Xsetup_0
	if use font-server; then
		insinto /etc/X11/fs
		newins ${FILES_DIR}/xfs.config config
	fi
	if use pam; then
		insinto /etc/pam.d
		newins ${FILES_DIR}/xdm.pamd xdm
		# Need to fix console permissions first
		newins ${FILES_DIR}/xserver.pamd xserver
	fi
	exeinto /etc/init.d
	newexe ${FILES_DIR}/xdm.start xdm
	if use font-server; then
		newexe ${FILES_DIR}/xfs.start xfs
		insinto /etc/conf.d
		newins ${FILES_DIR}/xfs.conf.d xfs
	fi
}

setup_dynamic_libgl() {
	# next section is to setup the dynamic libGL stuff
	ebegin "Moving libGL and friends for dynamic switching"
		dodir /usr/$(get_libdir)/opengl/${PN}/{$(get_libdir),extensions,include}
		local x=""
		for x in ${D}/usr/$(get_libdir)/libGL.so* \
			${D}/usr/$(get_libdir)/libGL.la \
			${D}/usr/$(get_libdir)/libGL.a \
			${D}/usr/$(get_libdir)/libMesaGL.so; do
			if [ -f ${x} -o -L ${x} ]; then
				# libGL.a cause problems with tuxracer, etc
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${PN}/$(get_libdir)
			fi
		done
			for x in ${D}/usr/$(get_libdir)/modules/extensions/libglx*; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${PN}/extensions
			fi
		done
		# glext.h added for #54984
		for x in ${D}/usr/X11R6/include/GL/{gl.h,glx.h,glxtokens.h,glext.h}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${PN}/include
			fi
		done
		# Since we added glext.h and don't have new opengl-update yet, do this
		# Avoids circular opengl-update/xorg-x11 dependency
		dosym ../../../$(get_libdir)/opengl/${PN}/include/glext.h /usr/X11R6/include/GL/
		# Even if libdir isnt lib, we need a lib symlink for opengl-update and
		# friends. See bug 62990 for more info.
		if [ "$(get_libdir)" != "lib" ]; then
			dosym $(get_libdir) /usr/$(get_libdir)/opengl/${PN}/lib
		fi
	eend 0
}

strip_execs() {
	if use debug || has nostrip ${FEATURES}; then
		ewarn "Debug build turned on by USE=debug"
		ewarn "NOT stripping binaries and libraries"
	else
		local STRIP
		if [ ! -z "${CBUILD}" ] && [ "${CBUILD}" != "${CHOST}" ]; then
			STRIP=${CHOST}-strip
		else
			STRIP=strip
		fi
		einfo "Stripping binaries and libraries..."
		# This bit I got from Redhat ... strip binaries and drivers ..
		# NOTE:  We do NOT want to strip the drivers, modules or DRI modules!
		local x
		for x in $(find ${D}/ -type f -perm +0111 -exec file {} \; | \
		           grep -v ' shared object,' | \
		           sed -n -e 's/^\(.*\):[  ]*ELF.*, not stripped/\1/p'); do
			if [ -f ${x} ]; then
				# Dont do the modules ...
				if [ "${x/\/usr\/$(get_libdir)\/modules}" = "${x}" ]; then
					echo "$(echo ${x/${D}})"
					${STRIP} ${x} || :
				fi
			fi
		done
		# Now do the libraries ...
		for x in ${D}/usr/{$(get_libdir),$(get_libdir)/opengl/${PN}/$(get_libdir)}/*.so.* \
			${D}/usr/{$(get_libdir),$(get_libdir)/locale/$(get_libdir)/common}/*.so.*; do
			if [ -f ${x} ]; then
				echo "$(echo ${x/${D}})"
				${STRIP} --strip-debug ${x} || :
			fi
		done
	fi
}

setup_config_files() {

	# Fix default config files after installing fonts to /usr/share/fonts
	sed -i "s:/usr/X11R6/$(get_libdir)/X11/fonts:/usr/share/fonts:g" \
		${D}/etc/X11/xorg.conf.example
	if use font-server; then
		sed -i "s:/usr/X11R6/$(get_libdir)/X11/fonts:/usr/share/fonts:g" \
			${D}/etc/X11/fs/config
	fi

	# Work around upgrade problem where people have
	# Option "XkbRules" "xfree86" in their config file
	sed -i "s:^.*Option.*"XkbRules".*$::g" ${D}/etc/X11/xorg.conf.example
}

fix_opengl_symlinks() {
	# Remove invalid symlinks
	local LINK
	for LINK in $(find ${D}/usr/$(get_libdir) \
		-name libGL.* -type l); do
		rm -f ${LINK}
	done
	# Create required symlinks
	dosym libGL.so.1.2 /usr/$(get_libdir)/libGL.so
	dosym libGL.so.1.2 /usr/$(get_libdir)/libGL.so.1
	dosym libGL.so.1.2 /usr/$(get_libdir)/libMesaGL.so
}

src_install() {

	unset MAKE_OPTS

	einfo "Installing X.org X11..."
	# gcc3 related fix.  Do this during install, so that our
	# whole build will not be compiled without mmx instructions.
	if [ "$(gcc-version)" != "2.95" ] && use x86; then
		make install DESTDIR=${D} \
		|| make CDEBUGFLAGS="${CDEBUGFLAGS} -mno-mmx" \
			CXXDEBUGFLAGS="${CXXDEBUGFLAGS} -mno-mmx" \
			install DESTDIR=${D} || die "install failed"
	else
		make install DESTDIR=${D} || die "install failed"
	fi

	if use sdk; then
		einfo "Installing X.org X11 SDK..."
		make install.sdk DESTDIR=${D} || die "sdk install failed"
	fi

	einfo "Installing man pages..."
	make install.man DESTDIR=${D} || die "man page install failed"
	einfo "Compressing man pages..."
	prepman /usr

	if use nls; then
		cd ${S}/nls
		make DESTDIR=${D} install || die "nls install failed"
	fi

	backward_compat_setup

	# Fix permissions on locale/common/*.so
	local x
	for x in ${D}/usr/$(get_libdir)/locale/$(get_libdir)/common/*.so*; do
		if [ -f ${x} ]; then
			fperms 0755 ${x/${D}}
		fi
	done

	# Fix permissions on modules ...
	for x in $(find ${D}/usr/$(get_libdir)/modules -name '*.o' -o -name '*.so'); do
		if [ -f ${x} ]; then
			fperms 0755 ${x/${D}}
		fi
	done

	# We zap our CFLAGS in the host.def file, as hardcoded CFLAGS can
	# mess up other things that use xmkmf
	ebegin "Fixing $(get_libdir)/config/host.def"
		cp ${D}/usr/$(get_libdir)/config/host.def ${T}
		awk '!/OptimizedCDebugFlags|OptimizedCplusplusDebugFlags|GccWarningOptions/ {print $0}' \
			${T}/host.def > ${D}/usr/$(get_libdir)/config/host.def \
			|| eerror "Munging host.def failed"
		# theoretically, /usr/lib/X11/config is a possible candidate for
		# config file management. If we find that people really worry about imake
		# stuff, we may add it.  But for now, we leave the dir unprotected.
	eend 0

	# EURO support
	ebegin "Euro Support..."
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/$(get_libdir)" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-8x14.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-8x14-lat9.pcf.gz
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/$(get_libdir)" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-9x16.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-9x16-lat9.pcf.gz
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/$(get_libdir)" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-10x20.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-10x20-lat9.pcf.gz
	eend 0

	# Standard symlinks
	dodir /usr/{bin,include,$(get_libdir)}
	dosym ../X11R6/bin /usr/bin/X11
	dosym ../X11R6/include/X11 /usr/include/X11
	dosym ../X11R6/include/DPS /usr/include/DPS
	dosym ../X11R6/include/GL /usr/include/GL
	dosym ../../usr/$(get_libdir)/xkb /etc/X11/xkb
	# Added one to reflect xkb move from /usr/X11R6/lib/X11/xkb to /usr/lib/xkb
	dosym ../../lib/xkb /usr/X11R6/lib/X11/xkb

	if use opengl; then
		fix_opengl_symlinks
	fi

	# Some critical directories
	keepdir /var/lib/xdm
	dosym ../../../var/lib/xdm /etc/X11/xdm/authdir

	# .la files for libtool support
	insinto /usr/$(get_libdir)
	doins ${FILES_DIR}/$(get_libdir)/*.la

	# Backwards compat, FHS, etc.
	dosym ../../usr/X11R6/bin/Xorg /etc/X11/X

	# Fix perms
	fperms 755 /usr/$(get_libdir)/xkb/geometry/sgi /usr/X11R6/bin/dga

	compose_files_setup

	# Yet more Mandrake
	if use font-server; then
		ebegin "Encoding files for xfsft font server..."
			dodir /usr/share/fonts/encodings
			cp -a ${WORKDIR}/usr/share/fonts/encodings/* \
				${D}/usr/share/fonts/encodings

			for x in ${D}/usr/share/fonts/encodings/{.,large}/*.enc; do
				[ -f "${x}" ] && gzip -9 -f ${x} \
					|| eerror "gzipping ${x} failed"
			done
		eend 0
	fi

	if use nls; then
		ebegin "gemini-koi8 fonts..."
			cd ${WORKDIR}/ukr
			gunzip *.Z || eerror "gunzipping gemini-koi8 fonts failed"
			gzip -9 *.pcf || eerror "gzipping gemini-koi8 fonts failed"
			cd ${S}
			cp -a ${WORKDIR}/ukr ${D}/usr/share/fonts \
				|| eerror "copying gemini-koi8 fonts failed"
		eend 0
	fi

	etc_files_install

	# We move libGLU to /usr/lib now
	dosym libGLU.so.1.3 /usr/$(get_libdir)/libMesaGLU.so

	if use opengl; then
		setup_dynamic_libgl
	fi

	# Make the core cursor the default.  People seem not to like whiteglass
	# for some reason.
	dosed 's:whiteglass:core:' /usr/share/cursors/${PN}/default/index.theme

	strip_execs

	# Install TaD's gentoo cursors
	insinto /usr/share/cursors/${PN}/gentoo/cursors
	doins ${WORKDIR}/cursors/gentoo/cursors/*
	insinto /usr/share/cursors/${PN}/gentoo-blue/cursors
	doins ${WORKDIR}/cursors/gentoo-blue/cursors/*
	insinto /usr/share/cursors/${PN}/gentoo-silver/cursors
	doins ${WORKDIR}/cursors/gentoo-silver/cursors/*

	# Remove xterm app-defaults, since we don't install xterm
#	rm ${D}/etc/X11/app-defaults/{UXTerm,XTerm,XTerm-color}

	# For Battoussai's gatos stuffs:
	if use sdk; then
		insinto /usr/$(get_libdir)/Server/include
		doins ${S}/extras/drm/shared/drm.h
	fi

	# If we want xprint, save the init script before deleting /etc/rc.d/
	# Requested on #68316
	if use xprint; then
		# RH-style init script, we provide a wrapper
		exeinto /usr/lib/misc
		doexe ${D}/etc/rc.d/xprint
		# Install the wrapper
		exeinto /etc/init.d
		doexe ${FILES_DIR}/xprint.init
	fi

	# Remove the /etc/rc.d nonsense -- not everyone is RedHat
	rm -rf ${D}/etc/rc.d

	setup_config_files

}

migrate_usr_x11r6_lib() {
	# We need a symlink from /usr/X11R6/lib -> /usr/lib so all the packages
	# whose files we move don't lose track of them. As such, we need
	# _absolutely nothing_ in /usr/X11R6/lib so we can make such a symlink.
	# Donnie Berkholz <spyderous@gentoo.org> 20 October 2004

	einfo "Migrating from /usr/X11R6/lib to /usr/lib..."
	# Get rid of "standard" symlink from <6.8.0-r2
	# We can't overwrite symlink with directory w/ $(mv -f)
	[ -L ${ROOT}usr/$(get_libdir)/X11 ] \
		&& rm ${ROOT}usr/$(get_libdir)/X11
	# Move everything if it's not a symlink
	[ ! -L ${ROOT}usr/X11R6/$(get_libdir) ] \
		&& mv -f ${ROOT}usr/X11R6/$(get_libdir)/* ${ROOT}usr/$(get_libdir)
	# Remove any floating .keep files so we can run rmdir if it's not a symlink
	[ ! -L ${ROOT}usr/X11R6/$(get_libdir) ] \
		&& find ${ROOT}usr/X11R6/$(get_libdir) -name '\.keep' -exec rm -f {} \;
	# Get rid of the directory if it's not a symlink
	[ ! -L ${ROOT}usr/X11R6/$(get_libdir) ] \
		&& rmdir ${ROOT}usr/X11R6/$(get_libdir)
	# Put a symlink in its place if there's not one there
	[ ! -L ${ROOT}usr/X11R6/$(get_libdir) ] \
		&& ln -s ../$(get_libdir) ${ROOT}usr/X11R6/$(get_libdir)

	# We also need to create a symlink from /usr/X11R6/libdir/X11/xkb
	# to /usr/lib/xkb, so libxklavier and xkb stuff is happy

	einfo "Migrating from /usr/X11R6/$(get_libdir)/X11/xkb to /usr/$(get_libdir)/xkb..."
	# Make the new dir if it doesn't already exist
	[ ! -e ${ROOT}usr/$(get_libdir)/xkb ] \
		&& mkdir ${ROOT}usr/$(get_libdir)/xkb
	# Move anything in the old xkb dir if it's not a symlink
	[ ! -L ${ROOT}usr/X11R6/$(get_libdir)/X11/xkb ] \
		&& mv -f ${ROOT}usr/X11R6/$(get_libdir)/X11/xkb/* \
		${ROOT}usr/$(get_libdir)/xkb
	# Get rid of the directory if it's not a symlink
	[ ! -L ${ROOT}usr/X11R6/$(get_libdir)/X11/xkb ] \
		&& rmdir ${ROOT}usr/X11R6/$(get_libdir)/X11/xkb
	# Add symlink to reflect xkb move from /usr/X11R6/libdir/X11/xkb
	# to /usr/libdir/xkb
	[ ! -L ${ROOT}usr/X11R6/$(get_libdir)/X11/xkb ] \
		&& ln -s ../../$(get_libdir)/xkb \
		${ROOT}usr/X11R6/$(get_libdir)/X11/xkb
}

update_config_files() {
	# Fix any installed config files for installing fonts to /usr/share/fonts
	# This *needs* to be after all other installation so files aren't
	# overwritten.

	if [ "${ROOT}" = "/" ]; then
		einfo "Preparing any installed configuration files for font move..."
		FILES="/etc/X11/xorg.conf
			/etc/X11/XF86Config-4
			/etc/X11/XF86Config"
		if use font-server; then
			FILES="${FILES} /etc/X11/fs/config"
		fi
		#	/etc/fonts/fonts.conf
		#	/etc/fonts/local.conf

		local FILE
		for FILE in ${FILES}; do
			if [ -e ${FILE} ]; then
				# New font paths
				sed "s,/usr/X11R6/$(get_libdir)/X11/fonts,/usr/share/fonts,g" \
					${ROOT}${FILE} > ${IMAGE}${FILE}

				if [ "${FILE}" = "/etc/X11/xorg.conf" ] \
					|| [ "${FILE}" = "/etc/X11/XF86Config" ] \
					|| [ "${FILE}" = "/etc/X11/XF86Config-4" ]; then
					# "keyboard" driver is deprecated and will be removed,
					# switch to "kbd"
					sed -i 's~^\([ \t]*Driver[ \t]\+\)"[kK]eyboard"~\1"kbd"~' \
						${IMAGE}${FILE}

					# This moved in the /usr/X11R6/libdir -> /usr/libdir change
					sed -i 's~^\([ \t]*RgbPath[ \t]\+\)"/usr/X11R6/lib/X11/rgb"~\1"/usr/lib/rgb"~' \
						${IMAGE}${FILE}

					# Work around upgrade problem where people have
					# Option "XkbRules" "xfree86" in their config file
					sed -i "s:^.*Option.*\"XkbRules\".*$::g" \
						${IMAGE}${FILE}
				fi
			fi
		done
	fi
}

clean_dynamic_libgl() {
	# clean the dynamic libGL stuff's home to ensure
	# we don't have stale libs floating around
	if [ -d ${ROOT}/usr/$(get_libdir)/opengl/${PN} ]; then
		rm -rf ${ROOT}/usr/$(get_libdir)/opengl/${PN}/*
	fi

	# make sure we do not have any stale files lying around
	# that could break things. Check old and new locations.
	rm -f ${ROOT}/usr/X11R6/$(get_libdir)/libGL\.* \
		${ROOT}/usr/$(get_libdir)/libGL*
}

pkg_preinst() {
	# Do this before anything else, so we do all the rest inside the symlink
	migrate_usr_x11r6_lib

	update_config_files
	for G_FONTDIR in ${G_FONTDIRS}; do
		# Get rid of deprecated directories so our symlinks in the same location
		# work -- users shouldn't be placing fonts here so that should be fine,
		# they should be using ~/.fonts or /usr/share/fonts. <spyderous>
		if [ -d ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/${G_FONTDIR} ]; then
			# local directory is for sysadmin-added fonts, so save it
			# Note: if we did this in src_install(), we would bring fonts from
			# the build machine to the install machine rather than just moving
			# fonts on the install machine.
			if [ "${G_FONTDIR}" = "local" ]; then
				mv ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/${G_FONTDIR} \
					${ROOT}/usr/share/fonts/
			else
				rm -rf ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/${G_FONTDIR}
			fi
		fi

		# clean out old fonts.* and encodings.dir files, as we
		# will regenerate them
		# Not Speedo or CID, as their fonts.scale files are "real"
		if [ "${G_FONTDIR}" != "CID" -a "${G_FONTDIR}" != "Speedo" ]; then
			find ${ROOT}/usr/share/fonts/${G_FONTDIR} -type f -name 'fonts.*' \
				-o -name 'encodings.dir' -exec rm -f {} \;
		fi
	done

	# No longer used by xorg-x11
	if [ -d ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/truetype ]; then
		rm -rf ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/truetype
	fi

	if [ -L ${ROOT}/etc/X11/app-defaults ]; then
		rm -f ${ROOT}/etc/X11/app-defaults
	fi

	if [ ! -L ${ROOT}/usr/$(get_libdir)/app-defaults ] \
		&& [ -d ${ROOT}/usr/$(get_libdir)/app-defaults ]; then
		if [ ! -d ${ROOT}/etc/X11/app-defaults ]; then
			mkdir -p ${ROOT}/etc/X11/app-defaults
		fi

		mv -f ${ROOT}/usr/$(get_libdir)/app-defaults ${ROOT}/etc/X11
	fi

	if [ -L ${ROOT}/usr/$(get_libdir)/xkb ]; then
		rm -f ${ROOT}/usr/$(get_libdir)/xkb
	fi

	if [ ! -L ${ROOT}/etc/X11/xkb ] \
		&& [ -d ${ROOT}/etc/X11/xkb ]; then
		if [ ! -d ${ROOT}/usr/$(get_libdir)/xkb ]; then
			mkdir -p ${ROOT}/usr/$(get_libdir)
		fi

	    mv -f ${ROOT}/etc/X11/xkb ${ROOT}/usr/$(get_libdir)
	fi

	# Run this even for USE=-opengl, to clean out old stuff from possible
	# USE=opengl build
	clean_dynamic_libgl
}

font_setup() {
	# These cause ttmkfdir to segfault :/
	rm -f ${ROOT}/usr/share/fonts/encodings/iso8859-6.8x.enc.gz
	rm -f ${ROOT}/usr/share/fonts/encodings/iso8859-6.16.enc.gz
#	rm -f ${ROOT}/usr/share/fonts/encodings/large/cns11643-1.enc
#	rm -f ${ROOT}/usr/share/fonts/encodings/large/cns11643-2.enc
#	rm -f ${ROOT}/usr/share/fonts/encodings/large/cns11643-3.enc
#	rm -f ${ROOT}/usr/share/fonts/encodings/suneu-greek.enc

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
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
		${ROOT}/usr/X11R6/bin/mkfontdir -n \
			-e ${ROOT}/usr/share/fonts/encodings \
			-e ${ROOT}/usr/share/fonts/encodings/large \
			-- ${ROOT}/usr/share/fonts/encodings

	eend 0

	if [ -x ${ROOT}/usr/X11R6/bin/ttmkfdir ]; then
		ebegin "Creating fonts.scale files..."
			local x
			for x in $(find ${ROOT}/usr/share/fonts/* -type d -maxdepth 1); do
				[ -z "$(ls ${x}/)" ] && continue
				[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

				# Only generate .scale files if truetype, opentype or type1
				# fonts are present ...

				# First truetype (ttf,ttc)
				# NOTE: ttmkfdir does NOT work on type1 fonts (#53753)
				# Also, there is no way to regenerate Speedo/CID fonts.scale
				# <spyderous@gentoo.org> 2 August 2004
				if [ "${x/encodings}" = "${x}" -a \
				     -n "$(find ${x} -iname '*.tt[cf]' -print)" ]; then
					LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
					${ROOT}/usr/X11R6/bin/ttmkfdir -x 2 \
						-e ${ROOT}/usr/share/fonts/encodings/encodings.dir \
						-o ${x}/fonts.scale -d ${x}
				# Next type1 and opentype (pfa,pfb,otf,otc)
				elif [ "${x/encodings}" = "${x}" -a \
					-n "$(find ${x} -iname '*.[po][ft][abcf]' -print)" ]; then
					LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
					${ROOT}/usr/X11R6/bin/mkfontscale \
						-a ${ROOT}/usr/share/fonts/encodings/encodings.dir \
						-- ${x}
				fi
			done
		eend 0
	else
		eerror "ttmkfdir not found. Unable to prepare TrueType fonts for use."
	fi

	ebegin "Generating fonts.dir files..."
		for x in $(find ${ROOT}/usr/share/fonts/* -type d -maxdepth 1); do
			[ -z "$(ls ${x}/)" ] && continue
			[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

			if [ "${x/encodings}" = "${x}" ]; then
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
				${ROOT}/usr/X11R6/bin/mkfontdir \
					-e ${ROOT}/usr/share/fonts/encodings \
					-e ${ROOT}/usr/share/fonts/encodings/large \
					-- ${x}
			fi
		done
	eend 0

	ebegin "Generating Xft cache..."
		for x in $(find ${ROOT}/usr/share/fonts/* -type d -maxdepth 1); do
			[ -z "$(ls ${x}/)" ] && continue
			[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

			# Only generate XftCache files if there are truetype
			# fonts present ...
			if [ "${x/encodings}" = "${x}" -a \
			     -n "$(find ${x} -iname '*.[otps][pft][cfad]' -print)" ]; then
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
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
	if [ -x ${ROOT}/usr/bin/fc-cache ]; then
		ebegin "Creating FC font cache..."
			HOME="/root" ${ROOT}/usr/bin/fc-cache
		eend 0
	fi
}

print_info() {
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
	ewarn "Run etc-update to update your config files."
	ewarn "Old locations for fonts, docs and man pages"
	ewarn "are deprecated."
	echo
	ewarn "The configuration file has changed from that in XFree86."
	ewarn "It is xorg.conf instead of XF86Config."
	einfo "You may use xorgcfg, X -configure, or xorgconfig"
	einfo "to create xorg.conf."
	einfo "If XF86Config exists and xorg.conf does not, it will still"
	einfo "read XF86Config."

	# Try to get people to read /usr/share/fonts move
	ebeep 5
	epause 10
}

switch_opengl_implem() {
		# Switch to the xorg implementation.
		# Use new opengl-update that will not reset user selected
		# OpenGL interface ...
		echo
		if [ "$(${ROOT}/usr/sbin/opengl-update --get-implementation)" = "xfree" ]; then
			${ROOT}/usr/sbin/opengl-update ${PN}
		else
			${ROOT}/usr/sbin/opengl-update --use-old ${PN}
		fi
}

pkg_postinst() {

	local x=""

	env-update

	if [ "${ROOT}" = "/" ]; then
		umask 022

		font_setup

		if use opengl; then
			switch_opengl_implem
		fi
	fi

	for x in $(find ${ROOT}/usr/$(get_libdir)/locale/ -mindepth 1 -type d); do
		# Remove old compose files we might have created incorrectly
		# CJK must not have that file (otherwise XIM don't works some times)
		case $(basename ${x}) in
			ja*|ko*|zh*)
				if [ -r "${x}/Compose" ]; then
					rm -f ${x}/Compose
				fi
				;;
		esac
	done

	# These need to be owned by root and the correct permissions
	# (bug #8281)
	for x in ${ROOT}/tmp/.{ICE,X11}-unix; do
		if [ ! -d ${x} ]; then
			mkdir -p ${x}
		fi

		chown root:root ${x}
		chmod 1777 ${x}
	done

	if use ppc64; then
		#The problem about display driver is fixed.
		cd ${ROOT}/usr/$(get_libdir)/modules/drivers
		mv fbdev_drv.so fbdev_drv.so.orig
		mv ati_drv.so ati_drv.so.orig
		mv nv_drv.so nv_drv.so.orig

		ld -shared -o ${ROOT}/usr/$(get_libdir)/modules/drivers/fbdev_drv.so ${ROOT}/usr/$(get_libdir)/modules/drivers/fbdev_drv.so.orig ${ROOT}/usr/$(get_libdir)/modules/linux/libfbdevhw.so ${ROOT}/usr/$(get_libdir)/modules/libshadow.so ${ROOT}/usr/$(get_libdir)/modules/libshadowfb.so ${ROOT}/usr/$(get_libdir)/modules/libfb.so
		ld -rpath /usr/$(get_libdir)/modules/drivers -shared -o ati_drv.so ati_drv.so.orig radeon_drv.so atimisc_drv.so fbdev_drv.so r128_drv.so vga_drv.so
		ld -rpath /usr/$(get_libdir)/modules/drivers -shared -o nv_drv.so nv_drv.so.orig fbdev_drv.so vga_drv.so

		if use opengl; then
			#The problem about DRI module and GLX module is fixed.
			cd ${ROOT}/usr/$(get_libdir)/modules/extensions
			mv libglx.so libglx.so.orig
			mv libdri.so libdri.so.orig

			ld -rpath /usr/$(get_libdir)/modules/extensions -shared -o libglx.so libglx.so.orig libGLcore.so
			ld -rpath /usr/$(get_libdir)/modules/extensions -shared -o libdri.so libdri.so.orig libglx.so
		fi
	fi

	print_info
}

pkg_prerm() {

	if use ppc64; then
		cd ${ROOT}/usr/$(get_libdir)/modules/drivers
		mv fbdev_drv.so.orig fbdev_drv.so
		mv ati_drv.so.orig ati_drv.so
		mv nv_drv.so.orig nv_drv.so
		cd ${ROOT}/usr/$(get_libdir)/modules/extensions
		if use opengl; then
			mv libglx.so.orig libglx.so
			mv libdri.so.orig libdri.so
		fi
	fi
}

pkg_postrm() {

	# Fix problematic links
	if [ -x ${ROOT}/usr/X11R6/bin/Xorg ]; then
		ln -snf ../X11R6/bin ${ROOT}/usr/bin/X11
		ln -snf ../X11R6/include/X11 ${ROOT}/usr/include/X11
		ln -snf ../X11R6/include/DPS ${ROOT}/usr/include/DPS
		if use opengl; then
			ln -snf ../X11R6/include/GL ${ROOT}/usr/include/GL
		fi
	fi
}
