# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree-drm/xfree-drm-4.3.0-r3.ebuild,v 1.3 2003/06/15 16:45:59 seemant Exp $

# Small note:  we should prob consider using a DRM only tarball, as it will ease
#              some of the overhead on older systems, and will enable us to
#              update DRM if there are fixes not already in XFree86 tarballs ...

IUSE="3dfx gamma i8x0 matrox rage128 radeon sis"

inherit eutils

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
DEBUG="yes"
RESTRICT="nostrip"

SNAPSHOT="20030504"

S="${WORKDIR}/drm"
DESCRIPTION="Xfree86 Kernel DRM modules"
HOMEPAGE="http://www.xfree.org"
SRC_URI="mirror://gentoo/linux-drm-${PV}-kernelsource-${SNAPSHOT}.tar.gz
	mirror://gentoo/${PF}-gentoo.tar.bz2"
# Latest tarball of DRM sources can be found here:
#
#   http://www.xfree86.org/~alanh/
# 
# We now use Daenzer's sources at http://people.debian.org/~daenzer/

SLOT="${KV}"
LICENSE="X11"
KEYWORDS="~x86 ~ppc ~alpha"

DEPEND=">=x11-base/xfree-${PV}
	virtual/linux-sources"

PROVIDE="virtual/drm"


VIDCARDS=""

if [ "`use matrox`" ]
then
	VIDCARDS="${VIDCARDS} mga.o"
fi
if [ "`use 3dfx`" ]
then
	VIDCARDS="${VIDCARDS} tdfx.o"
fi
if [ "`use rage128`" ]
then
	VIDCARDS="${VIDCARDS} r128.o"
fi
if [ "`use radeon`" ]
then
	VIDCARDS="${VIDCARDS} radeon.o"
fi
if [ "`use sis`" ]
then
	VIDCARDS="${VIDCARDS} sis.o"
fi
if [ "`use i8x0`" ]
then
	VIDCARDS="${VIDCARDS} i810.o i830.o"
fi
if [ "`use gamma`" ]
then
	VIDCARDS="${VIDCARDS} gamma.o"
fi
if [ -z "${VIDCARDS}" ]
then
	if [ "${ARCH}" = "ppc" ]
	then
		VIDCARDS="r128.o radeon.o"
	else
		VIDCARDS="mga.o tdfx.o r128.o radeon.o sis.o i810.o i830.o gamma.o"
	fi
fi

src_unpack() {
	if [ ! -f /usr/src/linux/include/config/MARKER ] ; then
		die "Please compile kernel sources"
	fi

	unpack ${A}
	cd ${S}

	local PATCHDIR=${WORKDIR}/patch

	epatch ${PATCHDIR}/${PF}-gentoo-Makefile-fixup.patch
	epatch ${PATCHDIR}/${PF}-drm-ioremap.patch
#	This patch is irrelevant but it was in Daenzer's stuff
#	epatch ${PATCHDIR}/${PF}-radeon-resume-v8.patch
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
}
