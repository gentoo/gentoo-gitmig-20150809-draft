# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-x11/xorg-x11-6.8.0-r3.ebuild,v 1.3 2004/11/20 03:24:47 tgall Exp $

# Set TDFX_RISKY to "yes" to get 16-bit, 1024x768 or higher on low-memory
# voodoo3 cards.

# Libraries which are now supplied in shared form that were not in the past
# include:  libFS.so, libGLw.so, libI810XvMC.so, libXRes.so, libXfontcache.so,
# libXinerama.so, libXss.so, libXvMC.so, libXxf86rush.so, libfontenc.so,
# libxkbfile.so, libxkbui.so

# TODO
# 11 August 2004 <spyderous@gentoo.org>
#   TARGET: patchset 0.2
#		Nothing yet =)

inherit eutils flag-o-matic toolchain-funcs x11

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

# IUSE="gatos" disabled because gatos is broken on ~4.4 now (31 Jan 2004)
IUSE="3dfx 3dnow bitmap-fonts cjk debug dlloader dmx doc hardened
	insecure-drivers ipv6 mmx nls pam sdk sse static xprint"
# IUSE_INPUT_DEVICES="synaptics wacom"

FILES_VER="0.4"
PATCH_VER="0.2.2.1"
XCUR_VER="0.3.1"
#MGADRV_VER="1_3_0beta"
#VIADRV_VER="0.1"
XFSFT_ENC_VER="0.1"

S=${WORKDIR}/xc

HOMEPAGE="http://freedesktop.org/XOrg"

# Misc patches we may need to fetch ..
X_PATCHES="mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2
	http://dev.gentoo.org/~spyderous/${PN}/patchsets/${PV}/${P}-patches-${PATCH_VER}.tar.bz2
	http://dev.gentoo.org/~cyfred/distfiles/${P}-patches-${PATCH_VER}.tar.bz2"

X_DRIVERS=""
#	mirror://gentoo/${P}-drivers-via-${VIADRV_VER}.tar.bz2"
# Latest Savage drivers:  http://www.probo.com/timr/savage40.html
# Latest SIS drivers:  http://www.winischhofer.net/

GENTOO_FILES="mirror://gentoo/${P}-files-${FILES_VER}.tar.bz2
	http://dev.gentoo.org/~spyderous/${PN}/patchsets/${PV}/${P}-files-${FILES_VER}.tar.bz2
	http://dev.gentoo.org/~cyfred/distfiles/${P}-files-${FILES_VER}.tar.bz2"

SRC_URI="mirror://gentoo/eurofonts-X11.tar.bz2
	http://dev.gentoo.org/~cyfred/xorg/${PN}/patchsets/${PV}/xfsft-encodings-${XFSFT_ENC_VER}.tar.bz2
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
KEYWORDS="x86 ~ppc sparc ~ppc64 alpha amd64"

# Need portage-2.0.50_pre9 for `use !foo`
DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	>=sys-devel/flex-2.5.4a-r5
	>=dev-libs/expat-1.95.3
	>=media-libs/freetype-2.1.4
	>=media-libs/fontconfig-2.1-r1
	>=x11-base/opengl-update-1.7.2
	>=x11-misc/ttmkfdir-3.0.9-r2
	>=sys-apps/sed-4
	sys-apps/util-linux
	dev-lang/perl
	media-libs/libpng
	>=sys-apps/portage-2.0.50_pre9
	!x11-base/xfree
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

HOSTCONF="config/cf/host.def"

