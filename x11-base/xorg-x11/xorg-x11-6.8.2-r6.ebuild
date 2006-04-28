# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-x11/xorg-x11-6.8.2-r6.ebuild,v 1.16 2006/04/28 18:51:34 spyderous Exp $

# Set TDFX_RISKY to "yes" to get 16-bit, 1024x768 or higher on low-memory
# voodoo3 cards.

# Libraries which are now supplied in shared form that were not in the past
# include:  libFS.so, libGLw.so, libI810XvMC.so, libXRes.so, libXfontcache.so,
# libXinerama.so, libXss.so, libXvMC.so, libXxf86rush.so, libfontenc.so,
# libxkbfile.so, libxkbui.so

# TODO
# 1 June 2005 <spyderous@gentoo.org>
#   TARGET: none
#		Consider building shared libraries only, when both are provided
#		Combine find loops for "Creating fonts.scale files," "Generating
#			fonts.dir files and "Generating Xft cache"
#		<Mr_Bones_> the loop in pkg_postinst for removing Compose can probably
#			be one line of bash expansion like rm -f ${ROOT}/usr/$(get_libdir)/
#			X11/locale/{ja*|ko*|zh*}/Compose
#		Clean up migration function
#			- loop through lib* instead of repetition
#		Fix direction of lib -> libdir symlink
#		Generalize any functions that make sense to generalize (i.e., anything
#			that might realistically see use elsewhere, or repetitively here)
inherit eutils flag-o-matic toolchain-funcs x11 linux-info multilib


# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

# IUSE="gatos" disabled because gatos is broken on ~4.4 now (31 Jan 2004)
IUSE="3dfx 3dnow bitmap-fonts cjk debug dlloader dmx doc font-server
	insecure-drivers ipv6 minimal mmx nls nocxx opengl pam sdk sse static
	truetype-fonts type1-fonts uclibc xprint xv"
# IUSE_INPUT_DEVICES="synaptics wacom"

FILES_VER="0.8"
PATCH_VER="0.1.13"
XCUR_VER="0.3.1"
XFSFT_ENC_VER="0.1"

S=${WORKDIR}/xc

HOMEPAGE="http://xorg.freedesktop.org/"

# Misc patches we may need to fetch ..
X_PATCHES="http://dev.gentoo.org/~joshuabaergen/distfiles/${P}-patches-${PATCH_VER}.tar.bz2
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"

GENTOO_FILES="http://dev.gentoo.org/~seemant/distfiles/${P}-files-${FILES_VER}.tar.bz2
	mirror://gentoo/${P}-files-${FILES_VER}.tar.bz2"

