# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree-drm/xfree-drm-4.3.0.ebuild,v 1.7 2003/04/21 23:14:27 seemant Exp $

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
KEYWORDS="x86"

DEPEND=">=x11-base/xfree-${PV}"

PROVIDE="virtual/drm"


VIDCARDS=""

if [ "`use matrox`" ]
then
	VIDCARDS="${VIDCARDS} mga.o"
elif [ "`use 3dfx`" ]
then
	VIDCARDS="${VIDCARDS} tdfx.o"
elif [ "`use rage128`" ]
then
	VIDCARDS="${VIDCARDS} r128.o"
elif [ "`use radeon`" ]
then
	VIDCARDS="${VIDCARDS} radeon.o"
elif [ "`use sis`" ]
then
	VIDCARDS="${VIDCARDS} sis.o"
elif [ "`use i8x0`" ]
then
	VIDCARDS="${VIDCARDS} i810.o i830.o"
elif [ "`use gamma`" ]
then
	VIDCARDS="${VIDCARDS} gamma.o"
else
	VIDCARDS=""
fi

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo-Makefile-fixup.patch
}

src_compile() {

	ln -sf Makefile.linux Makefile
	einfo "Building DRM..."
	if [ -z "${VIDCARDS}" ]
	then
		make  \
			TREE="/usr/src/linux/include" KV="${KVERS}"
	else
		make ${VIDCARDS} \
			TREE="/usr/src/linux/include" KV="${KVERS}"
	fi
}

src_install() {

	einfo "installing DRM..."
	if [ -z "${VIDCARDS}" ]
	then
		make \
			TREE="/usr/src/linux/include" \
			KV="${KVERS}" \
			DESTDIR="${D}" \
			install || die
	else
		make \
			TREE="/usr/src/linux/include" \
			KV="${KVERS}" \
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