cflag_setup() {
	# Set up CFLAGS
	filter-flags "-funroll-loops"

	ALLOWED_FLAGS="-fstack-protector -march -mcpu -O -O1 -O2 -O3 -pipe -fomit-frame-pointer -g -gstabs+ -gstabs -ggdb"
	# arch-specific section added by popular demand
	case "${ARCH}" in
		mips)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -mtune -mips1 -mips2 -mips3 -mips4 -mabi" ;;
		# -fomit-frame-pointer known to break things and is pointless
		# according to ciaranm
		# And hardened compiler must be softened. -- fmccor, 20.viii.04
		sparc)	filter-flags "-fomit-frame-pointer"
			if use hardened
			then
				einfo "Softening gcc for sparc"
				ALLOWED_FLAGS="${ALLOWED_FLAGS} -fno-pie -fno-PIE"
				append-flags "-fno-pie -fno-PIE"
			fi
		;;
		# gcc-3.3.2 causes invalid insn error
		hppa ) replace-cpu-flags 2.0 1.0 ;;
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
	FILES_DIR="${WORKDIR}/files"
	PATCHDIR="${WORKDIR}/patch"
	EXCLUDED="${PATCHDIR}/excluded"

	# Set up CFLAG-related things
	cflag_setup

	# See bug #35468, circular pam-X11 dep
	if use pam && best_version x11-base/${PN}
	then
		einfo "Previous ${PN} installation detected"
		einfo "Enabling PAM features in ${PN}..."
	else
		einfo "Previous ${PN} installation NOT detected"
		einfo "Disabling PAM features in ${PN}..."
		einfo "You must remerge ${PN} to enable pam."
		einfo "See http://bugs.gentoo.org/show_bug.cgi?id=35468."
	fi

	if use static || use dlloader
	then
		# A static build disallows building the SDK.
		# See config/xf86.rules.
		# So does a DllModules YES (use dlloader) build (#50562)
		# The latter is pending a potential patch.
		if use sdk
		then
			die "The static and dlloader USE flags are currently incompatible with the sdk USE flag."
		fi
	fi

	if use dmx && use doc
	then
		die "The dmx and doc USE flags are temporarily incompatible and result in a dead build."
	fi

	# on amd64 we need /usr/X11R6/lib64/X11/locale/lib to be a symlink
	# created by the emul lib ebuild in order for adobe acrobat, staroffice,
	# and a few other apps to work.
	use amd64 && get_libdir_override lib64
	# lib32 isnt a supported configuration (yet?)
	[ "${CONF_LIBDIR}" == "lib32" ] && get_libdir_override lib


	# Echo a message to the user about bitmap-fonts
	if ! use bitmap-fonts
	then
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
		cd ${S}; cp ${FILES_DIR}/site.def ${HOSTCONF} || die
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

		# FHS install locations for docs
		echo "#define ManDirectoryRoot /usr/share/man" >> ${HOSTCONF}
		echo "#define DocDir /usr/share/doc/${PF}" >> ${HOSTCONF}
		echo "#define FontDir /usr/share/fonts" >> ${HOSTCONF}

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
		if [ "$(get_libdir)" == "lib64" ] ; then
			echo "#define HaveLib64 YES" >> ${HOSTCONF}
		else
			echo "#define HaveLib64 NO" >> ${HOSTCONF}
		fi

		# Set location of DRM source to be installed
		echo "#define InstSrcDir ${ROOT}/usr/src/${PF}" >> ${HOSTCONF}

		# Bug #12775 .. fails with -Os.
		replace-flags "-Os" "-O2"

		if [ "`gcc-version`" != "2.95" ]
		then
			# Should fix bug #4189.  gcc 3.x have problems with -march=pentium4
			# and -march=athlon-tbird
			# Seems fixed on 3.3 and higher

			if [ "`gcc-major-version`" -eq "3" -a "`gcc-minor-version`" -le "2" ]
			then
				replace-cpu-flags pentium4 pentium3
				replace-cpu-flags athlon athlon-tbird
			fi

			#to fix #56702 for now, thanks Spanky
			[ "$(gcc-version)" == "3.4" ] && use x86 && test_flag -mno-sse2 && append-flags -mno-sse2


			# Try a fix for #49310, see #50931 for more info. <spyderous>
			if [ "`is-flag -fomit-frame-pointer`" ]
			then
				replace-cpu-flags k6 k6-2 k6-3 i586
			fi

			# Without this, modules breaks with gcc3
			if [ "`gcc-version`" = "3.1" ]
			then
				append-flags "-fno-merge-constants"
				append-flags "-fno-merge-constants"
			fi
		fi

		if ( [ -e "${ROOT}/usr/src/linux" ] && \
			[ ! `is_kernel "2" "2"` ] ) || \
			[ "`uname -r | cut -d. -f1,2`" != "2.2" ]
		then
			echo "#define HasLinuxInput YES" >> ${HOSTCONF}
		fi

		echo "#define CcCmd $(tc-getCC)" >> ${HOSTCONF}
		echo "#define OptimizedCDebugFlags ${CFLAGS} GccAliasingArgs" >> ${HOSTCONF}
		echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS} GccAliasingArgs" >> ${HOSTCONF}

		if use static
		then
			echo "#define DoLoadableServer	NO" >>${HOSTCONF}
		else
			if use dlloader ; then
				einfo "Setting DoLoadableServer/MakeDllModules to YES."
				echo "#define DoLoadableServer  YES" >> ${HOSTCONF}
				echo "#define MakeDllModules    YES" >> ${HOSTCONF}
			fi
		fi

		use_build debug XFree86Devel
		use_build debug BuildDebug
		use_build debug DebuggableLibraries

		if use !debug
		then
			echo "#define ExtraXInputDrivers acecad" >> ${HOSTCONF}

			# use less ram .. got this from Spider's makeedit.eclass :)
			echo "#define GccWarningOptions -Wno-return-type -w" \
				>> ${HOSTCONF}
		fi

		# Remove circular dep between pam and X11, bug #35468
		# If pam is in USE and we have X11, then we can enable PAM