SRC_URI="!minimal? ( mirror://gentoo/eurofonts-X11.tar.bz2 )
	font-server? ( http://dev.gentoo.org/~cyfred/xorg/${PN}/patchsets/${PV}/xfsft-encodings-${XFSFT_ENC_VER}.tar.bz2 )
	!minimal? ( mirror://gentoo/gentoo-cursors-tad-${XCUR_VER}.tar.bz2 )
	nls? ( mirror://gentoo/gemini-koi8-u.tar.bz2 )
	${GENTOO_FILES}
	${X_PATCHES}
	http://xorg.freedesktop.org/X11R${PV}/src-single/X11R${PV}-src.tar.bz2"
#	http://xorg.freedesktop.org/X11R${PV}/src/X11R${PV}-src1.tar.gz
#	http://xorg.freedesktop.org/X11R${PV}/src//X11R${PV}-src2.tar.gz
#	http://xorg.freedesktop.org/X11R${PV}/src//X11R${PV}-src3.tar.gz
#	http://xorg.freedesktop.org/X11R${PV}/src//X11R${PV}-src4.tar.gz
#	http://xorg.freedesktop.org/X11R${PV}/src//X11R${PV}-src5.tar.gz
#	doc? (
#		http://xorg.freedesktop.org/X11R${PV}/src//X11R${PV}-src6.tar.gz
#		http://xorg.freedesktop.org/X11R${PV}/src//X11R${PV}-src7.tar.gz
#	)"

LICENSE="Adobe-X CID DEC DEC-2 IBM-X NVIDIA-X NetBSD SGI UCB-LBL XC-2
	bigelow-holmes-urw-gmbh-luxi christopher-g-demetriou national-semiconductor
	nokia tektronix the-open-group todd-c-miller x-truetype xfree86-1.0
	MIT SGI-B BSD || ( FTL GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh ~sparc x86"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	>=sys-devel/flex-2.5.4a-r5
	sys-apps/groff
	>=dev-libs/expat-1.95.3
	>=media-libs/freetype-2.1.8
	>=media-libs/fontconfig-2.1-r1
	opengl? ( >=x11-base/opengl-update-2.2.0 )
	!nocxx? ( >=x11-apps/ttmkfdir-3.0.9-r2 )
	>=sys-apps/sed-4
	userland_GNU? ( sys-apps/util-linux )
	dev-lang/perl
	media-libs/libpng
	!<=app-emulation/emul-linux-x86-xlibs-1.2-r3"
# FBSDTODO: need to check that X is not pulled in before freebsd-ubin for 'col' presence

RDEPEND="
		>=sys-libs/zlib-1.1.3-r2
		>=sys-devel/flex-2.5.4a-r5
		>=dev-libs/expat-1.95.3
		>=media-libs/freetype-2.1.8
		>=media-libs/fontconfig-2.1-r1
		opengl? ( >=x11-base/opengl-update-2.2.0 )
		!nocxx? ( >=x11-apps/ttmkfdir-3.0.9-r2 )
		media-libs/libpng
		>=sys-libs/ncurses-5.1
		!<=app-emulation/emul-linux-x86-xlibs-1.2-r3"

PDEPEND="x86? (
			input_devices_synaptics? ( x11-drivers/synaptics )
			input_devices_wacom? ( x11-misc/linuxwacom )
		)
		3dfx? ( >=media-libs/glide-v3-3.10 )
		x11-terms/xterm"

PROVIDE="virtual/x11
	opengl? ( virtual/opengl
		virtual/glu )
	virtual/xft"

DESCRIPTION="An X11 implementation maintained by the X.Org Foundation"

pkg_setup() {
	FILES_DIR="${WORKDIR}/files"
	PATCHDIR="${WORKDIR}/patch"
	EXCLUDED="${PATCHDIR}/excluded"

	# Set up CFLAG-related things
	cflag_setup

	# See bug #35468, circular pam-X11 dep
	check_pam

	# Look for invalid/dangerous USE flags and combinations
	check_use_combos

	setup_multilib

	# xfs user
	if use font-server; then
		enewgroup xfs 33
		enewuser xfs 33 -1 /etc/X11/fs xfs
	fi
}

src_unpack() {
	unpack_all

	patch_setup

	do_patch

	host_def_setup

	use_specific_hacks
}

src_compile() {
	build
}

src_install() {
	install_everything

	backward_compat_install

	fix_permissions

	# We zap our CFLAGS in the host.def file, as hardcoded CFLAGS can
	# mess up other things that use xmkmf
	zap_host_def_cflags

	# EURO support
	if ! use minimal; then
		add_euro_support
	fi

	setup_standard_symlinks

	if use opengl; then
		fix_opengl_symlinks
	fi

	libtool_archive_install

	compose_files_install

	if use font-server; then
		encode_xfsft_files
	fi

	if use nls; then
		koi8_fonts_install
	fi

	etc_files_install

	if use opengl; then
		dynamic_libgl_install
	fi

	fix_libtool_libdir_paths "$(find ${D} -name *.la)"

	cursor_install

	strip_execs

	if use minimal; then
		minimal_install
	fi

	# TEMPORARY hack: should be patched in, if it's not already
	# For Battoussai's gatos stuffs:
	if use sdk; then
		insinto /usr/$(get_libdir)/Server/include
		doins ${S}/extras/drm/shared/drm.h
	fi

	xprint_install

	config_files_install
}

pkg_preinst() {
	# Do migration before anything else, so we do all the rest inside the
	# symlink

	# Get rid of "standard" symlinks
	# We can't overwrite symlink with directory w/ $(mv -f)
	[ -L ${ROOT}usr/$(get_libdir)/X11 ] \
		&& rm ${ROOT}usr/$(get_libdir)/X11
	[ -L ${ROOT}usr/include/X11 ] \
		&& rm ${ROOT}usr/include/X11
	[ -L ${ROOT}usr/include/GL ] \
		&& rm ${ROOT}usr/include/GL
	[ -L ${ROOT}usr/bin/X11 ] \
		&& rm ${ROOT}usr/bin/X11
	# Get rid of some apparent artifacts of migration
	[ -L ${ROOT}usr/include/GL/GL ] \
		&& rm ${ROOT}usr/include/GL/GL
	[ -L ${ROOT}usr/include/X11/X11 ] \
		&& rm ${ROOT}usr/include/X11/X11
	[ -d ${ROOT}usr/share/fonts/fonts ] \
		&& rm -rf ${ROOT}usr/share/fonts/fonts

	# No need to do this, if it's already been done
	# Also, it'll overwrite a ton of stuff because it won't realize /usr/X11R6
	# is a symlink.
	if [ ! -L "/usr/X11R6" ]; then
		# Migrate stuff in /usr/X11R6 to /usr
		local DIR DIRS
		DIRS="bin include lib"
		if [ "lib" != "$(get_libdir)" ]; then
			DIRS="${DIRS} $(get_libdir)"
		fi
		for DIR in ${DIRS}; do
			migrate /usr/X11R6/${DIR} /usr/${DIR}
		done
		# Can't do this in the other loop because of different start and end
		migrate /usr/X11R6/man /usr/share/man
	fi

	update_config_files

	cleanup_fonts

	# See above comment for the same test
	if [ ! -L "/usr/X11R6" ]; then
		# Needs to happen after cleanup_fonts()
		migrate /usr/X11R6/$(get_libdir)/X11/fonts /usr/share/fonts

		# Get rid of symlinks so we can migrate /usr/X11R6 without dying when a
		# symlink tries to copy to a dir
		einfo "Preparing for /usr/X11R6 -> /usr migration..."
		local LINK LINKS
		LINKS="bin include lib man share/info"
		if [ "lib" != "$(get_libdir)" ]; then
			LINKS="${LINKS} $(get_libdir)"
		fi
		for LINK in ${LINKS}; do
			if [ -L "${ROOT}/usr/X11R6/${LINK}" ]; then
				rm -fv ${ROOT}/usr/X11R6/${LINK}
			fi
		done
		einfo "Remaining symlinks in /usr/X11R6:"
		find ${ROOT}/usr/X11R6/ -type l

		# Woohoo, nothing in /usr/X11R6 after this
		migrate /usr/X11R6 /usr
	fi

	move_app_defaults_to_etc

	move_xkb_to_usr

	# Run this even for USE=-opengl, to clean out old stuff from possible
	# USE=opengl build
	dynamic_libgl_preinst
}

pkg_postinst() {
	env-update

	if [ "${ROOT}" = "/" ]; then
		font_setup

		if use opengl; then
			switch_opengl_implem
		fi
	fi

	remove_old_compose_files

	setup_tmp_files

	print_info
}

pkg_postrm() {
	fix_links
}

###############
# pkg_setup() #
###############

cflag_setup() {
	# Set up CFLAGS
	filter-flags "-funroll-loops"

	ALLOWED_FLAGS="-fstack-protector -march -mcpu -mtune -O -O0 -O1 -O2 -O3 -Os"
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -pipe -fomit-frame-pointer"
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -momit-leaf-frame-pointer"
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -g -g0 -g1 -g2 -g3"
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -ggdb -ggdb0 -ggdb1 -ggdb2 -ggdb3"
	# arch-specific section added by popular demand
	case "${ARCH}" in
		mips)	ALLOWED_FLAGS="${ALLOWED_FLAGS} -mips1 -mips2 -mips3 -mips4 -mabi"
			;;
		# -fomit-frame-pointer known to break things and is pointless
		# according to ciaranm
		# And hardened compiler must be softened. -- fmccor, 20.viii.04
		sparc)	filter-flags "-fomit-frame-pointer" "-momit-leaf-frame-pointer"
			if has_hardened && ! use dlloader; then
				einfo "Softening gcc for sparc."
				ALLOWED_FLAGS="${ALLOWED_FLAGS} -fno-pie -fno-PIE"
				append-flags -fno-pie -fno-PIE
			fi

			if [[ ${ABI} == "sparc64" ]]; then
				ALLOWED_FLAGS="${ALLOWED_FLAGS} -D__sparc_v9__ -D__linux_sparc_64__"
				append-flags -D__sparc_v9__ -D__linux_sparc_64__
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

check_pam() {
	if use pam && has_version x11-base/${PN}; then
		einfo "Previous ${PN} installation detected."
		einfo "Enabling PAM features in ${PN}."
	else
		einfo "Previous ${PN} installation NOT detected."
		einfo "Disabling PAM features in ${PN}."
		einfo "You must remerge ${PN} to enable pam."
		einfo "See http://bugs.gentoo.org/show_bug.cgi?id=35468."
	fi
}

check_use_combos() {
	if use static; then
		# A static build disallows building the SDK.
		# See config/xf86.rules.
		if use sdk; then
			die "The static USE flag is incompatible with the sdk USE flag."
		fi
	fi

	if use dmx && use doc; then
		die "The dmx and doc USE flags are temporarily incompatible and result in a dead build."
	fi

	# (#77949)
	if use minimal && use doc; then
		die "The minimal and doc USE flags are temporarily incompatible and result in a dead build."
	fi

	if use xv && ! use opengl; then
		eerror "See http://bugs.gentoo.org/show_bug.cgi?id=67996"
		eerror "The xv USE flag currently requires the opengl flag."
		die "This is a known bug. Do not report it."
	fi

	if use opengl && ! use xv; then
		eerror "See http://bugs.gentoo.org/show_bug.cgi?id=76936"
		eerror "The opengl USE flag currently requires the xv flag."
		die "This is a known bug. Do not report it."
	fi

	# Echo a message to the user about bitmap-fonts
	if ! use bitmap-fonts; then
		ewarn "Please emerge this with USE=\"bitmap-fonts\" to enable"
		ewarn "75dpi and 100dpi fonts.  Your GTK+-1.2 fonts may look"
		ewarn "screwy otherwise"

		ebeep 5
		epause 10
	fi
}

setup_multilib() {
	# on amd64 we need /usr/lib64/X11/locale/lib to be a symlink
	# created by the emul lib ebuild in order for adobe acrobat, staroffice,
	# and a few other apps to work.
	if ! has_multilib_profile; then
		use amd64 && get_libdir_override lib64
	fi
}

################
# src_unpack() #
################

unpack_all() {
	# Unpack source and patches
	ebegin "Unpacking ${PV} source"
		unpack X11R${PV}-src.tar.bz2 > /dev/null
#		unpack X11R${PV}-src{1,2,3,4,5}.tar.gz > /dev/null
	eend 0

#	if use doc; then
#		ebegin "Unpacking documentation"
#			unpack X11R${PV}-src{6,7}.tar.gz > /dev/null
#		eend 0
#	fi

	ebegin "Unpacking Gentoo files and patches"
		unpack ${P}-files-${FILES_VER}.tar.bz2 > /dev/null
		unpack ${P}-patches-${PATCH_VER}.tar.bz2 > /dev/null
	eend 0

	if ! use minimal; then
		# Unpack TaD's gentoo cursors
		ebegin "Unpacking Gentoo cursors"
			unpack gentoo-cursors-tad-${XCUR_VER}.tar.bz2 > /dev/null
		eend 0
	fi

	# Unpack extra fonts stuff from Mandrake
	ebegin "Unpacking fonts"
		if use nls; then
			unpack gemini-koi8-u.tar.bz2 > /dev/null
		fi
		if ! use minimal; then
			unpack eurofonts-X11.tar.bz2 > /dev/null
		fi
		if use font-server; then
			unpack xfsft-encodings-${XFSFT_ENC_VER}.tar.bz2 > /dev/null
		fi
	eend 0

	# Remove bum encoding
	rm -f ${WORKDIR}/usr/share/fonts/encodings/urdunaqsh-0.enc
}

do_patch() {
	# Bulk patching - based on patch name
	# Will create excluded stuff once it's needed
	cd ${WORKDIR}
	EPATCH_SUFFIX="patch" \
	epatch ${PATCHDIR}
	cd ${S}
}

host_def_setup() {
	HOSTCONF="config/cf/host.def"

	ebegin "Setting up ${HOSTCONF}"
		cd ${S}; cp ${FILES_DIR}/site.def ${HOSTCONF} \
			|| die "host.def copy failed"
		echo "#define XVendorString \"Gentoo (The X.Org Foundation ${PV}, revision ${PR}-${PATCH_VER})\"" \
			>> ${HOSTCONF}

		# Pending http://bugs.gentoo.org/show_bug.cgi?id=49038 and
		# http://freedesktop.org/cgi-bin/bugzilla/show_bug.cgi?id=600
		#
		# Makes ld bail at link time on undefined symbols
		# Suggested by Mike Harris <mharris@redhat.com>
		#echo "#define SharedLibraryLoadFlags  -shared -Wl,-z,defs" \
		#	>> ${HOSTCONF}

		# Enable i810 on x86_64 (RH #126687)
		if use amd64; then
			echo "#define XF86ExtraCardDrivers i810" >> ${HOSTCONF}
		fi

		# FHS install locations
		echo "#define ManDirectoryRoot /usr/share/man" >> ${HOSTCONF}
		echo "#define DocDir /usr/share/doc/${PF}" >> ${HOSTCONF}
		echo "#define FontDir /usr/share/fonts" >> ${HOSTCONF}
		echo "#define BinDir /usr/bin" >> ${HOSTCONF}
		echo "#define IncRoot /usr/include" >> ${HOSTCONF}
		# This breaks the case when $(SYSTEMUSRINCDIR) = $(INCDIR)
		# See xc/include/Imakefile
		echo "#define LinkGLToUsrInclude NO" >> ${HOSTCONF}
		# /usr/X11R6/lib/X11
		echo "#define LibDir /usr/$(get_libdir)/X11" >> ${HOSTCONF}
		# /usr/X11R6/lib with exception of /usr/X11R6/lib/X11
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
			sed -i '/^#define Freetype2LibDir/s:^.*$:#define Freetype2LibDir /usr/lib64:' ${HOSTCONF}
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

				if [ "$(gcc-minor-version)" -eq "4" ]; then
					if [ "$(gcc-micro-version)" -lt "4" ]; then
						#to fix #57602 for now, thanks Spanky (broken sse2)
						if test_flag -mno-sse2; then
							append-flags -mno-sse2
						fi
						# (#75067) broken sse3
						if test_flag -mno-sse3; then
							append-flags -mno-sse3
						fi
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

		echo "#define CcCmd $(tc-getCC)" >> ${HOSTCONF}
		echo "#define OptimizedCDebugFlags ${CFLAGS} GccAliasingArgs" >> ${HOSTCONF}
		echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS} GccAliasingArgs" >> ${HOSTCONF}

		if use static; then
			echo "#define DoLoadableServer	NO" >>${HOSTCONF}
		else
			einfo "Setting DoLoadableServer to YES."
			echo "#define DoLoadableServer  YES" >> ${HOSTCONF}

			if use dlloader; then
				einfo "Setting MakeDllModules to YES."
				echo "#define MakeDllModules    YES" >> ${HOSTCONF}
				if has_hardened; then
					echo "#define HardenedGccSpecs YES" >> ${HOSTCONF}
				fi
			else
				einfo "Setting MakeDllModules to NO."
				echo "#define MakeDllModules    NO" >> ${HOSTCONF}
			fi
		fi

		use_build debug XFree86Devel
		use_build debug BuildDebug
		use_build debug DebuggableLibraries

		if ! use debug; then
			# use less ram .. got this from Spider's makeedit.eclass :)
			echo "#define GccWarningOptions -Wno-return-type -w" \
				>> ${HOSTCONF}
		fi

		# Remove circular dep between pam and X11, bug #35468
		# If pam is in USE and we have X11, then we can enable PAM
#		if use pam && has_version x11-base/xorg-x11
		if has_version x11-base/xorg-x11; then
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
			use_build 3dnow Has3DNowSupport
			use_build sse HasSSESupport
		fi

		# optimize Mesa for architecture
		if use amd64; then
			use_build amd64 HasMMXSupport
			use_build amd64 Has3DNowSupport
			use_build amd64 HasSSESupport
		fi

		# Do we want the glx extension? This will turn off XF86DRI if it's off.
		# DRI can't build if glx isn't built, so keep this below DRI define.
		# Do this before hppa so they can turn DRI off
		use_build opengl BuildGlxExt
		use_build opengl BuildGLXLibrary
		use_build opengl BuildXF86DRI
		# Needs GL headers
		use_build opengl BuildGLULibrary



		if use mips; then
			echo "#define XF86CardDrivers fbdev newport" >> ${HOSTCONF}
		fi

		# Make xv optional for more minimal builds
		use_build xv BuildXvLibrary
		use_build xv BuildXvExt
		# Depends on X11/extensions/Xv.h
		use_build xv BuildXF86RushExt
		use_build xv BuildXF86RushLibrary

		if use hppa; then
			echo "#define DoLoadableServer NO" >> ${HOSTCONF}
			echo "#define BuildXF86DRI NO" >> config/cf/host.def
			echo "#undef DriDrivers" >> config/cf/host.def
			echo "#define XF86CardDrivers fbdev" >> config/cf/host.def
			echo "#define BuildXvExt YES" >> config/cf/host.def
		fi


		if use alpha; then
			echo "#define XF86CardDrivers mga nv tga s3virge sis rendition \
				i740 tdfx cirrus tseng fbdev \
				ati vga v4l glint s3 vesa" >> ${HOSTCONF}
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
			echo "#define XF86CardDrivers mga fbdev v4l ati vga nv" >> ${HOSTCONF}
		fi

		if use sparc; then
			echo "#define XF86CardDrivers sunffb sunleo suncg6 suncg3 suncg14 \
			suntcx sunbw2 glint mga tdfx ati savage vesa vga fbdev \
			XF86OSCardDrivers XF86ExtraCardDrivers \
			DevelDrivers" >> ${HOSTCONF}
			if has_hardened && ! use dlloader; then
				einfo "Softening the assembler so cfb modules will play nice with sunffb."
				echo "#define AsCmd CcCmd -c -x assembler -fno-pie -fno-PIE" >> ${HOSTCONF}
				echo "#define ModuleAsCmd CcCmd -c -x assembler -fno-pie -fno-PIE" >> ${HOSTCONF}
			fi
			if ( [ -e "${ROOT}/usr/src/linux" ] \
				&& ! kernel_is "2" "6" ) \
				|| [ "$(uname -r | cut -d. -f1,2)" != "2.6" ]; then
				# Commented out next two lines due to patch from bug #61940
				# Joshua Baergen, Sept 19, 2005
#				einfo "Building for kernels less than 2.6 requires special treatment."
#				echo "#define UseDeprecatedKeyboardDriver YES" >> ${HOSTCONF}
				einfo "Avoid bug #46593 for sparc32-SMP with kernel 2.4.xx."
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

		if use minimal; then
			# Don't build static libs
			echo "#define ForceNormalLib NO" >> ${HOSTCONF}
			# Turn back on needed ones
			echo "#define NormalLibXau YES" >> ${HOSTCONF}

			echo "#define BuildDPSLibraries NO" >> ${HOSTCONF}
			echo "#define BuildClients NO" >> ${HOSTCONF}
			# BuildClients doesn't catch things in xc/programs/Xserver
			# Also had to add
			# 9250_all_6.8.1.904-respect-xfree86configtools-setting.patch
			echo "#define BuildXFree86ConfigTools NO" >> ${HOSTCONF}
			echo "#define BuildLBX NO" >> ${HOSTCONF}

			# Weird crap we don't need
			echo "#define XF8_32Wid NO" >> ${HOSTCONF}
			echo "#define XF8_32Bpp NO" >> ${HOSTCONF}
			echo "#define XF8_16Bpp NO" >> ${HOSTCONF}
			echo "#define XF24_32Bpp NO" >> ${HOSTCONF}

			# Without nls, truetype-fonts, type1-fonts, we only build misc
			# Now let's try to reduce what gets built in misc
			# iso8859-1 has the "fixed" font
			echo "#define BuildISO8859_2Fonts NO" >> ${HOSTCONF}
			echo "#define BuildISO8859_3Fonts NO" >> ${HOSTCONF}
			echo "#define BuildISO8859_4Fonts NO" >> ${HOSTCONF}
			# 5 is cyrillic, 6 isn't in misc, 7 is greek, 8 is hebrew
			echo "#define BuildISO8859_9Fonts NO" >> ${HOSTCONF}
			echo "#define BuildISO8859_10Fonts NO" >> ${HOSTCONF}
			# 11 is thai, 12 isn't in misc
			echo "#define BuildISO8859_13Fonts NO" >> ${HOSTCONF}
			echo "#define BuildISO8859_14Fonts NO" >> ${HOSTCONF}
			echo "#define BuildISO8859_15Fonts NO" >> ${HOSTCONF}
			echo "#define BuildISO8859_16Fonts NO" >> ${HOSTCONF}

			echo "#define XnestServer NO" >> ${HOSTCONF}
			echo "#define XVirtualFramebufferServer NO" >> ${HOSTCONF}
			echo "#define XInputDrivers mouse keyboard" >> ${HOSTCONF}

			# If you want more drivers built with minimal, file a bug
			# -Donnie Berkholz <spyderous@gentoo.org>
			if use x86; then
				# Remove glint, tga, s3, s3virge, rendition, neomagic, i740,
				# cirrus, tseng, trident, chips, apm, ark, cyrix, siliconmotion
				# mga, nv, sis, tdfx, savage, GlideDriver, i386Drivers
				# (nsc, i810), ati, DevelDrivers, via
				# Leave vmware driver for testing minimal setups using VMWare
				# XF86OSCardDrivers includes v4l and fbdev on linux
				# DevelDrivers includes imstt and newport on x86
				echo "#define XF86CardDrivers vmware vesa vga dummy \
					XF86OSCardDrivers XF86ExtraCardDrivers" >> ${HOSTCONF}
			# (#93339)
			elif use sparc; then
				echo "#define XF86CardDrivers vesa vga fbdev sunffb suncg6 \
					sunleo" >> ${HOSTCONF}
			fi
		fi

		# Ajax is the man for getting this going for us
		echo "#define ProPoliceSupport YES" >> ${HOSTCONF}

		# Make xprint optional
		use_build xprint BuildXprint
		use_build xprint BuildXprintClients
		# Build libXp even when xprint is off. It's just for clients, server
		if ! use xprint; then
			echo "#define BuildXprintLib YES" >> ${HOSTCONF}
		fi

	# End the host.def definitions here
	eend 0
}

patch_setup() {
	einfo "Excluding patches..."

		# This patch is just plain broken. Results in random failures.
		patch_exclude 0120*parallel-make

		# Hardened patches (both broken)
		patch_exclude 9960_all_4.3.0-exec-shield-GNU
		patch_exclude 9961_all_4.3.0-libGL-exec-shield

		# Xbox nvidia driver, patch is a total hack, tears apart xc/config/cf
		# (#68726). Only apply when necessary so we don't screw other stuff up.
		# 9990 is the driver, 9991 is xbox pci scanning (potentially useful)
		if [ ! "${PROFILE_ARCH}" = "xbox" ]; then
			patch_exclude 9990 9991
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

		# Glibc-specific patches to exclude for non-glibc systems
		if use elibc_FreeBSD || use elibc_OpenBSD; then
			patch_exclude 0700
		fi
	einfo "Done excluding patches."
}

use_specific_hacks() {
	# uclibc lacks sinf and cosf
	if use uclibc; then
		sed -i -e 's:GLXCLIENTDIRS = glxinfo glxgears:GLXCLIENTDIRS = :' \
			${S}/programs/Imakefile
	fi

	# Get rid of cursor sets other than core and handhelds, saves ~4MB
	if use minimal; then
		 sed -i -e 's:SUBDIRS = redglass whiteglass handhelds:SUBDIRS = handhelds:' \
			${S}/programs/xcursorgen/Imakefile
	fi

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

#################
# src_compile() #
#################

build() {
	# If a user defines the MAKE_OPTS variable in /etc/make.conf instead of
	# MAKEOPTS, they'll redefine an internal xorg Makefile variable and the
	# xorg build will silently die. This is tricky to track down, so I'm
	# adding a preemptive fix for this issue by making sure that MAKE_OPTS is
	# unset. (drobbins, 08 Mar 2003)
	unset MAKE_OPTS

	einfo "Building xorg-x11..."
	if use debug; then
		chmod u+x ${S}/config/util/makeg.sh
		FAST=1 ${S}/config/util/makeg.sh World WORLDOPTS="" MAKE="make" \
			|| die "debug make World failed"
	else
		FAST=1 emake -j1 World WORLDOPTS="" MAKE="make" || die "make World failed"
	fi

	if use nls; then
		emake -j1 -C ${S}/nls MAKE="make" || die "nls build failed"
	fi
}

#################
# src_install() #
#################

install_everything() {
	unset MAKE_OPTS

	einfo "Installing X.org X11..."
	# gcc3 related fix.  Do this during install, so that our
	# whole build will not be compiled without mmx instructions.
	if [ "$(gcc-version)" != "2.95" ] && use x86; then
		make install MAKE="make" DESTDIR=${D} \
		|| make CDEBUGFLAGS="${CDEBUGFLAGS} -mno-mmx" \
			CXXDEBUGFLAGS="${CXXDEBUGFLAGS} -mno-mmx" \
			install MAKE="make" DESTDIR=${D} || die "install failed"
	else
		make install MAKE="make" DESTDIR=${D} || die "install failed"
	fi

	if use sdk; then
		einfo "Installing X.org X11 SDK..."
		make install.sdk MAKE="make" DESTDIR=${D} || die "sdk install failed"
	fi

	if ! use minimal; then
		einfo "Installing man pages..."
		make install.man MAKE="make" DESTDIR=${D} || die "man page install failed"
		einfo "Compressing man pages..."
		prepman /usr
	fi

	if use nls; then
		cd ${S}/nls
		make MAKE="make" DESTDIR=${D} install || die "nls install failed"
	fi
	dodoc ${S}/RELNOTES
}

backward_compat_install() {
	# Backwards compatibility for /usr/share move
	dosym ../../share/fonts /usr/$(get_libdir)/X11/fonts

	# Have the top-level libdir symlink made first, so real dirs don't get created
	local DIR DIRS
	if [ "lib" != "$(get_libdir)" ]; then
		DIRS="${DIRS} $(get_libdir)"
	fi
	for DIR in ${DIRS}; do
		dosym ../${DIR} /usr/X11R6/${DIR}
	done

	dosym ../../../share/doc/${PF} /usr/X11R6/$(get_libdir)/X11/doc
}

fix_permissions() {
	# Fix permissions on locale/common/*.so
	local x
	for x in ${D}/usr/$(get_libdir)/X11/locale/$(get_libdir)/common/*.so*; do
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

	# Fix perms
	if ! use minimal; then
		fperms 755 /usr/$(get_libdir)/X11/xkb/geometry/sgi /usr/bin/dga
	fi
}

zap_host_def_cflags() {
	ebegin "Fixing $(get_libdir)/X11/config/host.def"
		cp ${D}/usr/$(get_libdir)/X11/config/host.def ${T}
		awk '!/OptimizedCDebugFlags|OptimizedCplusplusDebugFlags|GccWarningOptions/ {print $0}' \
			${T}/host.def > ${D}/usr/$(get_libdir)/X11/config/host.def \
			|| eerror "Munging host.def failed"
		# theoretically, /usr/lib/X11/config is a possible candidate for
		# config file management. If we find that people really worry about imake
		# stuff, we may add it.  But for now, we leave the dir unprotected.
	eend 0
}

add_euro_support() {
	ebegin "Adding Euro support"
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/$(get_libdir)" \
		${D}/usr/bin/bdftopcf -t ${WORKDIR}/Xlat9-8x14.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-8x14-lat9.pcf.gz
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/$(get_libdir)" \
		${D}/usr/bin/bdftopcf -t ${WORKDIR}/Xlat9-9x16.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-9x16-lat9.pcf.gz
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${D}/usr/$(get_libdir)" \
		${D}/usr/bin/bdftopcf -t ${WORKDIR}/Xlat9-10x20.bdf | \
			gzip -9 > ${D}/usr/share/fonts/misc/Xlat9-10x20-lat9.pcf.gz
	eend 0
}

setup_standard_symlinks() {
	# Standard symlinks
	dodir /usr/{bin,include,$(get_libdir)}
	dosym ../bin /usr/bin/X11
	# Stop complains about "file or directory not existing"
	dodir /usr/X11R6
	dosym ../include /usr/X11R6/include
	dosym ../../usr/$(get_libdir)/X11/xkb /etc/X11/xkb

	# Some critical directories
	if ! use minimal; then
		keepdir /var/lib/xdm
		dosym ../../../var/lib/xdm /etc/X11/xdm/authdir
	fi

	# Backwards compat, FHS, etc.
	dosym ../../usr/X11R6/bin/Xorg /etc/X11/X
}

libtool_archive_install() {
	if use opengl; then
		# .la files for libtool support
		insinto /usr/$(get_libdir)
		# (#67729) Needs to be lib, not $(get_libdir)
		doins ${FILES_DIR}/lib/*.la
	fi
}

fix_libtool_libdir_paths() {
	local dirpath
	for archive in ${*} ; do
		dirpath=$(dirname ${archive} | sed -e "s:^${D}::")
		[[ ${dirpath::1} == "/" ]] || dirpath="/"${dirpath}
		sed -i ${archive} -e "s:^libdir.*:libdir=\'${dirpath}\':"
	done
}

compose_files_install() {
	# Hack from Mandrake (update ours that just created Compose files for
	# all locales)
	local x
	for x in $(find ${D}/usr/$(get_libdir)/X11/locale/ -mindepth 1 -type d); do
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
	for i in ${D}/usr/$(get_libdir)/X11/locale/*/Compose; do
		sed -i \
			-e 's/\(<dead_diaeresis> <space>\).*$/\1 : "\\"" quotedbl/' \
			-e "s/\(<dead_acute> <space>\).*$/\1 : \"'\" apostrophe/" ${i} \
			|| eerror "sed ${i} failed"
	done
}

encode_xfsft_files() {
	# Yet more Mandrake
	ebegin "Encoding files for xfsft font server"
		dodir /usr/share/fonts/encodings
		cp -pPR ${WORKDIR}/usr/share/fonts/encodings/* \
			${D}/usr/share/fonts/encodings

		for x in ${D}/usr/share/fonts/encodings/{.,large}/*.enc; do
			if [ -f "${x}" ]; then
				gzip -9 -f ${x} \
					|| eerror "gzipping ${x} failed"
			fi
		done
	eend 0
}

koi8_fonts_install() {
	ebegin "Adding gemini-koi8 fonts"
		cd ${WORKDIR}/ukr
		gunzip *.Z || eerror "gunzipping gemini-koi8 fonts failed"
		gzip -9 *.pcf || eerror "gzipping gemini-koi8 fonts failed"
		cd ${S}
		cp -pPR ${WORKDIR}/ukr ${D}/usr/share/fonts \
			|| eerror "copying gemini-koi8 fonts failed"
	eend 0
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
	if ! use minimal; then
		exeinto /etc/X11/xdm
		doexe ${FILES_DIR}/Xsession
		exeinto /etc/init.d
		newexe ${FILES_DIR}/xdm.start xdm
	fi
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
	if use font-server; then
		newexe ${FILES_DIR}/xfs.start xfs
		insinto /etc/conf.d
		newins ${FILES_DIR}/xfs.conf.d xfs
	fi
}

dynamic_libgl_install() {
	# next section is to setup the dynamic libGL stuff
	ebegin "Moving libGL and friends for dynamic switching"
		dodir /usr/$(get_libdir)/opengl/${PN}/{lib,extensions,include}
		local x=""
		for x in ${D}/usr/$(get_libdir)/libGL.so* \
			${D}/usr/$(get_libdir)/libGL.la \
			${D}/usr/$(get_libdir)/libGL.a; do
			if [ -f ${x} -o -L ${x} ]; then
				# libGL.a cause problems with tuxracer, etc
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${PN}/lib
			fi
		done
			for x in ${D}/usr/$(get_libdir)/modules/extensions/libglx*; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${PN}/extensions
			fi
		done
		# glext.h added for #54984
		for x in ${D}/usr/include/GL/{gl.h,glx.h,glxtokens.h,glext.h,glxext.h,glxmd.h,glxproto.h}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${PN}/include
			fi
		done
	eend 0
}

cursor_install() {
	# Make the core cursor the default.  People seem not to like whiteglass
	# for some reason.
	dosed 's:whiteglass:core:' /usr/share/cursors/${PN}/default/index.theme

	if ! use minimal; then
		install_extra_cursors
	fi
}

strip_execs() {
	if use debug || has nostrip ${FEATURES}; then
		ewarn "Debug build turned on by USE=debug or FEATURES=nostrip"
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
		for x in ${D}/usr/{$(get_libdir),$(get_libdir)/opengl/${PN}/lib}/*.so.* \
			$(get_libdir)/X11/locale/$(get_libdir)/common}/*.so.*; do
			if [ -f ${x} ]; then
				echo "$(echo ${x/${D}})"
				${STRIP} --strip-debug ${x} || :
			fi
		done
	fi
}

install_extra_cursors() {
	# Install TaD's gentoo cursors
	insinto /usr/share/cursors/${PN}/gentoo/cursors
	doins ${WORKDIR}/cursors/gentoo/cursors/*
	insinto /usr/share/cursors/${PN}/gentoo-blue/cursors
	doins ${WORKDIR}/cursors/gentoo-blue/cursors/*
	insinto /usr/share/cursors/${PN}/gentoo-silver/cursors
	doins ${WORKDIR}/cursors/gentoo-silver/cursors/*
}

minimal_install() {
		# Get rid of all unnecessary fonts (saves ~5.5 MB)
		find ${D}/usr/share/fonts/misc/ -name '*.pcf.gz' \
			-not -name '*6x13*' -not -name 'cursor.pcf.gz' -exec rm {} \;
		# Woohoo, another 772K
		rm -rf ${D}/usr/share/doc
}

xprint_install() {
	# If we want xprint, save the init script before deleting /etc/rc.d/
	# Requested on #68316
	if use xprint; then
		xprint_init_install
	else
		# delete xprint stuff
		rm -f ${D}/etc/{init,profile}.d/xprint*
		rmdir --ignore-fail-on-non-empty ${D}/etc/{init,profile}.d
	fi

	# Remove the /etc/rc.d nonsense -- not everyone is RedHat
	rm -rf ${D}/etc/rc.d
}

xprint_init_install() {
	# RH-style init script, we provide a wrapper
	exeinto /usr/$(get_libdir)/misc
	doexe ${D}/etc/init.d/xprint
	rm -f ${D}/etc/init.d/xprint
	# Install the wrapper
	newinitd ${FILES_DIR}/xprint.init xprint
	# patch profile scripts
	sed -i -e "s:/bin/sh.*get_xpserverlist:/usr/$(get_libdir)/misc/xprint get_xpserverlist:g" ${D}/etc/profile.d/xprint*
	# move profile scripts, we can't touch /etc/profile.d/ in Gentoo
	dodoc ${D}/etc/profile.d/xprint*
	rm -f ${D}/etc/profile.d/xprint*
}

config_files_install() {

	# Fix default config files after installing fonts to /usr/share/fonts
	sed -i -e "s:/usr/X11R6/$(get_libdir)/X11/fonts:/usr/share/fonts:g" \
		-e "s:/usr/$(get_libdir)/X11/fonts:/usr/share/fonts:g" \
		-e "s:/usr/$(get_libdir)/fonts:/usr/share/fonts:g" \
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
}

#################
# pkg_preinst() #
#################

# We need a symlink /usr/X11R6/dir -> /usr/dir so all the packages
# whose files we move don't lose track of them. As such, we need
# _absolutely nothing_ in /usr/X11R6/dir so we can make such a symlink.
# Donnie Berkholz <spyderous@gentoo.org> 20 October 2004
#
# Takes two arguments -- starting location and ending location
migrate() {
	einfo "Migrating from ${1} to ${2}..."

	# Strip trailing slash
	if [ -z "${1##*/}" ]; then
		set -- ${1%/} ${2}
	fi

	if [ -e ${ROOT}${1} ]; then
		# If it's not a symlink (in other words, it should be a directory)
		if [ ! -L ${ROOT}${1} ]; then
			einfo "  ${1} isn't a symlink, migrating..."
			# Move everything
					rsync \
						--archive \
						--update \
						--links \
						--hard-links \
						--ignore-existing \
						--stats \
						--progress \
						--verbose \
						${ROOT}${1}/ ${ROOT}${2} > ${T}/migrate-${1//\//-}.log 2>&1

					check_migrate_return
					remove_migrated_files ${1}

			if [ -e "${ROOT}${1}" ]; then
				# Remove any floating .keep files so we can run rmdir
				find ${ROOT}${1} -name '\.keep' -exec rm -f {} \;
				# Get rid of the directory
				rmdir ${ROOT}${1}
			fi

			make_symlinks ${1}
		else
			ewarn "    ${1} is a symlink, not migrating"
		fi
	else
		ewarn "  ${1} doesn't exist, not migrating"
		make_symlinks ${1}
	fi
}

check_migrate_return() {
	MIGRATE_RETURN="$?"
	if [ "${MIGRATE_RETURN}" -eq "0" ]; then
		einfo "rsync successful!"
	else
		eerror "rsync failed."
		eerror "Check for migrate-* files in ${T}."
		die "rsync failed. Exit code: ${MIGRATE_RETURN}."
	fi

	# Migration fubars lib symlinks -- eradicator
	if use amd64; then
		if [[ -L ${ROOT}usr/lib64 ]]; then
			rm ${ROOT}usr/lib64
			ln -s lib ${ROOT}usr/lib64
		elif [[ -L ${ROOT}usr/lib ]]; then
			rm -f ${ROOT}usr/lib
			ln -s lib64 ${ROOT}usr/lib
		elif [[ -L ${ROOT}usr/lib32 ]]; then
			if has_multilib_profile; then
			ln -s lib ${ROOT}usr/lib32
			else
				ln -s ../emul/linux/x86/usr/lib ${ROOT}usr/lib32
			fi
		fi
	fi
}

remove_migrated_files() {
	# This is a copy instead of a move, so we need to get rid of what
	# we copied. This is a little risky if it fails, so just do it on
	# success.

	# DO NOT proceed if we don't have an argument, or we kill root filesystem
	if [ -z "${1}" ]; then
		die "No argument to remove_migrated_files(). Want to `rm -rf ${ROOT}`?"
	fi

	if [ "${MIGRATE_RETURN}" -eq "0" ]; then
#		rm -rfv ${ROOT}${1} > ${T}/migrate-remove-${1//\//-}.log 2>&1
		rm -rfv ${ROOT}${1}
	fi
}

make_symlinks() {
			# Put a symlink in its place

			# Special case: lib != libdir
			if [ "${1##*/}" = "$(get_libdir)" -a "$(get_libdir)" != "lib" ]; then
				einfo "    Symlinking ${ROOT}usr/X11R6/lib -> $(get_libdir)"
				ln -s $(get_libdir) ${ROOT}usr/X11R6/lib
			# Special case: fonts
			elif [ "${1##*/}" = "fonts" ]; then
				einfo "    Symlinking ${ROOT}${1} -> ../../share/fonts"
				ln -s ../../share/fonts ${ROOT}${1}
			# Special case: X11R6
			elif [ "${1##*/}" = "X11R6" ]; then
				einfo "    Symlinking ${ROOT}${1} -> ../usr"
				ln -s ../usr ${ROOT}${1}
			else
				einfo "    Symlinking ${ROOT}${1} -> ../${1##*/}"
				ln -s ../${1##*/} ${ROOT}${1}
			fi
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
					sed -i \
						-e 's~^\([ \t]*RgbPath[ \t]\+\)"/usr/X11R6/$(get_libdir)/X11/rgb"~\1"/usr/$(get_libdir)/X11/rgb"~' \
						-e 's~^\([ \t]*RgbPath[ \t]\+\)"/usr/X11R6/lib/X11/rgb"~\1"/usr/lib/X11/rgb"~' \
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

cleanup_fonts() {
	local G_FONTDIRS
	G_FONTDIRS="Speedo encodings local misc util"
	if use truetype-fonts; then
		G_FONTDIRS="${G_FONTDIRS} TTF"
	fi
	if use type1-fonts; then
		G_FONTDIRS="${G_FONTDIRS} Type1"
	fi
	if use cjk; then
		G_FONTDIRS="${G_FONTDIRS} CID"
	fi
	if use bitmap-fonts; then
		G_FONTDIRS="${G_FONTDIRS} 75dpi 100dpi"
	fi
	if use nls; then
		G_FONTDIRS="${G_FONTDIRS} cyrillic ukr"
	fi

	for G_FONTDIR in ${G_FONTDIRS}; do
		# clean out old fonts.* and encodings.dir files, as we
		# will regenerate them
		# Not Speedo or CID, as their fonts.scale files are "real"
		if [ "${G_FONTDIR}" != "CID" -a "${G_FONTDIR}" != "Speedo" ]; then
			find ${ROOT}/usr/share/fonts/${G_FONTDIR} -type f -name 'fonts.*' \
				-o -name 'encodings.dir' -exec rm -fv {} \;
		fi
	done

	# Get rid of deprecated directories so our symlinks in the same location
	# work -- users shouldn't be placing fonts here so that should be fine,
	# they should be using ~/.fonts or /usr/share/fonts. <spyderous>
	remove_font_dirs
}

remove_font_dirs() {
	if [ -e ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts ]; then
		if [ ! -L ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts ]; then
			local G_FONTDIR
			for G_FONTDIR in ${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts/*; do
				if [ -L "${G_FONTDIR}" ]; then
					einfo "Removing ${G_FONTDIR} symlink."
					rm -rfv ${G_FONTDIR}
				else
					ewarn "${G_FONTDIR} not a symlink, moving to /usr/share/fonts"
					if [ -d ${G_FONTDIR} ]; then
						if [ ! -e /usr/share/fonts/${G_FONTDIR##*/} ]; then
							einfo "Moving ${G_FONTDIR} to /usr/share/fonts/."
							mv ${G_FONTDIR} /usr/share/fonts/
						else
							ewarn "/usr/share/fonts/${G_FONTDIR##*/} exists. Remove it and try again."
						fi
					else
						ewarn "${G_FONTDIR} does not exist."
					fi
				fi
			done
		fi
	else
		ewarn "${ROOT}/usr/X11R6/$(get_libdir)/X11/fonts does not exist."
	fi
}

move_app_defaults_to_etc() {
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
}

move_xkb_to_usr() {
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
}

dynamic_libgl_preinst() {
	# clean the dynamic libGL stuff's home to ensure
	# we don't have stale libs floating around
	if [ -d ${ROOT}/usr/$(get_libdir)/opengl/${PN} ]; then
		rm -rf ${ROOT}/usr/$(get_libdir)/opengl/${PN}/*
	fi

	# make sure we do not have any stale files lying around
	# that could break things. Check old and new locations.
	rm -f ${ROOT}/usr/X11R6/$(get_libdir)/libGL\.* \
		${ROOT}/usr/$(get_libdir)/libGL\.*
}

##################
# pkg_postinst() #
##################

font_setup() {
	umask 022

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

	ebegin "Generating encodings.dir"
		# Create the encodings.dir in /usr/share/fonts/encodings
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
		${ROOT}/usr/bin/mkfontdir -n \
			-e ${ROOT}/usr/share/fonts/encodings \
			-e ${ROOT}/usr/share/fonts/encodings/large \
			-- ${ROOT}/usr/share/fonts/encodings

	eend 0

	ebegin "Creating fonts.scale files"
		local x
		for x in $(find ${ROOT}/usr/share/fonts/* -maxdepth 1 -type d); do
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
				if [ -x ${ROOT}/usr/bin/ttmkfdir ]; then
					LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
					${ROOT}/usr/bin/ttmkfdir -x 2 \
						-e ${ROOT}/usr/share/fonts/encodings/encodings.dir \
						-o ${x}/fonts.scale -d ${x}
					# ttmkfdir fails on some stuff, so try mkfontscale if it does
					local ttmkfdir_return=$?
				else
					# We didn't use ttmkfdir at all
					local ttmkfdir_return=2
				fi
				if [ ${ttmkfdir_return} -ne 0 ]; then
					LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
					${ROOT}/usr/bin/mkfontscale \
						-a /usr/share/fonts/encodings/encodings.dir \
						-- ${x}
				fi
			# Next type1 and opentype (pfa,pfb,otf,otc)
			elif [ "${x/encodings}" = "${x}" -a \
				-n "$(find ${x} -iname '*.[po][ft][abcf]' -print)" ]; then
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
				${ROOT}/usr/bin/mkfontscale \
					-a ${ROOT}/usr/share/fonts/encodings/encodings.dir \
					-- ${x}
			fi
		done
	eend 0

	ebegin "Generating fonts.dir files"
		for x in $(find ${ROOT}/usr/share/fonts/* -maxdepth 1 -type d); do
			[ -z "$(ls ${x}/)" ] && continue
			[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

			if [ "${x/encodings}" = "${x}" ]; then
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
				${ROOT}/usr/bin/mkfontdir \
					-e ${ROOT}/usr/share/fonts/encodings \
					-e ${ROOT}/usr/share/fonts/encodings/large \
					-- ${x}
			fi
		done
	eend 0

	ebegin "Generating Xft cache"
		for x in $(find ${ROOT}/usr/share/fonts/* -maxdepth 1 -type d); do
			[ -z "$(ls ${x}/)" ] && continue
			[ "$(ls ${x}/)" = "fonts.cache-1" ] && continue

			# Only generate XftCache files if there are truetype
			# fonts present ...
			if [ "${x/encodings}" = "${x}" -a \
			     -n "$(find ${x} -iname '*.[otps][pft][cfad]' -print)" ]; then
				LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${ROOT}/usr/$(get_libdir)" \
				${ROOT}/usr/bin/xftcache ${x} &> /dev/null
			fi
		done
	eend 0

	ebegin "Fixing permissions"
		find ${ROOT}/usr/share/fonts/ -type f -name 'font.*' \
			-exec chmod 0644 {} \;
	eend 0

	# danarmak found out that fc-cache should be run AFTER all the above
	# stuff, as otherwise the cache is invalid, and has to be run again
	# as root anyway
	if [ -x ${ROOT}/usr/bin/fc-cache ]; then
		ebegin "Creating FC font cache"
			HOME="/root" ${ROOT}/usr/bin/fc-cache
		eend 0
	fi
}

switch_opengl_implem() {
		# Switch to the xorg implementation.
		# Use new opengl-update that will not reset user selected
		# OpenGL interface ...
		echo
		local opengl_implem="$(${ROOT}/usr/sbin/opengl-update --get-implementation)"
		${ROOT}/usr/sbin/opengl-update --use-old ${PN}
}

remove_old_compose_files() {
	for x in $(find ${ROOT}/usr/$(get_libdir)/X11/locale/ -mindepth 1 -type d); do
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
}

setup_tmp_files() {
	# These need to be owned by root and the correct permissions
	# (bug #8281)
	local x=""
	for x in ${ROOT}/tmp/.{ICE,X11}-unix; do
		if [ ! -d ${x} ]; then
			mkdir -p ${x}
		fi

		chown root:wheel ${x}
		chmod 1777 ${x}
	done
}

print_info() {
	echo
	einfo "Please note that the xcursors are in /usr/share/cursors/${PN}."
	einfo "Any custom cursor sets should be placed in that directory."
	echo
	einfo "If you wish to set system-wide default cursors, please create"
	einfo "/usr/local/share/cursors/${PN}/default/index.theme"
	einfo "with content: \"Inherits=theme_name\" so that future"
	einfo "emerges will not overwrite those settings."
	echo
	einfo "Listening on TCP is disabled by default with startx."
	einfo "To enable it, edit /usr/bin/startx."
	echo

	echo
	ewarn "BEWARE:"
	ewarn "/usr/X11R6/$(get_libdir) has MOVED"
	ewarn "to /usr/$(get_libdir)"
	ewarn "Run etc-update to update your config files."
	ewarn "Old locations for anything in /usr/X11R6/$(get_libdir)"
	ewarn "are deprecated."
	echo
	# (#76985)
	einfo "Visit http://www.gentoo.org/doc/en/index.xml?catid=desktop"
	einfo "for more information on configuring X."

	# Try to get people to read /usr/X11R6/libdir move
	ebeep 5
	epause 10
}

fix_links() {
	# Fix problematic links
	if [ -x ${ROOT}/usr/bin/Xorg ]; then
		ln -snf ../bin ${ROOT}/usr/bin/X11
	fi
}
