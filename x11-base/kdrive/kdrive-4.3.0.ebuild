# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/kdrive/kdrive-4.3.0.ebuild,v 1.4 2003/09/06 22:07:08 msterret Exp $

# If you don't want to build the Xvesa server, do this.
# VESA="no" emerge kdrive

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

IUSE="sse mmx 3dnow ipv6 xinerama type1 truetype fbdev"

# VIDEO_CARDS="savage trident sis trio ts300 mach64 i810 igs"

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
PATCHVER="0.1"

PATCHDIR="${WORKDIR}/files"
BASE_PV="${PV}"
MY_SV="${BASE_PV//\.}"
S="${WORKDIR}/xc"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/${BASE_PV}/source"
SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/${BASE_PV}/source"
HOMEPAGE="http://www.xfree.org"

SRC_URI="${SRC_PATH0}/X${MY_SV}src-1.tgz
	${SRC_PATH0}/X${MY_SV}src-2.tgz
	${SRC_PATH0}/X${MY_SV}src-3.tgz
	${SRC_PATH1}/X${MY_SV}src-1.tgz
	${SRC_PATH1}/X${MY_SV}src-2.tgz
	${SRC_PATH1}/X${MY_SV}src-3.tgz
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="X11"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-apps/baselayout-1.8.3
	>=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
	>=sys-devel/flex-2.5.4a-r5
	>=dev-libs/expat-1.95.3
	>=sys-apps/sed-4
	dev-lang/perl
	media-libs/libpng
	app-arch/unzip
	pam? ( >=sys-libs/pam-0.75 )"

PROVIDE="virtual/x11"

#inherit needs to happen *after* DEPEND has been defined to have "newdepend"
#do the right thing. Otherwise RDEPEND doesn't get set properly.
inherit eutils flag-o-matic gcc xfree

DESCRIPTION="Xfree86: famous and free X server. Tiny version (Kdrive)"

vesa() {
	has "$1" "${VESA}"
}

src_unpack() {

	# Unpack source and patches
	unpack ${A}
	# Kdrive patch
	epatch ${PATCHDIR}/XFree86-4.2.99.1-kdrive-posix-sigaction.patch

	ebegin "Setting up config/cf/host.def"
	cd ${S}
#	cp config/cf/site.def config/cf/host.def || die
	touch config/cf/host.def
	echo "#define XVendorString \"Gentoo Linux (TinyX ${PV}, revision ${PR})\"
#define KDriveXServer YES
#define TinyXServer YES
#define ProjectRoot /usr/X11R6
#define BuildLBX YES
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
			append-flags "-fno-merge-constants"
			append-flags "-fno-merge-constants"
		fi
	fi

	if [ "`uname -r | cut -d. -f1,2`" != "2.2" ]
	then
		echo "#define HasLinuxInput YES" >> config/cf/host.def
	fi

	echo "#define OptimizedCDebugFlags ${CFLAGS}" >> config/cf/host.def
	echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS}" >> config/cf/host.def
	if use debug
	then
		echo "#define XFree86Devel	YES" >> config/cf/host.def
		echo "#define DoLoadableServer	NO" >>config/cf/host.def
	else
		# use less ram .. got this from Spider's makeedit.eclass :)
		echo "#define GccWarningOptions -Wno-return-type -w" \
			>> config/cf/host.def
	fi

	if [ "${ARCH}" = "x86" ]
	then
		# optimize for architecture
		if use mmx &>/dev/null
		then
			echo "#define HasMMXSupport	YES" >> config/cf/host.def
		else
			echo "#define HasMMXSupport	NO" >> config/cf/host.def
		fi
		if use 3dnow &>/dev/null
		then
			echo "#define Has3DNowSupport YES" >> config/cf/host.def
		else
			echo "#define Has3DNowSupport NO" >> config/cf/host.def
		fi
		if use sse &>/dev/null
		then
			echo "#define HasKatmaiSupport YES" >> config/cf/host.def
		else
			echo "#define HasKatmaiSupport NO" >> config/cf/host.def
		fi

	fi

	# Xvesa isn't available on non-x86, non-gcc platforms.
	# See http://lists.debian.org/debian-x/2000/debian-x-200012/msg00029.html

	if vesa no &> /dev/null
	then
		echo "#define XvesaServer NO" >> config/cf/host.def
	else
		if [ "${ARCH}" != "x86" ]
		then
			echo "#define XvesaServer NO" >> config/cf/host.def
		else
			echo "#define XvesaServer YES" >> config/cf/host.def
		fi
	fi

	if use fbdev &> /dev/null
	then
		echo "#define XfbdevServer YES" >> config/cf/host.def
	else
		echo "#define XfbdevServer NO" >> config/cf/host.def
	fi

	if use ipv6 &>/dev/null
	then
		echo "#define HasIPv6 YES" >> config/cf/host.def
	fi

	if use xinerama &>/dev/null
	then
		echo "#define BuildXinerama YES" >> config/cf/host.def
		# Don't know if this is necessary. Probably.
		echo "#define BuildXineramaLibrary YES" >> config/cf/host.def
	fi

	# By default, this will build a server with no support for scalable
	# fonts (but support for built-in ``fixed'' and ``cursor'' fonts, and
	# normal support for bitmap fonts and font-server provided fonts).

	if use type1 &>/dev/null
	then
		echo "#define BuildType1 YES" >> config/cf/host.def
	fi

	if use truetype &>/dev/null
	then
		echo "#define BuildFreeType YES" >> config/cf/host.def
	fi

	if vcards savage &>/dev/null
	then
		echo "#define XSavageServer YES" >> config/cf/host.def
	fi

	if vcards trident &>/dev/null
	then
		echo "#define XTridentServer YES" >> config/cf/host.def
	fi

	if vcards sis &>/dev/null
	then
		echo "#define XSis530Server YES" >> config/cf/host.def
	fi

	if vcards trio &>/dev/null
	then
		echo "#define XTrioServer YES" >> config/cf/host.def
	fi

	if vcards ts300 &>/dev/null
	then
		echo "#define XTS300Server YES" >> config/cf/host.def
	fi

	if vcards igs &>/dev/null
	then
		echo "#define XIgsServer YES" >> config/cf/host.def
	fi

	if vcards i810 &>/dev/null
	then
		echo "#define Xi810Server YES" >> config/cf/host.def
	fi

	if vcards mach64 &>/dev/null
	then
		echo "#define Xmach64Server YES" >> config/cf/host.def
	fi

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

	einfo "Building XFree86..."
	emake World || die