#		if use pam && [ "`best_version x11-base/xorg-x11`" ]
		if [ "`best_version x11-base/xorg-x11`" ]
		then
			# If you want to have optional pam support, do it properly ...
			use_build pam HasPam
			use_build pam HasPamMisc
		fi

		if use x86 || use alpha
		then
			# build with glide3 support? (build the tdfx_dri.o module)
			if use 3dfx
			then
				echo "#define HasGlide3 YES" >> ${HOSTCONF}
			fi
# 			This won't work unless we can disable building the tdfx stuff
# 			entirely :/
#			use_build 3dfx HasGlide3
		fi

		if use x86
		then
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

		if use hppa
		then
			echo "#define DoLoadableServer NO" >> ${HOSTCONF}
			echo "#define BuildXF86DRI NO" >> config/cf/host.def
			echo "#undef DriDrivers" >> config/cf/host.def
			echo "#define XF86CardDrivers fbdev" >> config/cf/host.def
		fi

		if use alpha
		then
			echo "#define XF86CardDrivers mga nv tga s3virge sis rendition \
				i740 tdfx cirrus tseng fbdev \
				ati vga v4l glint" >> ${HOSTCONF}
		fi

		if use ppc
		then
			echo "#define XF86CardDrivers mga glint s3virge sis savage trident \
				chips tdfx fbdev ati DevelDrivers vga nv imstt \
				XF86OSCardDrivers XF86ExtraCardDrivers" >> ${HOSTCONF}
		fi

		if use ppc64
		then
			echo "#define MakeDllModules YES" >> ${HOSTCONF}
			echo "#define XF86VgaHw YES" >> ${HOSTCONF}
			echo "#define XF86FBDevHw YES" >> ${HOSTCONF}
			echo "#define XF86CardDrivers fbdev v4l ati vga nv" >> ${HOSTCONF}
		fi

		if use sparc
		then
			echo "#define XF86CardDrivers sunffb sunleo suncg6 suncg3 suncg14 \
			suntcx sunbw2 glint mga tdfx ati savage vesa vga fbdev \
			XF86OSCardDrivers XF86ExtraCardDrivers \
			DevelDrivers" >> ${HOSTCONF}
			if use hardened
			then
				einfo "Softening the assembler so cfb modules will play nice with sunffb"
				echo "#define AsCmd CcCmd -c -x assembler -fno-pie -fno-PIE" >> ${HOSTCONF}
				echo "#define ModuleAsCmd CcCmd -c -x assembler -fno-pie -fno-PIE" >> ${HOSTCONF}
			fi
			if ( [ -e "${ROOT}/usr/src/linux" ] && \
			  !( `is_kernel "2" "6"` ) ) || \
			  [ "`uname -r | cut -d. -f1,2`" != "2.6" ]
			then
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

		if use nls
		then
			use_build cjk BuildCIDFonts
			use_build cjk BuildJapaneseFonts
			use_build cjk BuildKoreanFonts
			use_build cjk BuildChineseFonts
		fi

		# Crappy bitmap fonts
		use_build bitmap-fonts Build75DpiFonts
		use_build bitmap-fonts Build100DpiFonts

		use_build dmx BuildDmx

		use_build insecure-drivers BuildDevelDRIDrivers

		if use ipv6
		then
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
		if ! use xprint
		then
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

		# this patch comments out the Xserver line in xdm's config
		# We only want it here
		if use !s390
		then
			patch_exclude 7500
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
		if use 3dfx && [ "${TDFX_RISKY}" = "yes" ]
		then
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

	if use doc
	then
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
		if use nls
		then
			unpack gemini-koi8-u.tar.bz2 > /dev/null
		fi
		unpack eurofonts-X11.tar.bz2 > /dev/null
		unpack xfsft-encodings-${XFSFT_ENC_VER}.tar.bz2 > /dev/null
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

	epatch ${FILESDIR}/xpm-secfix-thomas.diff

	host_def_setup

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
	if use debug
	then
		chmod u+x ${S}/config/util/makeg.sh
		FAST=1 ${S}/config/util/makeg.sh World WORLDOPTS="" || die
	else
		FAST=1 emake World WORLDOPTS="" || die
	fi

	if use nls
	then
		cd ${S}/nls
		make || die
		cd ${S}
	fi

}

