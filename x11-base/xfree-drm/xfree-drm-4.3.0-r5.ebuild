# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree-drm/xfree-drm-4.3.0-r5.ebuild,v 1.1 2003/07/01 06:49:43 spyderous Exp $

# Small note:  we should prob consider using a DRM only tarball, as it will ease
#              some of the overhead on older systems, and will enable us to
#              update DRM if there are fixes not already in XFree86 tarballs ...

IUSE="3dfx gamma i8x0 matrox rage128 radeon sis"

# VIDEO_CARDS="3dfx gamma i810 i830 matrox rage128 radeon sis"

inherit eutils xfree

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
DEBUG="yes"
RESTRICT="nostrip"

SNAPSHOT="20030630"
PATCHVER="0.1"

S="${WORKDIR}/drm"
DESCRIPTION="Xfree86 Kernel DRM modules"
HOMEPAGE="http://www.xfree.org"
SRC_URI="mirror://gentoo/linux-drm-${PV}-kernelsource-${SNAPSHOT}.tar.gz
	mirror://gentoo/${PF}-gentoo-${PATCHVER}.tar.bz2"

# These sources come from one of these places:
#
#   http://www.xfree86.org/~alanh/ -- DRM snapshots, outdated 
#   http://people.debian.org/~daenzer/ -- full tree, often patched but
#	somewhat outdated
#   http://dri.sourceforge.net/snapshots/ -- daily CVS snapshots, lacking
#	gamma and sis
#   http://dri.sourceforge.net CVS -- full tree
#   http://cvs.sourceforge.net/cvstarballs/dri-cvsroot.tar.gz -- backup
#   rsync -avz --delete rsync://mefriss1.swan.ac.uk/dri/ -- temporary
#
# We throw all necessary files into one folder and turn that into our tarball.

SLOT="${KV}"
LICENSE="X11"
KEYWORDS="-x86 -ppc -alpha"

DEPEND=">=x11-base/xfree-${PV}
	virtual/linux-sources"

PROVIDE="virtual/drm"


VIDCARDS=""

if [ `use matrox || vcards matrox` ]
then
	VIDCARDS="${VIDCARDS} mga.o"
fi
if [ `use 3dfx || vcards 3dfx` ]
then
	VIDCARDS="${VIDCARDS} tdfx.o"
fi
if [ `use rage128 || vcards rage128` ]
then
	VIDCARDS="${VIDCARDS} r128.o"
fi
if [ `use radeon || vcards radeon` ]
then
	VIDCARDS="${VIDCARDS} radeon.o"
fi
if [ `use sis || vcards sis` ]
then
	VIDCARDS="${VIDCARDS} sis.o"
fi
if use i8x0 &>/dev/null
then
	VIDCARDS="${VIDCARDS} i810.o i830.o"
fi
if [ `use gamma || vcards gamma` ]
then
	VIDCARDS="${VIDCARDS} gamma.o"
fi

# Add VIDEO_CARDS functionality.
# Having a module twice (once from USE, once from VIDEO_CARDS)
# doesn't matter at all.
#vcards matrox &>/dev/null && VIDCARDS="${VIDCARDS} mga.o"
#vcards 3dfx &>/dev/null && VIDCARDS="${VIDCARDS} tdfx.o"
#vcards rage128 &>/dev/null && VIDCARDS="${VIDCARDS} r128.o"
#vcards radeon &>/dev/null && VIDCARDS="${VIDCARDS} radeon.o"
#vcards sis &>/dev/null && VIDCARDS="${VIDCARDS} sis.o"
#vcards gamma &>/dev/null && VIDCARDS="${VIDCARDS} gamma.o"
vcards i810 &>/dev/null && VIDCARDS="${VIDCARDS} i810.o"
vcards i830 &>/dev/null && VIDCARDS="${VIDCARDS} i830.o"

# This builds everything if none of the cards are in USE.
#if [ -z "${VIDCARDS}" ]
#then
#	if [ "${ARCH}" = "ppc" ]
#	then
#		VIDCARDS="r128.o radeon.o"
#	else
#		VIDCARDS="mga.o tdfx.o r128.o radeon.o sis.o i810.o i830.o gamma.o"
#	fi
#fi

src_unpack() {
	if [ ! -f /usr/src/linux/include/config/MARKER ] ; then
		die "Please compile kernel sources."
	fi

	if [ -z "${VIDCARDS}" ] ; then
		die "Please set at least one video card in VIDEO_CARDS. USE is deprecated. Possible VIDEO_CARDS values are matrox, 3dfx, rage128, radeon, sis, i810, i830, and gamma."
	fi

	unpack ${A}
	cd ${S}

	local PATCHDIR=${WORKDIR}/patch

	epatch ${PATCHDIR}/${PF}-gentoo-Makefile-fixup.patch
	epatch ${PATCHDIR}/${PF}-dristat.patch
}

src_compile() {
	check_KV
	ln -sf Makefile.linux Makefile
	einfo "Building DRM..."
	make ${VIDCARDS} \
		TREE="/usr/src/linux/include" KV="${KV}"
	make dristat || die
}

src_install() {

	einfo "installing DRM..."
	make \
		TREE="/usr/src/linux/include" \
		KV="${KV}" \
		DESTDIR="${D}" \
		MODS="${VIDCARDS}" \
		install || die
	dodoc README*
	exeinto /usr/X11R6/bin
	doexe dristat
}

pkg_postinst() {

	if [ "${ROOT}" = "/" ]
	then
		/sbin/modules-update
	fi

	einfo "USE is deprecated. Please set your video cards using VIDEO_CARDS."
	einfo "Possible VIDEO_CARDS values are matrox, 3dfx, rage128, radeon, sis, i810, i830, and gamma."

}
