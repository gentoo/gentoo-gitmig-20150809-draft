# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/kdrive/kdrive-4.3.0-r2.ebuild,v 1.1 2003/11/10 22:58:42 spyderous Exp $

# If you don't want to build the Xvesa server, do this.
# VESA="no" emerge kdrive

# By default, this will build a server with no support for scalable
# fonts (but support for built-in ``fixed'' and ``cursor'' fonts, and
# normal support for bitmap fonts and font-server provided fonts).

IUSE="ipv6 xinerama fbdev speedo type1 cjk truetype freetype fs xv"

# VIDEO_CARDS="savage trident sis530 trio ts300 mach64 i810 igs"

filter-flags "-funroll-loops"

ALLOWED_FLAGS="-fstack-protector -march -mcpu -O -O1 -Os -O2 -O3 -pipe -fomit-frame-pointer"

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
PATCHVER="0.3"
MANDIR=${WORKDIR}/man
PATCHDIR="${WORKDIR}/patch"
BASE_PV="${PV}"
MY_SV="${BASE_PV//\.}"
S="${WORKDIR}/xc"
SRC_PATH="mirror://xfree/${BASE_PV}/source"
DESCRIPTION="Xfree86: famous and free X server. Tiny version (KDrive)"
HOMEPAGE="http://www.xfree.org"
SRC_URI="${SRC_PATH}/X${MY_SV}src-1.tgz
	${SRC_PATH}/X${MY_SV}src-2.tgz
	${SRC_PATH}/X${MY_SV}src-3.tgz
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2"
LICENSE="X11"
SLOT="0"
KEYWORDS="~x86"
# Need portage for USE_EXPAND
DEPEND=">=sys-apps/baselayout-1.8.3
	>=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	>=sys-devel/flex-2.5.4a-r5
	>=dev-libs/expat-1.95.3
	>=sys-apps/sed-4
	dev-lang/perl
	media-libs/libpng
	>=sys-apps/portage-2.0.49-r13"
PROVIDE="virtual/x11"

#inherit needs to happen *after* DEPEND has been defined to have "newdepend"
#do the right thing. Otherwise RDEPEND doesn't get set properly.
inherit eutils flag-o-matic gcc xfree