pkgconfig_install() {
	# This one needs to be in /usr/lib
	insinto /usr/$(get_libdir)/pkgconfig
	doins ${D}/usr/X11R6/$(get_libdir)/pkgconfig/*.pc
	# Now remove the invalid xft.pc, and co ...
	rm -rf ${D}/usr/X11R6/$(get_libdir)/pkgconfig
}

backward_compat_setup() {
	# Backwards compatibility for /usr/share move
	G_FONTDIRS="CID Speedo TTF Type1 encodings local misc util"
	if use bitmap-fonts
	then
		G_FONTDIRS="${G_FONTDIRS} 75dpi 100dpi"
	fi

	dodir /usr/X11R6/$(get_libdir)/X11/fonts/
	for G_FONTDIR in ${G_FONTDIRS}
	do
		dosym ${ROOT}/usr/share/fonts/${G_FONTDIR} /usr/X11R6/$(get_libdir)/X11/fonts/${G_FONTDIR}
	done

	dosym ${ROOT}/usr/share/man /usr/X11R6/man
	dosym ${ROOT}/usr/share/doc/${PF} /usr/X11R6/$(get_libdir)/X11/doc
}

compose_files_setup() {
	# Hack from Mandrake (update ours that just created Compose files for
	# all locales)
	for x in $(find ${D}/usr/X11R6/$(get_libdir)/X11/locale/ -mindepth 1 -type d)
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
	for i in ${D}/usr/X11R6/$(get_libdir)/X11/locale/*/Compose
	do
		sed -i \
			-e 's/\(<dead_diaeresis> <space>\).*$/\1 : "\\"" quotedbl/' \
			-e "s/\(<dead_acute> <space>\).*$/\1 : \"'\" apostrophe/" \
			${i}
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
}

