# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree-drm/xfree-drm-4.3.0-r4.ebuild,v 1.3 2003/06/29 08:02:39 spyderous Exp $

# Small note:  we should prob consider using a DRM only tarball, as it will ease
#              some of the overhead on older systems, and will enable us to
#              update DRM if there are fixes not already in XFree86 tarballs ...

IUSE="3dfx gamma i8x0 matrox rage128 radeon sis"

# XFREE_CARDS="3dfx gamma i810 i830 matrox rage128 radeon sis"

inherit eutils xfree

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
DEBUG="yes"
RESTRICT="nostrip"

SNAPSHOT="20030618"
PATCHVER="0.2"

S="${WORKDIR}/drm"
DESCRIPTION="Xfree86 Kernel DRM modules"
HOMEPAGE="http://www.xfree.org"
SRC_URI="mirror://gentoo/linux-drm-${PV}-kernelsource-${SNAPSHOT}.tar.gz
	mirror://gentoo/${PF}-gentoo-${PATCHVER}.tar.bz2"

# These sources come from one of four places:
#
#   http://www.xfree86.org/~alanh/ -- DRM snapshots, outdated 
#   http://people.debian.org/~daenzer/ -- full tree, often patched but
#	somewhat outdated
#   http://dri.sourceforge.net/snapshots/ -- daily CVS snapshots, lacking
#	gamma and sis
#   http://dri.sourceforge.net CVS -- full tree
#   http://cvs.sourceforge.net/cvstarballs/dri-cvsroot.tar.gz -- backup
#
# We throw all necessary files into one folder and turn that into our tarball.

SLOT="${KV}"
LICENSE="X11"
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND=">=x11-base/xfree-${PV}
	virtual/linux-sources"

PROVIDE="virtual/drm"


VIDCARDS=""

if use matrox &>/dev/null
then
	VIDCARDS="${VIDCARDS} mga.o"
fi
if use 3dfx &>/dev/null
then
	VIDCARDS="${VIDCARDS} tdfx.o"
fi
if use rage128 &>/dev/null
then
	VIDCARDS="${VIDCARDS} r128.o"
fi
if use radeon &>/dev/null
then
	VIDCARDS="${VIDCARDS} radeon.o"
fi
if use sis &>/dev/null
then
	VIDCARDS="${VIDCARDS} sis.o"
fi
if use i8x0 &>/dev/null
then
	VIDCARDS="${VIDCARDS} i810.o i830.o"
fi
if use gamma &>/dev/null
then
	VIDCARDS="${VIDCARDS} gamma.o"
fi

# Add XFREE_CARDS functionality.
# Having a module twice (once from USE, once from XFREE_CARDS)
# doesn't matter at all.

xcards matrox &>/dev/null && VIDCARDS="${VIDCARDS} mga.o"

xcards 3dfx &>/dev/null && VIDCARDS="${VIDCARDS} tdfx.o"

xcards rage128 &>/dev/null && VIDCARDS="${VIDCARDS} r128.o"

xcards radeon &>/dev/null && VIDCARDS="${VIDCARDS} radeon.o"

xcards sis &>/dev/null && VIDCARDS="${VIDCARDS} sis.o"

xcards i810 &>/dev/null && VIDCARDS="${VIDCARDS} i810.o"

xcards i830 &>/dev/null && VIDCARDS="${VIDCARDS} i830.o"

xcards gamma &>/dev/null && VIDCARDS="${VIDCARDS} gamma.o"

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
		die "Please set at least one video card in XFREE_CARDS. USE is deprecated."
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

	einfo "USE is deprecated. Please set your video cards using XFREE_CARDS."
	einfo "Possible XFREE_CARDS values are matrox, 3dfx, rage128, radeon, sis, i810, i830, and gamma."

}