src_unpack() {
	unpack ${A}

	# Various Patches from all over
	EPATCH_SUFFIX="patch" epatch ${PATCH_DIR}

	ebegin "Setting up config/cf/host.def"

		# See linux.cf for MMX, 3DNOW and SSE autodetection. (spyderous)

		cd ${S}
		touch config/cf/host.def
		echo "#define XVendorString \"Gentoo Linux (KDrive ${PV}, revision ${PR})\"
#define KDriveXServer YES
#define TinyXServer YES
#define ProjectRoot /usr/X11R6
#define BuildLBX NO
#define BuildDBE YES
#define KdriveServerExtraDefines -DPIXPRIV
#define BuildRandR                 YES
#define BuildXInputLib             YES
#define BuildXTrueType             NO
#define BuildScreenSaverExt        YES
#define BuildScreenSaverLibrary    YES
#define SharedLibXss               YES
#define ServerXdmcpDefines         -DXDMCP
#define BuildFonts                 NO" >>config/cf/host.def

		# As far as I know, you can't use Xwrapper for multiple X servers,
		# so we have to suid Xfbdev and Xvesa. mharris (redhat) also does
		# this.
		echo "#define InstallXserverSetUID YES" >> config/cf/host.def
		echo "#define BuildServersOnly YES" >> config/cf/host.def

		if [ "`gcc-version`" != "2.95" ] ; then
			# Should fix bug #4189.  gcc-3.x have problems with -march=pentium4
			# and -march=athlon-tbird
			replace-flags "-march=pentium4" "-march=pentium3"
			replace-flags "-march=athlon-tbird" "-march=athlon"

			# Without this, modules breaks with gcc3
			if [ "`gcc-version`" = "3.1" ] ; then
				append-flags "-fno-merge-constants"
				append-flags "-fno-merge-constants"
			fi
		fi

		# Safe if /usr/src/linux doesn't exist
		if ( [ -e "/usr/src/linux" ] && \
			[ ! `is_kernel "2" "2"` ] ) || \
			[ "`uname -r | cut -d. -f1,2`" != "2.2" ]
		then
			echo "#define HasLinuxInput YES" >> config/cf/host.def
		fi

		echo "#define OptimizedCDebugFlags ${CFLAGS}" >> config/cf/host.def
		echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS}" >> config/cf/host.def

		if use debug ; then
			echo "#define XFree86Devel	YES" >> config/cf/host.def
			echo "#define DoLoadableServer	NO" >>config/cf/host.def
		else
			# use less ram .. got this from Spider's makeedit.eclass :)
			echo "#define GccWarningOptions -Wno-return-type -w" \
				>> config/cf/host.def
		fi

		# Xvesa isn't available on non-x86, non-gcc platforms.
		# See http://lists.debian.org/debian-x/2000/debian-x-200012/msg00029.html
		if vesa no || [ "${ARCH}" != "x86" ] ; then
			echo "#define XvesaServer NO" >> config/cf/host.def
		else
			echo "#define XvesaServer YES" >> config/cf/host.def
		fi

		use fbdev && \
			echo "#define XfbdevServer YES" >> config/cf/host.def || \
			echo "#define XfbdevServer NO" >> config/cf/host.def

		use ipv6 && \
			echo "#define HasIPv6 YES" >> config/cf/host.def

		use xinerama && \
			echo "#define BuildXinerama YES" >> config/cf/host.def

		local KDRIVE_XF_SERVERS="Savage Trident Sis530 Trio TS300 Igs i810 mach64"
		for i in ${KDRIVE_XF_SERVERS} ; do
			# I wish it worked like this. (spyderous)
			# if use video_cards_${i/[A-Z]/[a-z]} ; then
			if use `echo video_cards_${i} | tr [:upper:] [:lower:]` ; then
				echo "#define X${i}Server YES" >> config/cf/host.def
			fi
		done

		# Set up font support
		use speedo && echo "#define BuildSpeedo YES" >> config/cf/host.def
		use type1 && echo "#define BuildType1 YES" >> config/cf/host.def
		use cjk && echo "#define BuildCID YES" >> config/cf/host.def
		use truetype && echo "#define BuildXTrueType YES" >> config/cf/host.def
		use freetype && echo "#define BuildFreeType YES" >> config/cf/host.def
		use fs && echo "#define FontServerAccess YES" >> config/cf/host.def

		# Video
		use xv && echo "#define BuildXvExt YES" >> config/cf/host.def

	eend 0
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

	einfo "Building KDrive..."
	emake World WORLDOPTS="" || die

# Build all man pages because I can't just build one. (spyderous)
	einfo "Making and installing man pages..."
	mkdir ${MANDIR}
	make DESTDIR=${MANDIR} install.man || die
}

src_install() {

	exeinto /usr/X11R6/bin

	# Install Xvesa
	if [ -z "`vesa no`" ] ; then
		doexe programs/Xserver/Xvesa
		fperms 4711 /usr/X11R6/bin/Xvesa
	fi

	# Install Xfbdev
	if use fbdev ; then
		doexe programs/Xserver/Xfbdev
		fperms 4711 /usr/X11R6/bin/Xfbdev
	fi

	# Install the other servers
	local KDRIVE_SERVERS="savage trident sis530 trio ts300 igs i810 mach64"
	for i in ${KDRIVE_SERVERS} ; do
		if use video_cards_${i} ; then
			doexe programs/Xserver/X${i}
			fperms 4711 /usr/X11R6/bin/X${i}
		fi
	done

	# Install our startx script
	doexe ${PATCHDIR}/startxkd

	# Install man pages
	doman -x11 ${MANDIR}/usr/X11R6/man/man1/X{kdrive,vesa,fbdev}.1x
}

pkg_postinst() {
	einfo "You may edit /usr/X11R6/bin/startxkd to your preferences."
	einfo "Xvesa is the default."
	einfo "Or you can use something like:"
	einfo "\"xinit -- /usr/X11R6/bin/Xvesa :0 -screen 1280x1024x16 -nolisten tcp\"."
	einfo "Your ~/.xinitrc will be used if you use xinit."
}

# For allowing Xvesa build to be disabled
vesa() {
	has "$1" "${VESA}"
}