setup_dynamic_libgl() {
	# next section is to setup the dynamic libGL stuff
	ebegin "Moving libGL and friends for dynamic switching"
		dodir /usr/$(get_libdir)/opengl/${PN}/{$(get_libdir),extensions,include}
		local x=""
		for x in ${D}/usr/X11R6/$(get_libdir)/libGL.so* \
			${D}/usr/X11R6/$(get_libdir)/libGL.la \
			${D}/usr/X11R6/$(get_libdir)/libGL.a \
			${D}/usr/X11R6/$(get_libdir)/libMesaGL.so
		do
			if [ -f ${x} -o -L ${x} ]
			then
				# libGL.a cause problems with tuxracer, etc
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${PN}/$(get_libdir)
			fi
		done
		for x in ${D}/usr/X11R6/$(get_libdir)/modules/extensions/libglx*
		do
			if [ -f ${x} -o -L ${x} ]
			then
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${PN}/extensions
			fi
		done
		# glext.h added for #54984
		for x in ${D}/usr/X11R6/include/GL/{gl.h,glx.h,glxtokens.h,glext.h}
		do
			if [ -f ${x} -o -L ${x} ]
			then
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${PN}/include
			fi
		done
		# Since we added glext.h and don't have new opengl-update yet, do this
		# Avoids circular opengl-update/xorg-x11 dependency
		dosym /usr/$(get_libdir)/opengl/${PN}/include/glext.h /usr/X11R6/include/GL/
		# Even if libdir isnt lib, we need a lib symlink for opengl-update and
		# friends. See bug 62990 for more info.
		if [ "$(get_libdir)" != "lib" ]
		then
			dosym $(get_libdir) /usr/$(get_libdir)/opengl/${PN}/lib
		fi
	eend 0
}