# Build man
	ebegin "Making and installing man pages..."
	local M=${WORKDIR}/man
	mkdir ${M}
	make install.man DESTDIR=${M} || die
	eend 0

}

src_install() {

	exeinto /usr/X11R6/bin

	if [ -z "`vesa no`" ]
	then
		doexe programs/Xserver/Xvesa
		fperms 4755 /usr/X11R6/bin/Xvesa
	fi

	if use fbdev &> /dev/null
	then
	doexe programs/Xserver/Xfbdev
	fperms 4755 /usr/X11R6/bin/Xfbdev
	fi

	if vcards savage &>/dev/null
	then
	doexe programs/Xserver/Xsavage
	fperms 4755 /usr/X11R6/bin/Xsavage
	fi

	if vcards trident &>/dev/null
	then
	doexe programs/Xserver/Xtrident
	fperms 4755 /usr/X11R6/bin/Xtrident
	fi

	if vcards sis &>/dev/null
	then
	doexe programs/Xserver/Xsis530
	fperms 4755 /usr/X11R6/bin/Xsis530
	fi

	if vcards trio &>/dev/null
	then
	doexe programs/Xserver/Xtrio
	fperms 4755 /usr/X11R6/bin/Xtrio
	fi

	if vcards ts300 &>/dev/null
	then
	doexe programs/Xserver/Xts300
	fperms 4755 /usr/X11R6/bin/Xts300
	fi

	if vcards igs &>/dev/null
	then
	doexe programs/Xserver/Xigs
	fperms 4755 /usr/X11R6/bin/Xigs
	fi

	if vcards i810 &>/dev/null
	then
	doexe programs/Xserver/Xi810
	fperms 4755 /usr/X11R6/bin/Xi810
	fi

	if vcards mach64 &>/dev/null
	then
	doexe programs/Xserver/Xmach64
	fperms 4755 /usr/X11R6/bin/Xmach64
	fi

# These aren't working yet.
# We also need to install our startxvesa and startxfbdev scripts.
#	exeinto /usr/X11R6/bin
#	doexe ${FILESDIR}/startxvesa
#	doexe ${FILESDIR}/startxfbdev


	local M=${WORKDIR}/man
	if use fbdev &> /dev/null
	then
		doman -x11 ${M}/usr/X11R6/man/man1/Xfbdev.1x
	fi
	if [ -z "`vesa no`" ]
	then
		doman -x11 ${M}/usr/X11R6/man/man1/Xvesa.1x
	fi
	doman -x11 ${M}/usr/X11R6/man/man1/Xkdrive.1x

}

pkg_postinst() {

#	einfo "If you are using a Kdrive server other than Xvesa or Xfbdev,"
#	einfo "make a copy of /usr/X11R6/bin/startxvesa and set defaultserver"
#	einfo "to your Kdrive server."
#
#	if use vesa &> /dev/null
#	then
#		einfo "Use startxvesa to start the Xvesa Kdrive server."
#	fi
#
#	if use fbdev &> /dev/null
#	then
#		einfo "Use startxfbdev to start the Xfbdev Kdrive server."
#	fi
#
#	einfo "Edit /usr/X11R6/bin/startxvesa or /usr/X11R6/bin/startxfbdev"
#	einfo "defaultserverargs to your desired settings."
#	einfo "startx* scripts aren't working yet."
	einfo "Use something like \"xinit -- Xvesa :0 -screen 1280x1024x16\"."
	einfo "Your ~/.xinitrc will be used."
}
