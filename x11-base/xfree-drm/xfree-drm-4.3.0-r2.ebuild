# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree-drm/xfree-drm-4.3.0-r2.ebuild,v 1.2 2003/04/23 02:27:18 lu_zero Exp $

# Small note:  we should prob consider using a DRM only tarball, as it will ease
#              some of the overhead on older systems, and will enable us to
#              update DRM if there are fixes not already in XFree86 tarballs ...

IUSE="3dfx gamma i8x0 matrox rage128 radeon sis"

inherit eutils

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
DEBUG="yes"
RESTRICT="nostrip"

SNAPSHOT="20030306"

S="${WORKDIR}/drm"
DESCRIPTION="Xfree86 Kernel DRM modules"
HOMEPAGE="http://www.xfree.org"
SRC_URI="mirror://gentoo/linux-drm-${PV}-kernelsource-${SNAPSHOT}.tar.gz"
# Latest tarball of DRM sources can be found here:
#
#   http://www.xfree86.org/~alanh/
#

LICENSE="X11"
SLOT="0"
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
if [ -z "${VIDCARDS}" -a "${ARCH}" = "ppc" ]
then
	VIDCARDS="r128.o radeon.o"
fi

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PF}-gentoo-Makefile-fixup.patch
	epatch ${FILESDIR}/${PF}-drm-ioremap.patch
	epatch ${FILESDIR}/${PF}-radeon-resume-v8.patch
}

src_compile() {
	check_KV
	ln -sf Makefile.linux Makefile
	einfo "Building DRM..."
	if [ -z "${VIDCARDS}" ]
	then
		make \
			TREE="/usr/src/linux/include" KV="${KV}"
	else
		make ${VIDCARDS} \
			TREE="/usr/src/linux/include" KV="${KV}"
	fi
}

src_install() {

	einfo "installing DRM..."
	if [ -z "${VIDCARDS}" ]
	then
		make \
			TREE="/usr/src/linux/include" \
			KV="${KV}" \
			DESTDIR="${D}" \
			install || die
	else
		make \
			TREE="/usr/src/linux/include" \
			KV="${KV}" \
			DESTDIR="${D}" \
			MODS="${VIDCARDS}" \
			install || die
	fi
	dodoc README*
}

pkg_postinst() {

	if [ "${ROOT}" = "/" ]
	then
		/sbin/modules-update
	fi
}