strip_execs() {
	if use debug
	then
		ewarn "Debug build turned on by USE=debug"
		ewarn "NOT stripping binaries and libraries"
	else
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
				if [ "${x/\/usr\/X11R6\/$(get_libdir)\/modules}" = "${x}" ]
				then
					echo "`echo ${x} | sed -e "s|${D}||"`"
					strip ${x} || :
				fi
			fi
		done
		# Now do the libraries ...
		for x in ${D}/usr/{$(get_libdir),$(get_libdir)/opengl/${PN}/$(get_libdir)}/*.so.* \
			${D}/usr/X11R6/{$(get_libdir),$(get_libdir)/X11/locale/$(get_libdir)/common}/*.so.*
		do
			if [ -f ${x} ]
			then
				echo "`echo ${x} | sed -e "s|${D}||"`"
				strip --strip-debug ${x} || :
			fi
		done
	fi
}

setup_config_files() {

	# Fix default config files after installing fonts to /usr/share/fonts
	sed -i "s:/usr/X11R6/$(get_libdir)/X11/fonts:${ROOT}usr/share/fonts:g" \
		${D}/etc/X11/xorg.conf.example
	sed -i "s:/usr/X11R6/$(get_libdir)/X11/fonts:${ROOT}usr/share/fonts:g" \
		${D}/etc/X11/fs/config

	# Work around upgrade problem where people have
	# Option "XkbRules" "xfree86" in their config file
	sed -i "s:^.*Option.*"XkbRules".*$::g" ${D}/etc/X11/xorg.conf.example
}

update_config_files() {
	# Fix any installed config files for installing fonts to /usr/share/fonts
	# This *needs* to be after all other installation so files aren't
	# overwritten.

	if [ "${ROOT}" = "/" ]
	then
		einfo "Preparing any installed configuration files for font move..."
		FILES="/etc/X11/xorg.conf
			/etc/X11/XF86Config-4
			/etc/X11/XF86Config
			/etc/X11/fs/config"
		#	/etc/fonts/fonts.conf
		#	/etc/fonts/local.conf

		for FILE in ${FILES}
		do
			if [ -e ${FILE} ]
			then
				# New font paths
				sed "s,/usr/X11R6/$(get_libdir)/X11/fonts,/usr/share/fonts,g" \
					${ROOT}${FILE} > ${IMAGE}${FILE}

				if [ "${FILE}" = "/etc/X11/xorg.conf" ] || [ "${FILE}" = "/etc/X11/XF86Config" ] || [ "${FILE}" = "/etc/X11/XF86Config-4" ]
				then
					# "keyboard" driver is deprecated and will be removed,
					# switch to "kbd"
					sed -i 's~^\([ \t]*Driver[ \t]\+\)"[kK]eyboard"~\1"kbd"~' \
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

src_install() {

	unset MAKE_OPTS

	einfo "Installing X.org X11..."
	# gcc3 related fix.  Do this during install, so that our
	# whole build will not be compiled without mmx instructions.
	if [ "`gcc-version`" != "2.95" ] && use x86
	then
		make install DESTDIR=${D} || \
		make CDEBUGFLAGS="${CDEBUGFLAGS} -mno-mmx" \
			CXXDEBUGFLAGS="${CXXDEBUGFLAGS} -mno-mmx" \
			install DESTDIR=${D} || die
	else
		make install DESTDIR=${D} || die
	fi

	if use sdk
	then
		einfo "Installing X.org X11 SDK..."
		make install.sdk DESTDIR=${D} || die
	fi

	pkgconfig_install

	einfo "Installing man pages..."
	make install.man DESTDIR=${D} || die
	einfo "Compressing man pages..."
	prepman /usr/X11R6

	if use nls
	then
		cd ${S}/nls
		make DESTDIR=${D} install || die
	fi

	backward_compat_setup

	# Fix permissions on locale/common/*.so
	for x in ${D}/usr/X11R6/$(get_libdir)/X11/locale/$(get_libdir)/common/*.so*
	do
		if [ -f ${x} ]
		then
			fperms 0755 `echo ${x} | sed -e "s|${D}||"`
		fi
	done

	# Fix permissions on modules ...
	for x in $(find ${D}/usr/X11R6/$(get_libdir)/modules -name '*.o') \
	         $(find ${D}/usr/X11R6/$(get_libdir)/modules -name '*.so')
	do
		if [ -f ${x} ]
		then
			fperms 0755 `echo ${x} | sed -e "s|${D}||"`
		fi
	done

	# We zap our CFLAGS in the host.def file, as hardcoded CFLAGS can
	# mess up other things that use xmkmf
	ebegin "Fixing $(get_libdir)/X11/config/host.def"
		cp ${D}/usr/X11R6/$(get_libdir)/X11/config/host.def ${T}
		awk '!/OptimizedCDebugFlags|OptimizedCplusplusDebugFlags|GccWarningOptions/ {print $0}' \
			${T}/host.def > ${D}/usr/X11R6/$(get_libdir)/X11/config/host.def
		# theoretically, /usr/X11R6/lib/X11/config is a possible candidate for
		# config file management. If we find that people really worry about imake
		# stuff, we may add it.  But for now, we leave the dir unprotected.
	eend 0

	# EURO support
	ebegin "Euro Support..."
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/X11R6/$(get_libdir)" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-8x14.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-8x14-lat9.pcf.gz
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/X11R6/$(get_libdir)" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-9x16.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-9x16-lat9.pcf.gz
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/X11R6/$(get_libdir)" \
		${D}/usr/X11R6/bin/bdftopcf -t ${WORKDIR}/Xlat9-10x20.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-10x20-lat9.pcf.gz
	eend 0

	# Standard symlinks
	dodir /usr/{bin,include,$(get_libdir)}
	dosym ../X11R6/bin /usr/bin/X11
	dosym ../X11R6/include/X11 /usr/include/X11
	dosym ../X11R6/include/DPS /usr/include/DPS
	dosym ../X11R6/include/GL /usr/include/GL
	dosym ../X11R6/$(get_libdir)/X11 /usr/$(get_libdir)/X11
	dosym ../../usr/X11R6/$(get_libdir)/X11/xkb /etc/X11/xkb

	# Some critical directories
	keepdir /var/lib/xdm
	dosym ../../../var/lib/xdm /etc/X11/xdm/authdir

	# Remove invalid symlinks
	rm -f ${D}/usr/$(get_libdir)/libGL.*
	# Create required symlinks
	dosym libGL.so.1.2 /usr/X11R6/$(get_libdir)/libGL.so
	dosym libGL.so.1.2 /usr/X11R6/$(get_libdir)/libGL.so.1
	dosym libGL.so.1.2 /usr/X11R6/$(get_libdir)/libMesaGL.so
	# We move libGLU to /usr/lib now
	dosym libGLU.so.1.3 /usr/$(get_libdir)/libMesaGLU.so

	# .la files for libtool support
	insinto /usr/X11R6/$(get_libdir)
	doins ${FILES_DIR}/lib/*.la

	# Backwards compat, FHS, etc.
	dosym ../../usr/X11R6/bin/Xorg /etc/X11/X

	# Fix perms
	fperms 755 /usr/X11R6/$(get_libdir)/X11/xkb/geometry/sgi
	fperms 755 /usr/X11R6/bin/dga

	compose_files_setup

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

	etc_files_install

	# we want libGLU.so* in /usr/lib
	mv ${D}/usr/X11R6/$(get_libdir)/libGLU.* ${D}/usr/$(get_libdir)

	setup_dynamic_libgl

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
	if use sdk
	then
		insinto /usr/X11R6/$(get_libdir)/Server/include
		doins ${S}/extras/drm/shared/drm.h
	fi

	# Remove the /etc/rc.d nonsense -- not everyone is RedHat
	rm -rf ${D}/etc/rc.d

	setup_config_files

}

pkg_preinst() {

	update_config_files
	for G_FONTDIR in ${G_FONTDIRS}
	do
		# Get rid of deprecated directories so our symlinks in the same location
		# work -- users shouldn't be placing fonts here so that should be fine,
		# they should be using ~/.fonts or /usr/share/fonts. <spyderous>
		if [ -d ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/${G_FONTDIR} ]
		then
			# local directory is for sysadmin-added fonts, so save it
			# Note: if we did this in src_install(), we would bring fonts from
			# the build machine to the install machine rather than just moving
			# fonts on the install machine.
			if [ "${G_FONTDIR}" = "local" ]
			then
				mv ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/${G_FONTDIR} \
					${ROOT}/usr/share/fonts/
			else
				rm -rf ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/${G_FONTDIR}
			fi
		fi

		# clean out old fonts.* and encodings.dir files, as we
		# will regenerate them
		# Not Speedo or CID, as their fonts.scale files are "real"
		if [ "${G_FONTDIR}" != "CID" -a "${G_FONTDIR}" != "Speedo" ]
		then
			find ${ROOT}/usr/share/fonts/${G_FONTDIR} -type f -name 'fonts.*' \
				-exec rm -f {} \;
			find ${ROOT}/usr/share/fonts/${G_FONTDIR} -type f -name 'encodings.dir' \
				-exec rm -f {} \;
		fi
	done

	# No longer used by xorg-x11
	if [ -d ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/truetype ]
	then
		rm -rf ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/truetype
	fi

	if [ -L ${ROOT}/etc/X11/app-defaults ]
	then
		rm -f ${ROOT}/etc/X11/app-defaults
	fi

	if [ ! -L ${ROOT}/usr/X11R6/$(get_libdir)/X11/app-defaults ] && \
	   [ -d ${ROOT}/usr/X11R6/$(get_libdir)/X11/app-defaults ]
	then
		if [ ! -d ${ROOT}/etc/X11/app-defaults ]
		then
			mkdir -p ${ROOT}/etc/X11/app-defaults
		fi

		mv -f ${ROOT}/usr/X11R6/$(get_libdir)/X11/app-defaults ${ROOT}/etc/X11
	fi

	if [ -L ${ROOT}/usr/X11R6/$(get_libdir)/X11/xkb ]
	then
		rm -f ${ROOT}/usr/X11R6/$(get_libdir)/X11/xkb
	fi

	if [ ! -L ${ROOT}/etc/X11/xkb ] && \
	   [ -d ${ROOT}/etc/X11/xkb ]
	then
		if [ ! -d ${ROOT}/usr/X11R6/$(get_libdir)/X11/xkb ]
		then
			mkdir -p ${ROOT}/usr/X11R6/$(get_libdir)/X11
		fi

	    mv -f ${ROOT}/etc/X11/xkb ${ROOT}/usr/X11R6/$(get_libdir)/X11
	fi

	# clean the dynamic libGL stuff's home to ensure
	# we don't have stale libs floating around
	if [ -d ${ROOT}/usr/$(get_libdir)/opengl/${PN} ]
	then
		rm -rf ${ROOT}/usr/$(get_libdir)/opengl/${PN}/*
	fi

	# make sure we do not have any stale files lying around
	# that could break things.
	rm -f ${ROOT}/usr/X11R6/$(get_libdir)/libGL*
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
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/$(get_libdir)" \
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

				# Only generate .scale files if truetype, opentype or type1
				# fonts are present ...

				# First truetype (ttf,ttc)
				# NOTE: ttmkfdir does NOT work on type1 fonts (#53753)
				# Also, there is no way to regenerate Speedo/CID fonts.scale
				# <spyderous@gentoo.org> 2 August 2004
				if [ "${x/encodings}" = "${x}" -a \
				     -n "$(find ${x} -iname '*.tt[cf]' -print)" ]
				then
					LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/$(get_libdir)" \
					${ROOT}/usr/X11R6/bin/ttmkfdir -x 2 \
						-e ${ROOT}/usr/share/fonts/encodings/encodings.dir \
						-o ${x}/fonts.scale -d ${x}
				# Next type1 and opentype (pfa,pfb,otf,otc)
				elif [ "${x/encodings}" = "${x}" -a \
					-n "$(find ${x} -iname '*.[po][ft][abcf]' -print)" ]
				then
					LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/$(get_libdir)" \
					${ROOT}/usr/X11R6/bin/mkfontscale \
						-a ${ROOT}/usr/share/fonts/encodings/encodings.dir \
						-- ${x}
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
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/$(get_libdir)" \
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
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/X11R6/$(get_libdir)" \
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
			HOME="/root" ${ROOT}/usr/bin/fc-cache
		eend 0
	fi
}

print_info() {
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

pkg_postinst() {

	env-update

	if [ "${ROOT}" = "/" ]
	then
		local x=""

		umask 022

		font_setup

		# Switch to the xorg implementation.
		# Use new opengl-update that will not reset user selected
		# OpenGL interface ...
		echo
		if [ "`${ROOT}/usr/sbin/opengl-update --get-implementation`" = "xfree" ]
		then
			${ROOT}/usr/sbin/opengl-update ${PN}
		else
			${ROOT}/usr/sbin/opengl-update --use-old ${PN}
		fi
	fi

	for x in $(find ${ROOT}/usr/X11R6/$(get_libdir)/X11/locale/ -mindepth 1 -type d)
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

	print_info
}

pkg_postrm() {

	# Fix problematic links
	if [ -x ${ROOT}/usr/X11R6/bin/Xorg ]
	then
		ln -snf ../X11R6/bin ${ROOT}/usr/bin/X11
		ln -snf ../X11R6/include/X11 ${ROOT}/usr/include/X11
		ln -snf ../X11R6/include/DPS ${ROOT}/usr/include/DPS
		ln -snf ../X11R6/include/GL ${ROOT}/usr/include/GL
		ln -snf ../X11R6/$(get_libdir)/X11 ${ROOT}/usr/$(get_libdir)/X11
	fi
}
